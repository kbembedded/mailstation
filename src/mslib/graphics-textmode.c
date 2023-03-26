/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <string.h>

#include "lcd.h"
#include "ms_ports.h"

#include "msfont_3x5.h"

static uint8_t x_pos, y_pos;
static uint8_t y_min, y_max, x_min, x_max;
static uint8_t invert;

void g_textmode_set_invert(uint8_t inv) { invert = inv ? 0xFF : 0x00; }
void g_textmode_set_ypos(uint8_t new_pos) { y_pos = new_pos; }
void g_textmode_set_xpos(uint8_t new_pos) { x_pos = new_pos; }
uint8_t g_textmode_get_ypos(void) { return y_pos; }
uint8_t g_textmode_get_xpos(void) { return x_pos; }

void g_textmode_clear_line(uint8_t line)
{
	uint8_t cnt;
	uint8_t *buf = (uint8_t *)0xc010;

	buf += (line * 6);

	for (cnt = 0; cnt < 40; cnt++) {
		memset(buf, invert, 6);
		buf += 0x80;
	}
}

void g_textmode_invert_line(uint8_t line)
{
	uint8_t cnt, i;
	uint8_t *buf = (uint8_t *)0xc010;

	buf += (line * 6);

	for (cnt = 0; cnt < 40; cnt++) {
		for (i = 0; i < 6; i++) {
			*buf = *buf ^ 0xFF;
			buf++;
		}
		buf += 0x80 - 6;
	}
}

static void g_textmode_scroll(void)
{
	uint8_t cnt;
	uint8_t *buf = (uint8_t *)0xc010;

	/* The magic number of 0x7A is 0x80 - 6 is the height of a column
	 * minus the height of a single char. */
	for (cnt = 0; cnt < 40; cnt++) {
		memcpy(buf, buf + 6, 0x80 - 6);
		buf += 0x80 - 6;
		memset(buf, invert, 6);
		buf += 6;
	}

}

int putchar(int val)
{
	uint8_t i;
	uint8_t *buf = (uint8_t *)0xc010;
	uint8_t line_buf;
	int translated_val;

	if (val == 0x00) return 0;

	if (val == '\n') {
		y_pos++;
		x_pos = 0;
	} else {
		buf += (((x_pos >> 1) * 0x80) + (y_pos * 6));
		translated_val = (val - 32) * 5;

		/* Odd characters in this font are the upper 4 bits.
		 * In each byte0wide line, it is the right character. */
		if ((x_pos & 1)) {
			for (i = 0; i < 5; i++) {
				line_buf = *buf;
				/* Clear upper 4 bits, leave lower */
				line_buf &= ~0xF0;
				line_buf |= (((invert ^ msfont_3x5_bin[(translated_val++)]) << 4) & 0xF0);
				*(buf++) = line_buf;
			}
		/* Even characters with this font are the lower 4 bits.
		 * For a given byte-wide line, the left character is the
		 * low nibble. */
		} else {
			for (i = 0; i < 5; i++) {
				line_buf = *buf;
				/* Clear lower 4 bits, leave upper */
				line_buf &= ~0x0F;
				line_buf |= ((invert ^ msfont_3x5_bin[(translated_val++)]) & 0x0F);
				*(buf++) = line_buf;
			}
		}

		x_pos++;
		if (x_pos > x_max) {
			y_pos++;
			x_pos = x_min;
		}
	}

	if (y_pos > y_max) {
		g_textmode_scroll();
		y_pos--;
	}

	return 0;
}

void g_textmode_init(void)
{
	/* Clear the display and reset our location pointer */
	lcd_buf_clr();
	x_pos = y_pos = 0;
	x_min = y_min = 0;
	x_max = 79;
	y_max = 20;
	/* XXX: Currently, the crt0-baremetal doesn't correctly init globals? */
	invert = 0;
}
