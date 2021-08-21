/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __LOADRUN_H__
#define __LOADRUN_H__

#include <stdint.h>

uint16_t load_from_parport(volatile uint8_t *buf);
void loadrun_from_parport(void);
void loadrun_from_8000(void);
void loadrun_from_4000(void);

void sel_parport_msfw(void);
void sel_parport_wifi(void);
void sel_parport(void);

extern const struct opt_tbl loadrun_opts[];

#endif // __LOADRUN_H__
