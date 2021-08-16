/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2021 KBEmbedded */

/* Code derived from and intended to be compatible with jcs's WiFiStation:
 * Copyright (c) 2021 joshua stein <jcs@jcs.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <stdint.h>
#include <string.h>

#include "ms_ports.h"

/* XXX: Not yet sure if this is necessary, but is done in the wsloader code */
void wifi_parport_prepare(void)
{
	/* Set all control lines low */
	PAR_CTRL_DR &= ~(PAR_CTRL_MASK);
	PAR_CTRL_DDR |= PAR_CTRL_MASK;
}

/* Read a byte on parallel port */
/* Currently blocking, but, would like to implement it as a timeout
 * like msfw has */
uint16_t wifi_parport_read_byte(void)
{
	uint16_t ret;

	/* Sender will raise busy when ready to send data */
	while(!(PAR_STAT_DR & PAR_STAT_BUSYn));

	/* Set the data port as input */
	PAR_DAT_DDR = 0x00;

	/* MS will raise autofeed/linefeed as ACK */
	PAR_CTRL_DR |= PAR_CTRL_AUTFn;

	/* Wait for sender to lower busy when data is ready */
	while(PAR_STAT_DR & PAR_STAT_BUSYn);

	/* Read data from sender */
	ret = PAR_DAT_DR;

	/* Lower autofeed/linefeed to let sender know we've read data */
	PAR_CTRL_DR &= ~(PAR_CTRL_AUTFn);

	return ret;
}

/* Looks like this will return 0 in the case of a timeout? */
uint16_t wifi_parport_write_byte(uint8_t val)
{
	return (uint16_t)val;
}
