/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __PARPORT_METHOD_H__
#define __PARPORT_METHOD_H__

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "CFfuncs.h"
#include "ms_ports.h"
#include "msfw_parport.h"
#include "wifi_parport.h"


void sel_parport_msfw(void);
void sel_parport_wifi(void);
void sel_parport(void);

extern uint16_t (*parport_read_ptr)(void);
extern uint16_t (*parport_write_ptr)(uint8_t);

extern const struct opt_tbl parport_opts[];

#endif // __PARPORT_METHOD_H__
