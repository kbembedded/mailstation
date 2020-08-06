/* SPDX-License-Identifier: BSD-2-Clause */

#include <stdint.h>

/*
 * Much of the information here was originally gathered and pioneered by
 * Cyrano Jones on the OG Yahoo! group. I've tried to gather it and document
 * it as best as I can. Cyrano's "Capp" was used as an inspiration for this.
 */

#ifndef __CFFUNCS_H__
#define __CFFUNCS_H__

struct menubar {
	uint16_t string_id;	// string resource id-number for menubar
	uint16_t menu_id;	// menu event subtype generated when item is pressed
	uint8_t  scancode;	// prob should use f-keys (05 thru 09 on non-ergo kbd's)
};

/* An event in the eventq looks like the following. Unsure if this is needed
 * as the main loop sends an event to an app as multiple paramters. */
struct event {
	uint8_t  appid;
	uint8_t  signal;
	uint16_t val1;
	uint16_t val2;
};

/* Top left and bottom right corners of the container
 * I presume 0,0 is top left and 319,127 is bottom right
 */
struct container {
	uint16_t left;
	uint16_t top;
	uint16_t right;
	uint16_t bottom;
};

/* When drawing things on screen, a window needs to be defined
 * There is some function that can return this with default values filled
 */
struct window {
	uint16_t left;
	uint16_t top;
	uint16_t width;
	uint16_t height;
	uint16_t top_margin;
	uint16_t bottom_margin;
	uint8_t  font;
	uint8_t  flags; // Bit0 color, bit1 filled, bit2 clipped
	struct container container;
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
	SIG_MENUBAR_OFF	= 0x0B,
	SIG_MENUBAR_ON	= 0x0C,

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
// w_progressbar responds to:
#define sig_pbar_set01      0x32  //  data.0 = this, data.1 = that, data.3 = 0, redraws widget
#define sig_pbar_set2       0x33  //  data.2 = this
#define sig_pbar_unknown1   0x34  //  ???, redraws???
#define sig_pbar_unknown2   0x35  //  ???, redraws???

// w_progress_dialog responds to:
#define sig_pdlg_set_mesg   0x46  //  this = dial progress mesg  (1 thru 7)
//      01 - "Dialing...    "
//      02 - "Logging on..."
//      03 - "Connecting to mail server..."
//      04 - "Sending... "
//      05 - "Checking E-Mail..."
//      06 - "Receiving... "
//      07 - "Disconnecting..."
#define sig_pdlg_n_of_m     0x47  //  Sending.../Receiving... this of that
#define sig_pdlg_status     0x48  //  status message = this  (rsrc string) (at bottom of dialog)
#define sig_pdlg_scoreboard 0x49  //  Received: this  Rejected: that  (at bottom of dialog)
#define sig_pdlg_set_bar    0x4a  //  advance progressbar to this
#define sig_pdlg_dial_mesg  0x55  //  Dialing...    this
#define sig_pdlg_any_mesg   0x58  //  this  (has bug!!! no good!!!!)

/* WID_TEXTENTRY responds to these signals */
#define sig_reformat_text   0x16  // ??? (just a guess)
#define sig_setbuff         0x37  // setbuff to this, buffsize to that
#define sig_unknown1        0x38  // set ptr1.16 to "not this"   (sent after clearing editable bit)
#define sig_unknown2        0x39  // test if ptr1.16 is 02, 03, or 04
#define sig_append          0x3a  // add this to end of buff (what is that???)
#define sig_get_length      0x3b  // ret ptr1.4 length
#define sig_set_buffsize    0x3c  // set ptr1.2 = this buffsize
#define sig_get_buffsize    0x3d  // ret ptr1.2 buffsize
#define sig_test_if_blank   0x3e  // ret 1 if empty (or all spaces)
#define sig_unknown3        0x42  // (fmt 0010 related???)
#define sig_get_cursor      0x43  // ret ptr1.6  cursor?????????
#define sig_set_cursor      0x44  // set ptr1.6 to this

/****** Widget types *********/
enum widget_types {
	WID_TEXTENTRY	= 0x00,
	WID_PICKLIST	= 0x01,
	WID_HORIZ_PICKLIST	= 0x02,
	WID_RESOURCE	= 0x03,
	WID_PROG_BAR	= 0x04,
	WID_PROG_DIALOG	= 0x05,
	WID_POPUP_MENU	= 0x06,
	WID_CALENDAR_PG	= 0x07,
	WID_STRING	= 0x08,
	WID_THUMBWHEEL	= 0x09,
	WID_CHECKBOX	= 0x0A,
};

/******* Widget Flags ***********/
/* Note that not all flags can be ORed together */
enum WID_TEXTENTRY_flags {

	/* WID_TEXTENTRY flags */
	TEXT_ALPHA	= 0x0000, // Alpha, one line
	TEXT_NUM	= 0x0040, // Numeric, one line
	TEXT_PHONE	= 0x2000, // Phone format, one line
	TEXT_HSCROLL	= 0x0100, // Horiz scroll, combined with above formats

	TEXT_IP		= 0x0080, // IP address
	TEXT_DATE	= 0x0800, // Date format
	TEXT_TIME	= 0x1000, // Time format
	TEXT_PASSWD	= 0x4000, // Password, hidden input

	TEXT_MLINE	= 0x0010, // Multi-line text, vert scroll, horiz scroll?
	TEXT_MLINE_CLIP	= 0x0200, // Above, add clipboard support
	TEXT_MLINE_CS	= 0x8000, // Above, add spellcheck support

	/* The following can be used with any of the above */
	TEXT_BORDER	= 0x0001, // Add border around text box
	TEXT_CANFOCUS	= 0x0004, // Can move focus to this widget to edit
	TEXT_UNDERLINE	= 0x0400, // Adds underline to each line??
};

#define wb_hasborder    0x0001  // has border     use with any of the above
#define wb_canfocus     0x0004  // editable       use with any of the above
#define wb_underlined   0x0400  // has underline  use with any of the above

enum WID_PICKLIST_flags {
	PICK_EAT_KEY	= 0x0008, // Return "handled" for key events
	PICK_CANFOCUS	= 0x0004, // Can move focus to this weidget
};

enum WID_HORIZ_PICKLIST_flags {
	HPICK_EAT_KEY	= 0x0008, // Return "handled" for key events
	HPICK_CANFOCUS	= 0x0004, // Can move focus to this weidget
	HPICK_BORDER	= 0x0001, // Add border
};

enum WID_RESOURCE_flags {
	RES_BOX		= 0x0100, // Just a box with nothing in it
	RES_STRING	= 0x0200, // Draw string in center???
	RES_ICON	= 0x0400, // Draw icon
	RES_STRING_L	= 0x0800, // Draw string left justified
	RES_STRING_C	= 0x1000, // Draw string centered
	RES_STRING_R	= 0x2000, // Draw string right justified
};

enum WID_STRING_flags {
	STRING		= 0x0200, // Draw string in center???
	STRING_L	= 0x0800, // Draw string left justified
	STRING_C	= 0x1000, // Draw string centered
	STRING_R	= 0x2000, // Draw string right justified
};

enum WID_THUMBWHEEL_flags {
	THUMB_CANFOCUS	= 0x0004, // Can move focus to this weidget
};

enum WID_CHECKBOX_flags {
	CHECK_CANFOCUS	= 0x0004, // Can move focus to this weidget
};

enum WID_MESSAGEBOX_flagss {
	MSG_OK		= 0x0100, // Def. OK
	MSG_OK_CAN	= 0x0200, // Def. OK
	MSG_YES_NO	= 0x0400, // Def. Yes
	MSG_YES_NO_CAN	= 0x0800, // Def. Yes
	MSG_CAN_OK	= 0x2200, // Def. Cancel
	MSG_NO_YES	= 0x2400, // Def. No
	MSG_NO_YES_CAN	= 0x2800, // Def. No
	MSG_CAN_YES_NO	= 0x4800, // Def. Cancel
};

enum MESSAGEBOX_RET {
	RET_MSG_OK	= 0x01,
	RET_MSG_CAN	= 0x02,
	RET_MSG_YES	= 0x03,
	RET_MSG_NO	= 0x04,
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

/* XXX: Unknown args format */
#define msfw_localize(x) ((void (*)(uint16_t)) 0x056B)(x)

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

/*
 * uint8_t msfw_menubar_set(int16_t appid, struct menubar *menu, int16_t n)
 *
 * Register a menubar and set its contents. n == number of menubar entries
 * returns true or false
 */
#define msfw_menubar_set(appid, data, n) ((uint8_t (*)(int16_t, struct menubar *, int16_t)) 0x0638)(appid, data, n)

/*
 * uint8_t msfw_widget_new(int16_t widget_type, uint16_t flags, int16_t left, int16_t top, int16_t height, int16_t width, int16_t appid, int16_t seqnum, uint16_t str_etc)
 *
 * Creates a new widget of widget_type, with specific flags, defining its origin, height, width, the appid of the owner.
 * No clue what seq_num or str_etc are.
 * Returns wid handle.
 */
#define msfw_widget_new(widget_type, flags, left, top, height, width, appid, seqnum, str_etc) ((uint8_t (*)(int16_t, uint16_t, int16_t, int16_t, int16_t, int16_t, int16_t, int16_t, uint16_t)) 0x0692)(widget_type, flags, left, top, height, width, appid, seqnum, str_etc)

/*
 * uint8_t msfw_widget_event_handle(int16_t wh, int16_t signal, uint16_t val1, uint16_t val2)
 *
 * Send an event to a widget? Pointed to by widget handle wh, signal is event to handle, no clue what vals are here
 */
#define msfw_widget_event_handle(wh, signal, val1, val2) ((uint8_t (*)(int16_t, int16_t, uint16_t, uint16_t)) 0x064A)(wh, signal, val1, val2)

/*
 * uint8_t msfw_widget_focus_set(int16_t wh)
 *
 * Set a specific widget to be in focus. No clue return meaning
 */
#define msfw_widget_focus_set(wh) ((uint8_t (*)(int16_t)) 0x0680)(wh)

/*
 * int16_t msfw_msgbox_new(uint16_t res_str, uint16_t flags)
 *
 * I honestly have no clue what a message box is. need to test
 * It looks like this might be a specific preformat "popup menu" with flags able to set the items
 */
#define msfw_msgbox_new(res_str, flags) ((int16_t (*)(uint16_t, uint16_t)) 0x07F1)(res_str, flags)

/*
 * uint8_t msfw_msgbox_progbar(uint16_t res_str_msg, uint16_t res_str_title)
 *
 * I assume this makes a progress bar with a message and title based on resource strings?
 * Originally speced to use int16_t, but, that is wrong I think
 * the msg arg doesn't seem to work?
 */
#define msfw_msgbox_progbar(res_str_msg, res_str_title) ((uint8_t (*)(uint16_t, uint16_t)) 0x07F7)(res_str_msg, res_str_title)

/*
 * uint16_t msfw_msgbox_destroy(int16_t widget) 
 *
 * Destroy messagebox
 */
#define msfw_msgbox_destroy(wid) ((uint16_t (*)(int16_t)) 0x07FD)(wid)

#endif // __CFFUNCS_H__
