/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __MS_PORTS_H__
#define __MS_PORTS_H__

__sfr __at 0x01 KEYBOARD;
__sfr __at 0x02 MISC2;
__sfr __at 0x03 IRQ_MASK;
__sfr __at 0x04 UNKNOWN0x4;
__sfr __at 0x05 SLOT4_PAGE;
__sfr __at 0x06 SLOT4_DEV;
__sfr __at 0x07 SLOT8_PAGE;
__sfr __at 0x08 SLOT8_DEV;
__sfr __at 0x09 MISC9;		/* Printer ctrl, pwr ok, pwr btn */
__sfr __at 0x10 RTC_SEC;	/* BCD, ones place seconds */
__sfr __at 0x11 RTC_10SEC;	/* BCD, tens place seconds */
__sfr __at 0x12 RTC_MIN;	/* BCD, ones place minutes */
__sfr __at 0x13 RTC_10MIN;	/* BCD, tens place minutes */
__sfr __at 0x14 RTC_HR;		/* BCD, ones place hours */
__sfr __at 0x15 RTC_10HR;	/* BCD, tens place hours */
__sfr __at 0x16 RTC_DOW;	/* BCD, day of week */
__sfr __at 0x17 RTC_DOM;	/* BCD, ones place day of month */
__sfr __at 0x18 RTC_10DOM;	/* BCD, tens place day of month */
__sfr __at 0x19 RTC_MON;	/* BCD, ones place month */
__sfr __at 0x1A RTC_10MON;	/* BCD, tens place month */
__sfr __at 0x1B RTC_YR;		/* BCD, ones place years since 1980 */
__sfr __at 0x1C RTC_10YR;	/* BCD, tens place years since 1980 */
__sfr __at 0x1D RTC_CTRL1;	/* Unknown */
__sfr __at 0x1E RTC_CTRL2;	/* Unknown */
__sfr __at 0x1F RTC_CTRL3;	/* Unknown */

__sfr __at 0x21 PRINT_STATUS;	/* Unknown */
__sfr __at 0x22 PRINT_DDR;
__sfr __at 0x23 PRINT_DR;

__sfr __at 0x24 UNKNOWN0x28;

#define DEV_CF		0x00
#define DEV_RAM		0x01
#define DEV_LCD_L	0x02
#define DEV_DF		0x03
#define DEV_LCD_R	0x04
#define DEV_MODEM	0x05

#define MISC2_LCD_CASn	(1 << 3)

#endif
