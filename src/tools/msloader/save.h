/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __SAVE_H__
#define __SAVE_H__

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

void loadsave_from_parport(void);

/* Use 0 to disable all channels */
uint8_t enable_channel_max(uint8_t max);
void self_write_to_app0(void);
void manage_dflash(void);
void chan_dis(void);
void chan_en0(void);
void chan_en1(void);
void chan_en2(void);
void chan_en3(void);
void chan_en4(void);
extern const struct opt_tbl manage_dflash_opts[];

void loadsave_to_0(void);
void loadsave_to_1(void);
void loadsave_to_2(void);
void loadsave_to_3(void);
void loadsave_to_4(void);

extern const struct opt_tbl loadsave_opts[];

#endif // __SAVE_H__
