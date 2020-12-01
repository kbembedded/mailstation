/* SPDX-License-Identifier: BSD-2-Clause */

#include <stdint.h>

/*
 * Much of the information here was originally gathered and pioneered by
 * Cyrano Jones on the OG Yahoo! group. I've tried to gather it and document
 * it as best as I can. Cyrano's "Capp" was used as an inspiration for this.
 */

#ifndef __MSFW_MENUBAR_H__
#define __MSFW_MENUBAR_H__

struct menubar {
	uint16_t string_idx;	// string resource index number for menubar
	uint16_t menu_id;	// menu event subtype generated when item is pressed
	uint8_t  scancode;	// prob should use f-keys (05 thru 09 on non-ergo kbd's)
};


/***** Signals
 * These signals can be SENT to a menubar widget
 * Unsure of how to send them, exactly, since the menubar_set func doesn't
 * return a widget ID? maybe its from
//menubar_handler                       (sig, par2, par4);      //0x0B84        Task_zzzz
 */
#define SIG_MENUBAR_OFF	0x0B
#define SIG_MENUBAR_ON	0x0C

/* 
 * Ugly #defines are used as opposed to a typedef'ed function pointer due
 * to the fact that SDCC (at the time of writing this) consumes code space
 * even on unused functions. Since the #defines end up being C macros, this
 * has no additional code overhead.
 */

/* A list of various functions provided by stock Mailstation firmware. Where
 * appropriate, a list of known compatible or incompatible firmware versions
 * will be listed as well.
 */

/*
 * uint8_t msfw_menubar_set(int16_t appid, struct menubar *menu, int16_t n)
 *
 * Register a menubar and set its contents.
 *
 * appid == The appID as passed to the main event handler
 * data == pointer to struct menubar for the menu
 * n == number of menubar entries
 *
 * returns 1 on success
 * unsure of failure conditions
 */
#define msfw_menubar_set(appid, data, n) ((uint8_t (*)(int16_t, struct menubar *, int16_t)) 0x0638)(appid, data, n)

#endif // __MSFW_MENUBAR_H__
