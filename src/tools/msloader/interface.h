/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __INTERFACE_H__ 
#define __INTERFACE_H__ 

#include <stdint.h>

struct opt_tbl {
	char *string;
	void (*func)(void);
};

extern const struct opt_tbl *cur_opts;
extern uint8_t line;
extern uint8_t line_max;

void draw_header(void);
void draw_options(void);

#endif // __INTERFACE_H__ 
