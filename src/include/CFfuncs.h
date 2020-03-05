/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __CFFUNCS_H__
#define __CFFUNCS_H__

/* A list of various functions provided by stock Mailstation firmware. Where
 * appropriate, a list of known compatible or incompatible firmware versions
 * will be listed as well.
 *
 * To the best of current knowledge, these functions are safe to run from any
 * context and do not require
 */

/****************************************************************************
 * Delay for ms value
 *
 * Delay for miliseconds of time
 */
#define msfw_delay(x) ((void (*)(uint16_t)) 0x0A5C)(x)


/****************************************************************************
 * Power off Mailstation
 *
 * Simply shuts off mailstation as if the power button were pressed.
 */
#define msfw_poweroff ((void (*)(void)) 0x0A6B)

#endif // __CFFUNCS_H__
