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
__sfr __at 0x09 PAR_CTRL_DR;	/* Printer ctrl, pwr ok, pwr btn, data reg */
__sfr __at 0x0A PAR_CTRL_DDR;	/* Printer ctrl, pwr ok, pwr btn, data dir reg */
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

__sfr __at 0x21 PAR_STAT_DR;	/* Parallel port status reg, input only */
__sfr __at 0x2C PAR_DAT_DDR;	/* Parallel port data direction reg */
__sfr __at 0x2D PAR_DAT_DR;	/* Parallel port data reg */

__sfr __at 0x24 UNKNOWN0x28;

/* Devices that can be used in SLOTs */
#define DEV_CF		0x00
#define DEV_RAM		0x01
#define DEV_LCD_L	0x02
#define DEV_DF		0x03
#define DEV_LCD_R	0x04
#define DEV_MODEM	0x05

/* Parallel port defines/loc */
#define PAR_CTRL_STBn	(1 << 0)	// STROBE#
#define PAR_CTRL_AUTFn	(1 << 1)	// AUTO_FEED#/LINEFEED#
#define PAR_CTRL_RESET	(1 << 2)	// RESET
#define PAR_CTRL_SELn	(1 << 3)	// SELECT_PRINTER#
#define PAR_CTRL_MASK	(0x0F)		// Mask of all of the ctrl bits
#define PAR_STAT_ERROR	(1 << 3)	// ERROR (input only)
#define PAR_STAT_SEL	(1 << 4)	// SELECT
#define PAR_STAT_POUT	(1 << 5)	// PAPER_OUT
#define PAR_STAT_ACK	(1 << 6)	// ACK
#define PAR_STAT_BUSYn	(1 << 7)	// BUSY

#define MISC2_LCD_CASn	(1 << 3)

#endif
