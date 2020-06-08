/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __PARPORT_H__
#define __PARPORT_H__

uint16_t msfw_parport_read_byte(void);
uint8_t msfw_parport_write_byte(uint8_t val);

#endif // __PARPORT_H__
