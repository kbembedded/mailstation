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

#include "CFfuncs.h"
#include "ms_ports.h"

/* XXX: This is necessary to do before using the wifistation method,
 * It may be possible to track down a CF func that does essentially this */
void wifi_parport_prepare(void)
{
	/* Set all control lines low */
	PAR_CTRL_DR &= ~(PAR_CTRL_MASK);
	PAR_CTRL_DDR |= PAR_CTRL_MASK;
}

/* Read a byte on parallel port */
/* Will timeout after 1s if no data received */
uint16_t wifi_parport_read_byte(void)
{
	uint16_t ret;
	uint16_t cnt = 1000;

	wifi_parport_prepare();

	/* Sender will raise busy when ready to send data */
	while(!(PAR_STAT_DR & PAR_STAT_BUSYn)) {
		msfw_delay(1);
		cnt--;
		if(cnt == 0) return 0;
	}

	/* Set the data port as input */
	PAR_DAT_DDR = 0x00;

	/* MS will raise autofeed/linefeed as ACK */
	PAR_CTRL_DR |= PAR_CTRL_AUTFn;

	/* Wait for sender to lower busy when data is ready */
	while(PAR_STAT_DR & PAR_STAT_BUSYn);

	/* Read data from sender */
	ret = (uint16_t)PAR_DAT_DR;
	/* Set upper byte to 0xFF to mimic msfw_parport_read_byte setting
	 * that byte as true if data is valid */
	ret |= 0xFF00;

	/* Lower autofeed/linefeed to let sender know we've read data */
	PAR_CTRL_DR &= ~(PAR_CTRL_AUTFn);

	return ret;
}

/* Looks like this will return 0 in the case of a timeout? */
uint16_t wifi_parport_write_byte(uint8_t val)
{
	uint16_t cnt = 1000;

	wifi_parport_prepare();

	/* Set strobe out to note we're writing */
	PAR_CTRL_DR |= PAR_CTRL_STBn;

	/* Set data direction out */
	PAR_DAT_DDR = 0xff;

	/* Wait for high ACK from WiFiStation */
	while(!(PAR_STAT_DR & PAR_STAT_ACK)) {
		msfw_delay(1);
		cnt--;
		if(cnt == 0) return 0;
	}

	/* Set data output and notify WiFiStation */
	PAR_DAT_DR = val;
	PAR_CTRL_DR &= ~(PAR_CTRL_STBn);

	/* Wait for WiFiStation to drop ACK after getting data */
	cnt = 1000;
	while(PAR_STAT_DR & PAR_STAT_ACK) {
		msfw_delay(1);
		cnt--;
		if (cnt == 0) return 0;
	}

	/* Indicate no timeout and data sent successfully */
	return 0xff00;
}
