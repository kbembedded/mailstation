/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* mslib headers */
#include <CFfuncs.h>
#include <dflash_write.h>
#include <graphics-textmode.h>
#include <lcd.h>
#include <led.h>
#include <ms_ports.h>
#include <msfw_parport.h>
#include <wifi_parport.h>

#include "interface.h"
#include "loadrun.h"
#include "save.h"

const struct opt_tbl loadsave_opts[] = {
	{ " Load binary and write to Channel 0 (limited to single 16kbyte page)\n", loadsave_to_0 },
	{ " Load binary and write to Channel 1 (limited to single 16kbyte page)\n", loadsave_to_1 },
	{ " Load binary and write to Channel 2 (limited to single 16kbyte page)\n", loadsave_to_2 },
	{ " Load binary and write to Channel 3 (limited to single 16kbyte page)\n", loadsave_to_3 },
	{ " Load binary and write to Channel 4 (limited to single 16kbyte page)\n", loadsave_to_4 },
	{ NULL, NULL },
};

const struct opt_tbl manage_dflash_opts[] = {
	{ " Disable all Channels (CAUTION! This will disable msloader!)\n", chan_dis },
	{ " Enable Channel 0\n", chan_en0 },
	{ " Enable Channel 0-1\n", chan_en1 },
	{ " Enable Channel 0-2\n", chan_en2 },
	{ " Enable Channel 0-3\n", chan_en3 },
	{ " Enable Channel 0-4\n", chan_en4 },
	{ NULL, NULL },
};

/* Use 0 to disable all channels */
uint8_t enable_channel_max(uint8_t max)
{
	uint8_t page, dev;
	uint8_t sect_buf[256];
	uint8_t ret = 0;

	page = SLOT8_PAGE;
	dev = SLOT8_DEV;

	if (SLOT4_DEV == DEV_DF) {
		g_textmode_init();
		printf("Error! Cannot modify channels when running from Dataflash\n");
		printf("Only call enable_channel_max() when running from RAM\n");
		lcd_update();
		msfw_delay(5000);
		__asm__ ("jp	0x4000");
	}

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 0x8;
	memset(sect_buf, '\0', 256);
	sect_buf[0x00] = max;
	sect_buf[0x09] = 0x18; // App 0x18 is DF 0
	sect_buf[0x0b] = 0x1;  // DF 1
	sect_buf[0x0f] = 0x19; // App 0x19 is DF 1
	sect_buf[0x11] = 0x2;
	sect_buf[0x15] = 0x1a;
	sect_buf[0x17] = 0x3;
	sect_buf[0x1b] = 0x1b;
	sect_buf[0x1d] = 0x4;  // DF 4
	sect_buf[0x21] = 0x1c; // App 0x1C is DF 4

	dflash_unlock();
	ret |= dflash_erase_sector(0x8000);
	ret |= dflash_write_sector(0x8000, sect_buf);
	dflash_lock();

	if (ret) {
		printf("Channel enable failed!\n");
	} else {
		printf("Channel enable successful!\n");
	}

	return ret;
}

void self_write_to_app0(void)
{
	uint16_t src_adr, dst_adr;
	uint8_t sect_buf[256];
	uint8_t ret = 0;
	volatile uint8_t *cur_channel = (uint8_t *)0x8000;

	g_textmode_init();
	printf("Writing self to DF, Mailstation App 0\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 0x0;

	dflash_unlock();

	src_adr = 0x4000;
	dst_adr = 0x8000;

	for (; dst_adr < 0xC000; ) {
		ret |= dflash_erase_sector(dst_adr);
		memcpy(sect_buf, (volatile uint8_t *)src_adr, 256);
		ret |= dflash_write_sector(dst_adr, sect_buf);
		src_adr = src_adr + 256;
		dst_adr = dst_adr + 256;
	}

	dflash_lock();

	SLOT8_PAGE = 0x8; // App management page
	/* Do this to fill out all app records */
	enable_channel_max(*cur_channel);

	if (ret) {
		printf("Write failed!\n");
	} else {
		printf("Write successful!\n");
	}

	printf("Powering off in 5 seconds\n");
	lcd_update();
	msfw_delay(5000);

	msfw_poweroff();
}


void manage_dflash(void)
{
	cur_opts = manage_dflash_opts;
	draw_header();
	draw_options();
}

/* XXX: Problem here is that, when running from DF, we can;t really
 * unlock/lock DF since the pattern has to come from DF reads.
 * It does not appear there is a good firmware function to handle this.
 * From exploration it looks like the only function that really does this
 * in firmware does a lot more, potentially is meant to write a whole
 * page at a time. Which would be great if so, but, would require more
 * exploration.
 *
 * so... lets do a quick hack!
 */ 
static void reload_ram_trampoline(void) __naked
{
	SLOT4_DEV = DEV_RAM;
	SLOT4_PAGE = 0x2;
	__asm__ ("ret");
}

void loadsave_common(uint8_t channel)
{
	uint8_t page, dev, ret = 0;
	unsigned int i;
	uint16_t len, dst_adr;
	uint8_t sect_buf[256];
	uint8_t *cur_channel = (uint8_t *)0x8000;


	/* If we're running from RAM (possible but unlikely) then skip this
	 * rewrite and trampoline */
	if (SLOT4_DEV != DEV_RAM) {
		/* RAMp1 will be in slot8 if msloader is run from DF.
		 * Rewrite ourselves to RAMp2 in slot8, then call the reload
		 * trampoline to put RAMp2 in slot4 and return back to this
		 * func. The result is changing execution to slot4 but RAM to
		 * preven spurious DF read patterns during unlock
		 */
		SLOT8_PAGE = 2;
		SLOT8_DEV = DEV_RAM;
		memcpy((uint8_t *)0x8000, (uint8_t *)0x4000, 0x4000);

		/* Clobber all of our graphics buffer, overkill, but its a known
		 * value that needs to be kept to. It beats trying to calculate the
		 * exact length of our trampoline.
		 */
		memcpy((uint8_t *)0xC010, reload_ram_trampoline, 0x1400);
		__asm__ ("call	0xC010");

		/* At this point, we... should be back to this function, still
		 * running from slot4, but from RAM rather than DF. Move RAMp1
		 * in to slot8 for working RAM */
		/* XXX: Should we save slot8 context above and restore it? */
		SLOT8_PAGE = 1;
		SLOT8_DEV = DEV_RAM;
	}

	g_textmode_init();

	/* Lets use display buffer because why not */
	/* TODO: Save slot and do something? */
	len = load_from_parport((volatile uint8_t *)0x8000);
	if (!len) {
		printf("Error! Loading timed out / no data received!\n");
		lcd_update();
		msfw_delay(5000);
		__asm__("jp	0x4000");
	}
	page = SLOT8_PAGE;
	dev = SLOT8_DEV;

	if (len & 0xFF) len = (len & ~(0xff)) + 0x100;
	/* Write the length of the file to DF channel */
	len = (len / 256);
	lcd_update();
	msfw_delay(2000);

	for (i = 0; i < len; i++) {
		dst_adr = (0x8000 + (i * 0x100));
		/* Copy 256 bytes to display buffer RAM */
		memcpy(sect_buf, (volatile uint8_t *)dst_adr, 0x100);

		/* Set up the correct channel page, erase sector, and write
		 * data from display butter to DF */
		SLOT8_PAGE = channel;
		SLOT8_DEV = DEV_DF;
		dflash_unlock();
		ret |= dflash_erase_sector(dst_adr);
		ret |= dflash_write_sector(dst_adr, sect_buf);
		lcd_update();
		dflash_lock();
		SLOT8_PAGE = page;
		SLOT8_DEV = dev;
	}

	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 8;
	/* While channels are numbered 0-4, the number of enabled channels
	 * is 0-5, with 0 being none and 1 being only channel 0. */
	channel++;
	if (channel > *cur_channel) {
		ret |= enable_channel_max(channel);
	}


	if (ret) {
		printf("Write of new app failed!\n");
	} else {
		printf("Write of new app successful!\n");
	}

	printf("Powering off in 5 seconds\n");
	lcd_update();
	msfw_delay(5000);
	msfw_poweroff();
}

void loadsave_to_0(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 0\n");
	lcd_update();
	loadsave_common(0);
}

void loadsave_to_1(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 1\n");
	lcd_update();
	loadsave_common(1);
}

void loadsave_to_2(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 2\n");
	lcd_update();
	loadsave_common(2);
}

void loadsave_to_3(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 3\n");
	lcd_update();
	loadsave_common(3);
}

void loadsave_to_4(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 4\n");
	lcd_update();
	loadsave_common(4);
}

void chan_en_common(uint8_t max)
{
	uint8_t ret;

	/* XXX: I _think_ that RAMp1 is always in slot8 when launching DF app
	 * need to verify this.
	 * Set up slot8 to be page 1 of RAM. We're going to rewrite ourself
	 * there, do the trampoline to move that in slot4, and then set
	 * slot8 to be RAMp2 for the actual loading process.
	 */
	SLOT8_PAGE = 2;
	SLOT8_DEV = DEV_RAM;
	memcpy((uint8_t *)0x8000, (uint8_t *)0x4000, 0x4000);

	/* Clobber all of our graphics buffer, overkill, but its a known
	 * value that needs to be kept to. It beats trying to calculate the
	 * exact length of our trampoline.
	 */
	memcpy((uint8_t *)0xC010, reload_ram_trampoline, 0x1400);
	__asm__ ("call	0xC010");

	g_textmode_init();
	ret = enable_channel_max(max);

	if (ret) {
		printf("Channel management failed!\n");
	} else {
		printf("Channel management successful!\n");
	}

	lcd_update();
	msfw_delay(5000);
	__asm__("jp	0x4000");
}

void chan_dis(void)
{
	chan_en_common(0);
}

void chan_en0(void)
{
	chan_en_common(1);
}

void chan_en1(void)
{
	chan_en_common(2);
}

void chan_en2(void)
{
	chan_en_common(3);
}

void chan_en3(void)
{
	chan_en_common(4);
}

void chan_en4(void)
{
	chan_en_common(5);
}

void loadsave_from_parport(void)
{
	cur_opts = loadsave_opts;
	draw_header();
	draw_options();
}
