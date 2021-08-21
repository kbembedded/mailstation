/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */
#ifndef __DUMP_H__
#define __DUMP_H__

#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "CFfuncs.h"
#include "dflash_write.h"
#include "graphics-textmode.h"
#include "lcd.h"
#include "led.h"
#include "ms_ports.h"
#include "msfw_parport.h"
#include "wifi_parport.h"

void dump_to_parport(void);
void dump_dflash(void);
void dump_cflash(void);
void send_to_parport(void);
void send_self_run_8000(void);
void send_self_run_4000(void);
void send_0(void);
void send_1(void);
void send_2(void);
void send_3(void);
void send_4(void);

extern const struct opt_tbl dump_opts[];

extern const struct opt_tbl send_opts[];


#endif // __DUMP_H__
