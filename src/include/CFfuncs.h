/* SPDX-License-Identifier: BSD-2-Clause */

#include <stdint.h>

// Tentative types for various values. (not used anywhere
// yet, I'n not sure if it's a good idea to use them in the
// function prototypes????????)  There is an 8 & 16 bit form
// for each, 'coz sdcc insists on pushing single bytes on the
// stack (ick!!!!) and the mailstations functions expect byte
// parameters to be pushed as words (nomal z80 pushes).
// So ret types are 8 bits, and when an 8 bit val is used as
// a param, I let sdcc promote it, and ms firmware ignores hi byte.


/*
 * Much of the information here was originally gathered and pioneered by
 * Cyrano Jones on the OG Yahoo! group. I've tried to gather it and document
 * it as best as I can. Cyrano's "Capp" was used as an inspiration for this.
 */

#ifndef __CFFUNCS_H__
#define __CFFUNCS_H__

/* An event in the eventq looks like the following. Unsure if this is needed
 * as the main loop sends an event to an app as multiple paramters. */
struct event {
	uint8_t  appid;
	uint8_t  signal;
	uint16_t val1;
	uint16_t val2;
};

/* Struct used for RTC operations */
struct tm_rtc {
	uint16_t tm_year;		// Is year really 16bit?
	uint8_t  tm_mon;
	uint8_t  tm_day;
	uint8_t  tm_wday;
	uint8_t  tm_hour;
	uint8_t  tm_min;
	uint8_t  tm_sec;
};

/* Used for message record recording */
struct tm_msg {
	uint16_t tm_year;		// Is year really 16bit?
	uint8_t  tm_mon;
	uint8_t  tm_day;
	uint8_t  tm_hour;
	uint8_t  tm_min;
	uint8_t  tm_sec;
};

/* Message format, works for both inbox and outbox */
struct msg {
	uint16_t hdrlen; 	//Includes length to end of replyto
	uint8_t  status;	// Not sure what this is yet
	struct tm_msg date;
	uint8_t  subject[61];	// Actually hard limited in editor to 60 chars
	uint8_t  from[81];	// Not sure what happens if this ends up longer than 80 chars, sounds like its normally a fixed len
	uint8_t  to[81];	// This can be dynamically sized when draft, cannot exceed 80 chars in outbox
	char     *body;
};

/******* Event signals ***********/
enum msos_app_sigs {
	// These seem to be caught and handled in main loop
	SIG_INIT 	= 0x01, // Called to init an app
	SIG_SUSPEND 	= 0x02, // Unsure how this works
	SIG_GOPREV 	= 0x03, // Send this to back out to Yahoo! or Extras
	SIG_GOMAIN 	= 0x04, // Send this to to to main menu

	// Some useful app signals
	SIG_TIMER 	= 0x05, // Signal when timer has expired
	SIG_BUTTONDN 	= 0x06, // Buttons are most of the top row keys
	SIG_BUTTONUP 	= 0x07,
	SIG_KEYDN 	= 0x08, // Keys are the rest of the keyboard
	SIG_KEYUP 	= 0x09,
	SIG_MENU 	= 0x0A, // Sent from menubar or popup menus

	// Can send these to menubar widget
	// in msfw_menubar.h
//	SIG_MENUBAR_OFF	= 0x0B,
//	SIG_MENUBAR_ON	= 0x0C,

	SIG_DRAW	= 0x0D, // Cause app/widget to draw

	// Widget specific signals
	// These will likely be best handled by the main loop and not app
	SIG_WID_INIT	= 0x0E, // 
	SIG_WID_DONE	= 0x0F, // Send to close dialogs
	SIG_WID_FOCUS	= 0x10, // Force focus to widget
	SIG_WID_UNFOCUS	= 0x11, // Remove focus from widget
	SIG_UNKNOWN0	= 0x12,
	SIG_UNKNOWN1	= 0x13,

	SIG_EXIT	= 0x14, // Sent to app when closing
};

/* 
 * Ugly #defines are used as opposed to a typedef'ed function pointer due
 * to the fact that SDCC (at the time of writing this) consumes code space
 * even on unused functions. Since the #defines end up being C macros, this
 * has no additional code overhead.
 */


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

#define msfw_ramdisk_get(dummy, code, sz) ((uint8_t (*)(uint16_t, uint16_t, uint16_t)) 0x05DB)(dummy, code, sz)

/*
 * int16_t msfw_new_timer(int16_t appid, uint16_t msec, int16_t persist)
 *
 * Schedule a timer event signal for appid
 *
 * NOTE: Maybe returns timerid?
 */
#define msfw_timer_new(appid, msec, persist) ((int16_t (*)(int16_t, uint16_t, int16_t)) 0x070D)(appid, msec, persist)

/*
 * int16_t msfw_timer_free(int16_t timer)
 *
 * Presumably removes timer set with new?
 */
#define msfw_timer_free(timer) ((int16_t (*)(int16_t)) 0x0713)(timer)

/*
 * msfw_set_led(uint16_t state)
 *
 * Set LED state to 1 or 0.
 * NOTE: Even when called from MSFW, seems to immediately turn off LED?
 */
#define msfw_led_set(x) ((void (*)(uint16_t)) 0x0A77)(x)

/*
 * void msfw_event_put_goprev(void)
 *
 * Send an event to the main superloop to go to the previous menu. e.g. go back from the app to the "Extras" or "Yahoo!" menu
 */
#define msfw_event_put_goprev ((void (*)(void)) 0x066E)

/*
 * void msfw_event_put_gomain(void)
 *
 * Send an event to the main superloop to return to the main menu
 */
#define msfw_event_put_gomain ((void (*)(void)) 0x0668)

/*
 * msfw_lcd_clear(void)
 *
 * Clear the LCD
 */
#define msfw_lcd_clear ((void (*)(void)) 0xA85)

#define msfw_default_handler(appid, appstate, signal, val1, val2) ((uint16_t (*)(uint16_t, uint16_t, uint16_t, uint16_t, uint16_t)) 0x0602)(appid, appstate, signal, val1, val2)

/* This is used in most Channels to allocate some data on the stack.
 * This is not really needed in C implementations since non-static local
 * vars are just put on the stack anyway */
#define msfw_alloc_stack(x) ((void (*)(uint16_t)) 0x056B)(x)

/*
 * int16_t msfw_string_get_resource(uint16_t resource_id, char *dest, uint16_t n)
 *
 * Using the String data structure, copy the referenced resource in to dest buffer, no longer than n
 * NOTE: The dataflash strings datastructure seems to start at ID 0x8000
 */
#define msfw_string_get_resource(resource_id, dest, n) ((int16_t (*)(uint16_t, char *, uint16_t)) 0x081B)(resource_id, dest, n)

/*
 * int16_t msfw_draw_string_foldertab(char *str)
 *
 * Draw the string pointed to by title to the "folder tab" on the top left of the LCD
 * NOTE: title would ideally be in the stack
 */
#define msfw_draw_string_foldertab(str) ((int16_t (*)(char *)) 0x0827)(str)

/*
 * int16_t msfw_draw_string_center_title(char *str)
 *
 * Render a string to the center title bar area, just right of the foldertab
 */
#define msfw_draw_string_center_title(str) ((int16_t (*)(char *)) 0x0833)(str)

/*
 * int16_t msfw_draw_string_right_title(char *str)
 *
 * Render a string to the right title bar area
 */
#define msfw_draw_string_right_title(str) ((int16_t (*)(char *)) 0x082D)(str)

#endif // __CFFUNCS_H__
