/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "CFfuncs.h"
#include "dflash_write.h"
#include "graphics-textmode.h"
#include "keyboard.h"
#include "lcd.h"
#include "led.h"
#include "ms_ports.h"
#include "parport.h"

#include "msloader-app_info.h"

struct opt_tbl {
	char *string;
	void (*func)(void);
};
static struct opt_tbl *cur_opts;

static void restart(void)
{
	/* XXX: Is there a better way to do this? */
	/* SDCC doesn't like when you use sdasz80 notation of #0x0000 */
	__asm__ ("jp	0x0000");
}

static void poweroff(void)
{
	msfw_poweroff();
}

static void donothing(void)
{
	;
}

static void freetype(void)
{
	uint8_t scancode_buf[2];
	uint8_t scancode_buf_q = 0;
	uint8_t decode;

	g_textmode_init();
	printf("Free type mode, will just echo back characters.\n");
	printf("Press the \"Back\" key to return to the main menu\n");
	lcd_update();

	while (1) {
		while (!msfw_get_scancode(scancode_buf));
		if ((scancode_buf[1] & 0x1) && (scancode_buf_q != scancode_buf[0])) {
			scancode_buf_q = scancode_buf[0];
			decode = (scancode_buf[0] & 0x7) | ((scancode_buf[0] & 0xF0) >> 1);
			if (scancode_buf[1] & 0x40) decode += 80;
			putchar(scode_lower[decode]);
			if (scancode_buf[0] == 0x01) {
				__asm__ ("jp	0x4000");
			}
			lcd_update();
		} else {
			scancode_buf_q = 0;
		}
	}
}

static void self_write_to_app0(void)
{
	uint16_t src_adr, dst_adr;
	uint8_t sect_buf[256];
	uint8_t ret = 0;

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

uint8_t line;
uint8_t line_max;

void draw_header(void);
void draw_options(void);
static void loadrun_from_parport(void);
static void loadrun_from_8000(void);
static void loadrun_from_4000(void);
static void loadsave_from_parport(void);
static void loadsave_to_0(void);
static void loadsave_to_1(void);
static void loadsave_to_2(void);
static void loadsave_to_3(void);
static void loadsave_to_4(void);
static void dump_to_parport(void);
static void dump_dflash(void);
static void dump_cflash(void);
static void manage_dflash(void);
static void go_to_main(void);

static void manage_dflash(void) {
	;
	/* Clean this up later */
}

static struct opt_tbl main_opts[] = {
	{ " Load binary and execute...\n", loadrun_from_parport },
	{ " Load binary and write to Dataflash...\n", loadsave_from_parport },
	{ " Dump flash...\n", dump_to_parport },
	{ " Reboot Mailstation\n", restart },
	{ " Manage Dataflash...\n", manage_dflash },
	{ " Power off Mailstation\n", poweroff },
	{ " Free-type mode\n", freetype },
	{ NULL, NULL },
};

static void go_to_main(void)
{
	cur_opts = main_opts;
	draw_header();
	draw_options();
}

static struct opt_tbl ram_opts[] = {
	{ " Detected that Loader is currently running from RAM, write self to App 0\n", self_write_to_app0 },
	{ " Skip this for now\n", go_to_main },
	{ NULL, NULL },
};

static struct opt_tbl loadrun_opts[] = {
	{ " Load to RAM and execute from 0x4000 (limited to single 16kbyte page)\n", loadrun_from_4000 },
	{ " Load to RAM and execute from 0x8000 (limited to single 16kbyte page)\n", loadrun_from_8000 },
	{ NULL, NULL },
};

static void loadrun_from_parport(void)
{
	cur_opts = loadrun_opts;
	draw_header();
	draw_options();
}

static struct opt_tbl loadsave_opts[] = {
	{ " Load binary and write to Channel 0 (limited to single 16kbyte page)\n", loadsave_to_0 },
	{ " Load binary and write to Channel 1 (limited to single 16kbyte page)\n", loadsave_to_1 },
	{ " Load binary and write to Channel 2 (limited to single 16kbyte page)\n", loadsave_to_2 },
	{ " Load binary and write to Channel 3 (limited to single 16kbyte page)\n", loadsave_to_3 },
	{ " Load binary and write to Channel 4 (limited to single 16kbyte page)\n", loadsave_to_4 },
	{ NULL, NULL },
};

static void loadsave_from_parport(void)
{
	cur_opts = loadsave_opts;
	draw_header();
	draw_options();
}

static struct opt_tbl dump_opts[] = {
	{ " Dump Dataflash (512 KiB) to parallel port\n", dump_dflash },
	{ " Dump Codeflash (1 MiB) to parallel port\n", dump_cflash },
	{ NULL, NULL },
};

static void dump_to_parport(void)
{
	cur_opts = dump_opts;
	draw_header();
	draw_options();
}

uint16_t load_from_parport(volatile uint8_t *buf)
{
	uint16_t ret;
	uint8_t i;
	uint8_t timeout;
	uint16_t len = 0, len_q;

	/* Its possible we're running from RAM, but unlikely. Regardless, this
	 * would mean we're in page 2 of RAM due to the stage 1 loading
	 * process. Lets load up page 1 as this should be free.
	 */

	SLOT8_DEV = DEV_RAM;
	SLOT8_PAGE = 0x1;

	for (i = 0; i < 2; i++) {
		timeout = 0;
		while(1) {
			ret = msfw_parport_read_byte();
			if (ret & 0xFF00) {
				len = len >> 8;
				len |= ((ret & 0xFF) << 8);
				break;
			} else {
				timeout++;
				if (timeout == 11) return 0;
			}
		}
	}

	if (len > 0x4000) {
		printf("Binary being sent is greater than 16 KiB, aborting!\n");
		lcd_update();
		msfw_delay(5000);
		__asm__ ("jp	0x4000");
	}

	/* This printf, since not a static string, includes a lot
	 * of overhead in the sdcc library to support it */
	printf("Expecting binary that is %05d bytes long\n", len);
	lcd_update();
	len_q = len;
	for (; len; len--) {
		timeout = 0;
		while(1) {
			ret = msfw_parport_read_byte();
			if (ret & 0xFF00) {
				*(buf++) = (ret & 0xFF);
				break;
			} else {
				timeout++;
				if (timeout == 11) return 0;
			}
		}
	}

	return len_q;
}

static void loadrun_from_8000(void)
{
	g_textmode_init();
	printf("Loading binary to 0x8000 and executing\n");
	lcd_update();

	if (!load_from_parport((volatile uint8_t *)0x8000)) {
		printf("Error! Loading timed out / no data received!\n");
		lcd_update();
		msfw_delay(5000);
		__asm__ ("jp	0x4000");
	}

	__asm__ ("jp	0x8000");
}

static void load_4000_trampoline(void) __naked
{
	SLOT4_DEV = DEV_RAM;
	SLOT4_PAGE = 0x1;
	__asm__ ("jp	0x4000");
}

static void loadrun_from_4000(void)
{
	g_textmode_init();
	printf("Loading binary to 0x4000 and executing\n");
	lcd_update();

	if (!load_from_parport((volatile uint8_t *)0x8000)) {
		printf("Error! Loading timed out / no data received!\n");
		lcd_update();
		msfw_delay(5000);
		__asm__ ("jp	0x4000");
	}

	/* Clobber all of our graphics buffer, overkill, but its a known
	 * value that needs to be kept to. It beats trying to calculate the
	 * exact length of our trampoline.
	 */
	memcpy((uint8_t *)0xC010, load_4000_trampoline, 0x1400);
	__asm__ ("jp	0xC010");
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

	/* At this point, we... should be back to normal? */
	SLOT8_PAGE = 1;
	SLOT8_DEV = DEV_RAM;

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

	printf("len %d\n", len);
	if (len & 0xFF) len = (len & ~(0xff)) + 0x100;
	/* Write the length of the file to DF channel */
	len = (len / 256);
	printf("len %d\n", len);
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
		printf("wrote sect %d\n", i);
		lcd_update();
		dflash_lock();
		SLOT8_PAGE = page;
		SLOT8_DEV = dev;
	}

#if 0
	/* TODO: Enable channel if not already. Theres probably a firmware func
	 * to do this already */
	SLOT8_DEV = DEV_DF;
	SLOT8_PAGE = 8;
	memcpy((uint8_t *)0xc010, 0x8000, 256);
	if ((uint8_t *)0xc010 < channel) {
		/* TODO: Enable channel here
		 * likely no bounds checking at first, whatever */
	}
#endif

	g_textmode_init();

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

static void loadsave_to_0(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 0\n");
	lcd_update();
	loadsave_common(0);
}

static void loadsave_to_1(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 1\n");
	lcd_update();
	loadsave_common(1);
}

static void loadsave_to_2(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 2\n");
	lcd_update();
	loadsave_common(2);
}

static void loadsave_to_3(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 3\n");
	lcd_update();
	loadsave_common(3);
}

static void loadsave_to_4(void)
{
	g_textmode_init();
	printf("Loading binary and saving to Channel/App 4\n");
	lcd_update();
	loadsave_common(4);
}


void dump_pages(uint8_t pagecnt)
{
	uint8_t page;
	uint8_t *adr;

	for (page = 0; page < pagecnt; page++) {
		SLOT8_PAGE = page;
		for (adr = (uint8_t *)0x8000; adr < (uint8_t *)0xC000; adr++) {
			if (!msfw_parport_write_byte(*adr)) {
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

static void dump_dflash(void)
{
	g_textmode_init();
	printf("Dumping full dataflash ROM (512 KiB) over parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_DF;
	dump_pages(32);
}

static void dump_cflash(void)
{
	g_textmode_init();
	printf("Dumping full codeflash ROM (1 MiB) over parallel port\n");
	lcd_update();

	SLOT8_DEV = DEV_CF;
	dump_pages(64);
}

void draw_header(void)
{
	g_textmode_init();
	g_textmode_set_ypos(1);
	g_textmode_set_xpos(24);
	g_textmode_set_invert(1);
	g_textmode_clear_line(0);
	g_textmode_clear_line(1);
	g_textmode_clear_line(2);
	printf("Mailstation Loader Utility v0.21test5\n\n");
	g_textmode_set_invert(0);
	g_textmode_set_ypos(19);
	printf("Navigate with \'h\' \'j\' \'k\' and \'l\'\n");
}

void draw_options(void)
{
	uint8_t i;

	g_textmode_set_ypos(4);
	for (i = 0; cur_opts[i].string != NULL; i++) {
		/* This printf, since not a static string, includes a lot
		 * of overhead in the sdcc library to support it */
		printf(cur_opts[i].string);
	}
	g_textmode_invert_line(4);
	line = 4;
	line_max = i + 3;
}

void main(void) {
	uint8_t *buf = (uint8_t *)0xc010;
	uint8_t scancode_buf[2];
	uint8_t scancode_buf_q = 0;
	uint8_t decode;


	/* Since this is built to run from 0x4000, check slot4. If its RAM
	 * then we need to write ourselves to dataflash app 0.
	 * TODO: Implement more intelligent handling of this.
	 */
	if (SLOT4_DEV == DEV_RAM) {
		cur_opts = ram_opts;
	} else {
		cur_opts = main_opts;
	}

	draw_header();
	draw_options();


	while(1) {
		while (!msfw_get_scancode(scancode_buf));
		if ((scancode_buf[1] & 0x1) && (scancode_buf_q != scancode_buf[0])) {
			scancode_buf_q = scancode_buf[0];
			decode = (scancode_buf[0] & 0x7) | ((scancode_buf[0] & 0xF0) >> 1);
			if (scancode_buf[1] & 0x40) decode += 80;
			//putchar(scode_lower[decode]);
			switch (scode_lower[decode]) {
			  case 'h': // Reset to main menu
				__asm__ ("jp	0x4000");
				break;
			  case 'j': // Down
				g_textmode_invert_line(line);
				line++;
				if (line > line_max) line = 4;
				g_textmode_invert_line(line);
				break;
			  case 'k': // Up
				g_textmode_invert_line(line);
				line--;
				if (line < 4) line = line_max;
				g_textmode_invert_line(line);
				break;
			  case 'l': // Select
				cur_opts[line-4].func();
				break;
			  default:  // Shrug
				break;
			}
		} else {
			scancode_buf_q = 0;
		}


		lcd_update();
		__asm__ ("halt");
	}
}
