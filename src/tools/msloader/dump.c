/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* mslib headers */
#include <CFfuncs.h>
#include <dflash_write.h>
#include <graphics-textmode.h>
#include <keyboard.h>
#include <lcd.h>
#include <led.h>
#include <ms_ports.h>
#include <msfw_parport.h>
#include <wifi_parport.h>

#include "dump.h"
#include "interface.h"
#include "parport_method.h"
#include "msloader.h"

#include "trampoline.bin.h"
#include "LDR.bin.h"

const struct opt_tbl dump_opts[] = {
	{ " Dump Dataflash (512 KiB) to parallel port\n", dump_dflash },
	{ " Dump Codeflash (1 MiB) to parallel port\n", dump_cflash },
	{ NULL, NULL },
};

const struct opt_tbl send_opts[] = {
	{ " Send self to parallel port with executable trampoline @ 0x8000\n", send_self_run_8000 },
	{ " Send self to parallel port\n", send_self_run_4000 },
	{ " Send app/channel 0 to parallel port\n", send_0 },
	{ " Send app/channel 1 to parallel port\n", send_1 },
	{ " Send app/channel 2 to parallel port\n", send_2 },
	{ " Send app/channel 3 to parallel port\n", send_3 },
	{ " Send app/channel 4 to parallel port\n", send_4 },
	{ NULL, NULL },
};

void dump_to_parport(void)
{
	cur_opts = dump_opts;
	draw_header();
	draw_options();
}

void send_to_parport(void)
{
	cur_opts = send_opts;
	draw_header();
	draw_options();
	printf("\nSend data to another MailStation, connected via LapLink cable.\n");
	printf("This includes the 2 byte header indicating size, however, for all options\n");
	printf("16384 bytes will be used since it cannot easily be known the actual size\n");
	printf("of the contents of self or the app/channel.\n");
}

void dump_pages(uint8_t pagecnt)
{
	uint8_t page;
	uint8_t *adr;

	for (page = 0; page < pagecnt; page++) {
		SLOT8_PAGE = page;
		for (adr = (uint8_t *)0x8000; adr < (uint8_t *)0xC000; adr++) {
			if (!(*parport_write_ptr)(*adr)) {
				printf("Timed out!\n");
				goto dump_pages_out;
			}
		}
	}

	printf("Done!\n");

dump_pages_out:
	lcd_update();
	msfw_delay(5000);
	__asm__ ("jp	0x4000");
}

void dump_dflash(void)
{
	g_textmode_init();
	printf("Dumping full dataflash ROM (512 KiB) over parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	dump_pages(32);
}

void dump_cflash(void)
{
	g_textmode_init();
	printf("Dumping full codeflash ROM (1 MiB) over parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_CF;
	dump_pages(64);
}

static void send_common(void)
{
	uint8_t *adr;

	/* Send 16385 as the byte count, LSB first */
	if (!(*parport_write_ptr)(0x00)) {
		printf("Timed out!\n");
		goto send_out;
	}

	if (!(*parport_write_ptr)(0x40)) {
		printf("Timed out!\n");
		goto send_out;
	}

	for (adr = (uint8_t *)0x8000; adr < (uint8_t *)0xC000; adr++) {
		if (!(*parport_write_ptr)(*adr)) {
			printf("Timed out!\n");
			goto send_out;
		}
	}

send_out:
	lcd_update();
	msfw_delay(5000);
	__asm__ ("jp	0x4000");
}

void send_self_run_8000(void)
{
	uint16_t adr;
	uint16_t end;

	g_textmode_init();
	printf("Sending self out parallel port w/ trampoline header\n\n");
	printf("On new MS, hold Fn+Shift+t (most), Fn+d, Fn+Shift+Size, Fn+Size+t, or Fn+q+a\n");
	printf("(type aq781206 @ prompt) and power on. Press Shift+F5 in Diag. menu\n");
	printf("Edit hex with g 710304x Back, Fn+s to enter/save&exit edit mode\n\n");
	printf("Write following bytes at 0x020000: 01 00 00 00 00 00 00 00 00 18\n\n");
	printf("Write the following bytes starting at 0x000000\n\n");
	for (end = 0; end < LDR_bin_len; ) {
		printf("%02X ", LDR_bin[end]);
		end++;
		if (!(end % 8)) printf("  ");
		if (!(end % 16)) putchar('\n');
	}
	printf("\nWARNING! This may clobber valid apps, see MailStation wiki for more info!");
	printf("\n\nPress any key to start transfer");
	lcd_update();
	kbd_flush();
	kbd_anykey();
	g_textmode_init();
	printf("Sending...\n");
	lcd_update();

	/* XXX: This is a repeat of send_common() code, this can probably be
	 * trimmed down to save space */

	/* Send 16385 as the byte count, LSB first */
	if (!(*parport_write_ptr)(0x00)) {
		printf("Timed out writing low sz byte!\n");
		goto self_out;
	}

	if (!(*parport_write_ptr)(0x40)) {
		printf("Timed out writing high sz byte!\n");
		goto self_out;
	}

	// XXX: Both of these appear to be broken!
	// rewrite with a better loop thats not doing stupid pointer things

	/* Send out the trampoline header */
	printf("Sending 0x%04X header bytes\n", trampoline_bin_len );
	lcd_update();
	for (adr = 0; adr < trampoline_bin_len; adr++) {
		if (!(*parport_write_ptr)(trampoline_bin[adr])) {
			printf("Timed out writing dat byte 0x%04X!\n", adr);
			goto self_out;
		}
	}

	/* Prep to followup and transfer self */
	/* Whatever device is mapped to SLOT4, remap to SLOT8 and then
	 * send that out. */
	SLOT8_DEV = SLOT4_DEV;
	SLOT8_PAGE = SLOT4_PAGE;
	adr = 0x8000;
	end = adr + 0x4000 - trampoline_bin_len;
	printf("Sending 0x%04X more bytes\n", end - adr);
	lcd_update();
	for (; adr < end; adr++) {
		if (!(*parport_write_ptr)(*(uint8_t *)adr)) {
			printf("Timed out writing dat byte 0x%04x!\n", adr);
			goto self_out;
		}
	}

self_out:
	lcd_update();
	msfw_delay(5000);
	__asm__ ("jp	0x4000");
}

void send_self_run_4000(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	/* Whatever device is mapped to SLOT4, remap to SLOT8 and then
	 * send that out. */
	SLOT8_DEV = SLOT4_DEV;
	SLOT8_PAGE = SLOT4_PAGE;
	send_common();
}

void send_0(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 0;
	send_common();
}

void send_1(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 1;
	send_common();
}

void send_2(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 2;
	send_common();
}

void send_3(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 3;
	send_common();
}

void send_4(void)
{
	g_textmode_init();
	printf("Sending data out parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 4;
	send_common();
}
