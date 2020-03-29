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
 * ret at the end of it. The __nakes attribute is what allows this to work
 * from C.
 */
uint16_t msfw_parport_read_byte(void) __naked
{
	uint8_t slot8_dev, slot8_page;

	slot8_dev = SLOT8_DEV;
	slot8_page = SLOT8_PAGE;

	SLOT8_DEV = DEV_CF;
	SLOT8_PAGE = 0x01;

	__asm__ ("\n \
		push    de                                              \n \
		call    0x8027       ; Try to fetch a byte.             \n \
		ld      h, a   	                                        \n \
		                                                        \n \
		pop     de                                              \n \
	");

	SLOT8_DEV = slot8_dev;
	SLOT8_PAGE = slot8_page;

	__asm__ ("ret");
}
