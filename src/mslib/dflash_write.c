/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>

#include "ms_ports.h"

static void dflash_sdp_seq(void)
{
	*(volatile uint8_t *)0x9823;
	*(volatile uint8_t *)0x9820;
	*(volatile uint8_t *)0x9822;
	*(volatile uint8_t *)0x8418;
	*(volatile uint8_t *)0x841B;
	*(volatile uint8_t *)0x8419;
}

/* Read a location twice and compare until both values match. This indicates
 * a write success */
static void dflash_wait_write(void)
{
	volatile uint8_t *dat = (volatile uint8_t *)0x8000;

	while ((*dat != *dat));
}

/* Can be run from any page */
void dflash_unlock(void)
{
	dflash_sdp_seq();
	*(volatile uint8_t *)0x841A;
}

void dflash_lock(void)
{
	dflash_sdp_seq();
	*(volatile uint8_t *)0x840A;
}

/* Command sequence according to datasheet is:
 *   Write 0x20 to any address
 *   Read from sector aligned address to erase
 *   Write 0xD0 to any address
 *   Wait for write completion marker
 *   Verify whole sector returns 0xFF
 */
uint8_t dflash_erase_sector(uint16_t adr)
{
	volatile uint8_t *buf;
	uint8_t i = 0;
	/* Addresses passed here _should_ be 256 byte aligned, but force them
	 * to be anyway. Not sure what the flash does when address is not
	 * aligned to sector/256byte. */
	adr = adr & 0xFF00;

	/* Ensure that address range is within 0x8000 - 0xBFFF, slot8. This
	 * is not something we can recover from here. */
	if (adr < 0x8000 || adr > 0xBFFF) return 1;

	buf = (uint8_t *)adr;

	/* Handle erase sequence and verify */
	*buf = 0x20;
	*buf;
	*buf = 0xD0;
	dflash_wait_write();

	do {
		if (*(buf++) != 0xFF) return 1;
		i++;
	} while(i);

	return 0;
}

/* Command sequence according to datasheet is:
 *   Write 0x10 to any address
 *   Write data to specified address
 *   Wait for write completion marker
 *   Verify written data matches requested data
 */
uint8_t dflash_write_byte(uint16_t adr, uint8_t dat)
{
	/* Ensure that address range is within 0x8000 - 0xBFFF, slot8. This
	 * is not something we can recover from here. */
	if (adr < 0x8000 || adr > 0xBFFF) return 1;

	/* Set up write and then write data */
	*(volatile uint8_t *)adr = 0x10;
	*(volatile uint8_t *)adr = dat;
	dflash_wait_write();

	/* Its slightly smaller code with SDCC to use this if block than to
	 * return the inverted comparison */
	if (dat == *(volatile uint8_t *)adr) return 0;
	else return 1;
}

/* Follows the same process as in write_byte, but does a full sector, slightly
 * more efficient */
uint8_t dflash_write_sector(uint16_t adr, uint8_t *dat)
{
	uint8_t i = 0;

	/* Addresses passed here _should_ be 256 byte aligned, fail if this
	 * is not the case as we cannot safely correct this. */
	if (adr & 0xFF) return 1;

	/* Ensure that address range is within 0x8000 - 0xBFFF, slot8. This
	 * is not something we can recover from here. */
	if (adr < 0x8000 || adr > 0xBFFF) return 1;

	do {
		/* Set up write and then write data */
		*(volatile uint8_t *)adr = 0x10;
		*(volatile uint8_t *)(adr++) = *(dat++);
		dflash_wait_write();
		i++;
	} while (i);

	/* Verify written data */
	dat = dat - 256;
	adr = adr - 256;
	do {
		if (*(dat++) != *(volatile uint8_t *)(adr++)) return 1;
	} while (i);

	return 0;
}

# if 0
void dflash_erase_chip(void)
{
	volatile uint8_t *dat = (volatile uint8_t *)0x8000;

	*dat = 0x30;
	*dat = 0x30;
	dflash_wait_write();

	/* Add verification */
}
#endif
