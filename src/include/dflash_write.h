/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __DATAFLASH_H__
#define __DATAFLASH_H__

static void dflash_sdp_seq(void);

static void dflash_wait_write(void);

void dflash_unlock(void);

void dflash_lock(void);

uint8_t dflash_erase_sector(uint16_t adr);
void dflash_erase_chip(void);

uint8_t dflash_write_byte(uint16_t adr, uint8_t dat);
uint8_t dflash_write_sector(uint16_t adr, uint8_t *dat);
#endif // __DATAFLASH_H__
