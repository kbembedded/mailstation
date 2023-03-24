/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __DFLASH_APP_H__
#define __DFLASH_APP_H__

#include <stdint.h>

typedef const struct dataflash_name {
	uint16_t unknown;	// Unknown meaning, should be 0x0001
	uint16_t name_len;	// Length of name, not including \0!
	uint16_t name_start;	// Relative to start of struct, likely always 0x0006
	uint16_t name_len2;	// Length of name, not including \0!
	uint16_t name_start2;	// Relative to start of struct, likely always 0x0006
	char name[];		// Unsure of useful effective length
} dataflash_name;

typedef const struct dataflash_icon_no_icon1 {
	uint16_t icon0_size;	// This will likely always be 0x00AD
	uint16_t icon0_start;	// Start of icon0_width, likely always 0x0008
	uint16_t icon1_size;	// This will likely always be 0x0000
	uint16_t icon1_start;	// This is relative to the start of the struct

	uint16_t icon0_width;	// This will likely always be 0x0022 (34)
	uint8_t icon0_height;	// This will likely always be 0x0022 (34)
	uint8_t icon0[][];	// 34 rows, 5 bytes each, to represent 34x34
} dataflash_icon_no_icon1;


#endif // __DFLASH_APP_H__
