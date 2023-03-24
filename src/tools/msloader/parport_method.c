/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#include <stdint.h>
#include <stdio.h>
#include <string.h>

/* mslib headers */
#include <CFfuncs.h>
#include <ms_ports.h>
#include <msfw_parport.h>
#include <wifi_parport.h>

#include "interface.h"
#include "msloader.h"
#include "parport_method.h"

/* Set up function pointers fot selecting which parport method to use */
uint16_t (*parport_read_ptr)(void) = &msfw_parport_read_byte;
uint16_t (*parport_write_ptr)(uint8_t) = &msfw_parport_write_byte;

const struct opt_tbl parport_opts[] = {
	{ " Use msfw parallel port method (tribbles) [default]\n", sel_parport_msfw },
	{ " Use WiFiStation parallel port method (bytes)\n", sel_parport_wifi },
	{ NULL, NULL },
};

void sel_parport_msfw(void)
{
	//XXX: May need to change parport ctrl line states here?
	parport_read_ptr = &msfw_parport_read_byte;
	parport_write_ptr = &msfw_parport_write_byte;
	go_to_main();
}

void sel_parport_wifi(void)
{
	parport_read_ptr = &wifi_parport_read_byte;
	parport_write_ptr = &wifi_parport_write_byte;
	go_to_main();
}

void sel_parport(void)
{
	cur_opts = parport_opts;
	draw_header();
	draw_options();
}
