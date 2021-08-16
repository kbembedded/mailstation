/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2021 KBEmbedded */

#ifndef __WIFI_PARPORT_H__
#define __WIFI_PARPORT_H__

void wifi_parport_prepare(void);
uint16_t wifi_parport_read_byte(void);
uint8_t wifi_parport_write_byte(uint8_t val);

#endif // __WIFI_PARPORT_H__
