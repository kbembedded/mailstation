/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <string.h>

#include "ms_ports.h"

/* Read a byte from the parallel port using tribbles.
 *
 * Returns 16-bits. The upper 8-bits, if non-zero, means the lower 8-bits are
 * a valid data byte read from the parallel port. If upper 8-bits are 0, then
 * there was a timeout on the parallel port.
 *
 * Written in assembly because of the calling convention necessary. This func
 * lives in CFp01, and normally is called when mapped to slot8.
 *
 * Calling the msfw function at 0x8027 will return a byte from the parport
 * in L register, with the A register being 0 if there was a timeout.
 * The __naked attribute means we need to handle saving registers, sdcc
 * generates no prologue/epilogue code. sdcc uses the HL register pair to
 * return 16-bits which is what already occurs, so this can just
 * ret at the end of it. The __naked attribute is what allows this to work
 * from C.
 *
 * NOTE: The MS firmware function uses some hard-coded RAM, 0xE3AC to store
 * temporary bytes. These functions might not be safe for all use.
 */
static uint16_t pp_rb_asm(void) __naked
{
	__asm
		call	0x8027		; Try to fetch a byte.
		ld	h, a		; Put return flag in to upper byte
					; the actual value is already set in L
		ret
	__endasm;
}

uint16_t msfw_parport_read_byte(void)
{
	uint8_t slot8_dev, slot8_page;
	uint16_t ret;

	slot8_dev = SLOT8_DEV;
	slot8_page = SLOT8_PAGE;

	SLOT8_DEV = DEV_CF;
	SLOT8_PAGE = 0x01;

	ret = pp_rb_asm();

	SLOT8_DEV = slot8_dev;
	SLOT8_PAGE = slot8_page;

	return ret;
}

static uint16_t pp_wb_asm(uint8_t val) __naked
{
	__asm
		ld	hl, #2
		add	hl, sp
		ld	a, (hl)
		ld	h, a		; All of that to put sp+2 in
					; to h
		call	0x802d		; Send byte to parport
		ld	h, a		; Put return flag in to upper byte
					; the actual value is already set in L
		ret
	__endasm;

	/* Reference the func arg in C to remove warnings about it */
	val;
}

/* Looks like this will return 0 in the case of a timeout? */
uint16_t msfw_parport_write_byte(uint8_t val)
{
	uint8_t slot8_dev, slot8_page;
	uint16_t ret;

	slot8_dev = SLOT8_DEV;
	slot8_page = SLOT8_PAGE;

	SLOT8_DEV = DEV_CF;
	SLOT8_PAGE = 0x01;

	ret = pp_wb_asm(val);

	SLOT8_DEV = slot8_dev;
	SLOT8_PAGE = slot8_page;

	return ret;
}
