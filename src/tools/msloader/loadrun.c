/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* mslib headers */
#include <CFfuncs.h>
#include <ms_ports.h>
#include <graphics-textmode.h>
#include <lcd.h>
#include <msfw_parport.h>
#include <wifi_parport.h>

#include "loadrun.h"
#include "interface.h"
#include "parport_method.h"

const struct opt_tbl loadrun_opts[] = {
	{ " Load to RAM and execute from 0x4000 (limited to single 16kbyte page)\n", loadrun_from_4000 },
	{ " Load to RAM and execute from 0x8000 (limited to single 16kbyte page)\n", loadrun_from_8000 },
	{ NULL, NULL },
};

void loadrun_from_parport(void)
{
	cur_opts = loadrun_opts;
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
			ret = (*parport_read_ptr)();
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
			ret = (*parport_read_ptr)();
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

void loadrun_from_8000(void)
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

void load_4000_trampoline(void) __naked
{
	SLOT4_DEV = DEV_RAM;
	SLOT4_PAGE = 0x1;
	__asm__ ("jp	0x4000");
}

void loadrun_from_4000(void)
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
