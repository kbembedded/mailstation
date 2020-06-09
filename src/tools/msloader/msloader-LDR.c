/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <string.h>

#include "led.h"
#include "ms_ports.h"

extern uint8_t end_of_file;

void main(void) {
	uint8_t cnt = 1;
	uint8_t slot4_dev, slot4_page;
	uint8_t *stage2_start = &end_of_file;

	/* Save the current slot 4 setup. Its guaranteed to be DEV_DF
	 * (at least it should always be, if not, something is wrong),
	 * but the page will be variable. Repurpose slot 4 with RAM,
	 * to be safe, we'll take the current slot8 page +1. In most
	 * situations, it will be RAMp01 because RAMp00 is static slotC.
	 */
	slot4_dev = SLOT4_DEV;
	slot4_page = SLOT4_PAGE;

	SLOT4_DEV = DEV_RAM;
	SLOT4_PAGE = SLOT8_PAGE + 1;

	/* NOTE: The correct way to do this would be to copy 0x4000 -
	 * <len_of_stage1> bytes, however, since end_of_file is an extern,
	 * sdcc kind of freaks out and doesn't emit LDIR opcodes and instead
	 * ends up doing a very complex copy. In any case, it works, its just
	 * ugly. There is probably a better way of doing this that I'm not
	 * aware of.
	 */
	memcpy((uint8_t *)0x4000, stage2_start, 0x4000);
	__asm__ ("jp	0x4000");
}
