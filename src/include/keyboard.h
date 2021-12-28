/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __KEYBOARD_H__
#define __KEYBOARD_H__


/* Returns 1 if a valid scancode is available. Sets the scancode data
 * in two bytes passed in argument.
 */
#define msfw_get_scancode(x) ((uint8_t (*)(uint8_t *)) 0x0A9A)(x)

extern const char scode_lower[160];

void kbd_flush(void);
void kbd_anykey(void);

#endif // __KEYBOARD_H__
