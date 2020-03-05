/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __LED_H__
#define __LED_H__

#define msfw_set_led(x) ((void (*)(uint16_t)) 0x0A77)(x)
void set_led(char val);

#endif
