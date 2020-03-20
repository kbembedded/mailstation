/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <string.h>

#include "ms_ports.h"

void lcd_buf_clr(void)
{
	memset((uint8_t *)0xC010, 0x00, 0x1400);
}

/* Update 0xA00 bytes of LCD screen from RAM buffer
 *
 * Based on MS firmware code. This updates half of the LCD starting from buf
 * for 0xA00 bytes.
 *
 * This function expects to have the correct LCD half already set in slot8
 */
static void lcd_update_half(uint8_t *buf)
{
	volatile uint8_t *row_addr = (uint8_t *)0x8038;
	uint8_t col_addr = 0x14;

	do {
		/* HACK! Disable interrupts while we do this since MS ISR
		 * wants to use a shadow register for P2! */
		__asm__ ("di");
		MISC2 &= ~MISC2_LCD_CASn;
		*row_addr = (--col_addr);
		MISC2 |= MISC2_LCD_CASn;
		__asm__ ("ei");

		memcpy(row_addr, buf, 0x80);

		buf += 0x80;
	} while (col_addr);

}


/* Update LCD display from RAM buffer starting at 0xC010
 *
 * Based on the MS firmware code which exists in different ROM locations on
 * different firmware revisions. As the LCD is two separate devices, each half
 * of the LCD needs to be updated separately from different offsets in the
 * buffer. The buffer address is the same as the MS firmware.
 *
 * This function will set and restore slot8 device.
 */
void lcd_update(void)
{
	uint8_t slot8_dev;

	slot8_dev = SLOT8_DEV;

	SLOT8_DEV = DEV_LCD_L;
	lcd_update_half((uint8_t *)0xC010);
	SLOT8_DEV = DEV_LCD_R;
	lcd_update_half((uint8_t *)0xCA10);

	SLOT8_DEV = slot8_dev;
}
