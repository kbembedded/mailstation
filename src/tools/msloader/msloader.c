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

#include "msloader-app_info.h"

#include "interface.h"
#include "parport_method.h"
#include "save.h"
#include "loadrun.h"
#include "dump.h"


static struct opt_tbl main_opts[] = {
	{ " Load binary and execute...\n", loadrun_from_parport },
	{ " Load binary and write to Dataflash...\n", loadsave_from_parport },
	{ " Dump flash...\n", dump_to_parport },
	{ " Send flash...\n", send_to_parport },
	{ " Select parallel method...\n", sel_parport },
	{ " Manage Dataflash...\n", manage_dflash },
	{ " Reboot Mailstation\n", restart },
	{ " Power off Mailstation\n", poweroff },
	{ " Free-type mode\n", freetype },
	{ NULL, NULL },
};

static struct opt_tbl ram_opts[] = {
	{ " Detected that Loader is currently running from RAM, write self to App 0\n", self_write_to_app0 },
	{ " Skip this for now\n", go_to_main },
	{ NULL, NULL },
};

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

void go_to_main(void)
{
	cur_opts = main_opts;
	draw_header();
	draw_options();
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
