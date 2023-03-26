/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2023 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* mslib headers */
#include <graphics-textmode.h>
#include <lcd.h>
#include <ms_ports.h>

void ISR(void) __critical __interrupt(0)
{
	;
}

void mOS_init(void)
{
	lcd_init();

	/* Set RAM page 2 and 3 in slot4 and slot8 */
	SLOT4_DEV = DEV_RAM;
	SLOT4_PAGE = 2;
	SLOT8_DEV = DEV_RAM;
	SLOT8_PAGE = 3;

	KEYBOARD = 0;
	MISC2 = (MISC2_MDM_PWRn | MISC2_LCD_CASn);
	IRQ_MASK = 0;
	PAR_CTRL_DR = 0x0f;
	PAR_CTRL_DDR = 0x0f;
	UNKNOWN0xB = 0xff;
	OSC_CTRL = 0x30;	// No clue what this is doing at the moment
	RTC_CTRL3 |= 0x0c;	// Same
	CID_DR_Maybe = 0x0;
	CID_DDR_Maybe = 0x03;
	PAR_DAT_DDR = 0xff;
	TIMER_CTRL = 0x80;
}

void main(void) {

	mOS_init();
	g_textmode_init();
	MISC2 |= MISC2_LED;
	printf("Test\n");

	lcd_update();
	__asm__ ("halt");
}
