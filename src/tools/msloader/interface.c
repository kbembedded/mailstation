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

#include "interface.h"
#include "parport_method.h"


const struct opt_tbl *cur_opts;
uint8_t line;
uint8_t line_max;

void draw_header(void)
{
	g_textmode_init();
	g_textmode_set_ypos(1);
	g_textmode_set_xpos(24);
	g_textmode_set_invert(1);
	g_textmode_clear_line(0);
	g_textmode_clear_line(1);
	g_textmode_clear_line(2);
	printf("Mailstation Loader Utility v0.24\n\n");
	g_textmode_set_invert(0);
	g_textmode_set_ypos(17);
	printf("Parallel port method is set to: %s\n", parport_read_ptr == \
	  &msfw_parport_read_byte ? "msfw method" : "WiFiStation method");
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
