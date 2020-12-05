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

#ifndef __MSFW_WIDGET_H__
#define __MSFW_WIDGET_H__

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

#if 0
	// Widget specific signals
	// These will likely be best handled by the main loop and not app
	SIG_WID_INIT	= 0x0E, // 
	SIG_WID_DONE	= 0x0F, // Send to close dialogs
	SIG_WID_FOCUS	= 0x10, // Force focus to widget
	SIG_WID_UNFOCUS	= 0x11, // Remove focus from widget
	SIG_UNKNOWN0	= 0x12,
	SIG_UNKNOWN1	= 0x13,
#endif


/* Text entry widget ************************
 *
 * Used for every box that the user can type a custom string in to. Has some
 * custom formats for date, time, IP, phone number, and password
 */
#define WID_TEXTENTRY	0x00

/* Signals to send to this widget */
#define S_TEXT_REFORMAT	0x16 // ?? I think the name is just a guess XXX:
/* Required to set a buffer for any textbox format! */
#define S_TEXT_SETBUF	0x37 // Point to a buffer for the text box, arg1 = buffer address, arg2 = buffer length
#define S_TEXT_UKN1	0x38 // set ptr1.16 to "not this"   (sent after clearing editable bit) XXX:
#define S_TEXT_UKN2	0x39 // test if ptr1.16 is 02, 03, or 04 XXX 
#define S_TEXT_CAT	0x3A // Cat something to end of buffer, arg1 = ??? arg2 = ??? XXX
#define S_TEXT_GET_LEN	0x3B // ret ptr1.4 length ??????????????????? XXX
#define S_TEXT_SETBUFSZ	0x3C // set ptr1.2 = this buffsize ????????? XXX
#define S_TEXT_GETBUFSZ 0x3D // ret ptr1.2 buffsize ?????????? XXX
#define S_TEXT_ISEMPTY	0x3E // Return 1 if empty (or all spaces) (whitespace too?) XXX
#define S_TEXT_UKN3	0x42 // fmt 0010 related?????????????????????????????????????????????????????????????????????????? XXX
#define S_TEXT_GETCUR	0x43 // ret ptr1.6  cursor???????????????????????????????????????????? XXX
#define S_TEXT_SETCUR	0x44 // set ptr1.6 to this ?????????? XXX

/* Text widget flags XXX: not all flags can be ORed together */
/* single line boxes just center in whole box space aside from the ones with border issues */
/* likely must be only one of: */
#define F_TEXT_ALPHA	0x0000 // Alphanumeric, single line
#define F_TEXT_NUM	0x0040 // Numeric entry, single line
#define F_TEXT_PHONE	0x2000 // Phone number format, single line (not sure this works as expected XXX)
#define F_TEXT_IP	0x0080 // IP address format, single line (doesn't seem to work quite right with border)
#define F_TEXT_DATE	0x0800 // Date format, single line (doesn' work quite right with border, also adds "MM/DD/YYYY" awkwardly)
#define F_TEXT_TIME	0x1000 // Time format, single line, HH:MM, 12 hour time (doesn't work quire right with border)
#define F_TEXT_PASSWD	0x4000 // Password, single line, displays * instead of text
#define F_TEXT_HSCROLL	0x0100 // Use with any single line above to allow longer lines than the screen can handle
#define F_TEXT_MLINE	0x0010 // Alphanumeric, multi line (vert scrolling)
#define F_TEXT_MLINE_CLIP	0x0200 // Adds clipboard support to box, implies F_TEXT_MLINE
#define F_TEXT_MLINE_SPELL	0x8000 // Adds spell check support to box, implies F_TEXT_MLINE
/* These can be added to any of the above */
/* XXX: Can these flags be used with multiple widgets? */
#define F_TEXT_BORDER	0x0001 // Add border around text box
#define F_TEXT_UNDERLINE	0x0400 // Like border, but only bottom bounding of text box
#define F_TEXT_CANFOCUS	0x0004 // Focus can be moved to the text box

/* Pick list widget? ***************************** XXX
 */ 
#define WID_PICKLIST	0x01
/* Flags to pass to picklist */
#define F_PICK_EAT_KEY	0x0008 // Return "handled" for key events
#define F_PICK_CANFOCUS	0x0004 // Can move focus to this weidget XXX Same as other canfocus

/* Horizontal picklist? ************************** XXX
 */
#define WID_HORIZ_PICKLIST	0x02
/* Flags to pass to horizontal picklist */
#define F_HPICK_EAT_KEY	0x0008 // Return "handled" for key events XXX Same as above
#define F_HPICK_CANFOCUS	0x0004 // Can move focus to this weidget XXX Same as canfocus
#define F_HPICK_BORDER	0x0001 // Add border XXX Same as BORDER

/* Resource? ********************************** XXX
 */
#define WID_RESOURCE	0x03
/* Flags to pass to resource */
#define F_RES_BOX	0x0100 // Just a box with nothing in it
#define F_RES_STRING	0x0200 // Draw string in center???
#define F_RES_ICON	0x0400 // Draw icon
#define F_RES_STRING_L	0x0800 // Draw string left justified
#define F_RES_STRING_C	0x1000 // Draw string centered
#define F_RES_STRING_R	0x2000 // Draw string right justified

/* Progress bar **************************
 */
#define WID_PROG_BAR	0x04
/* Signals send to a progress bar */
#define S_PBAR_SET01	0x32 // XXX What does this set?   data.0 = this, data.1 = that, data.3 = 0, redraws widget
#define S_PBAR_SET02	0x33 // XXX What does this set?   data.2 = this
#define S_PBAR_UKN01	0x34 //XXX  ???, redraws???
#define S_PBAR_UKN2	0x35 // XXX  ???, redraws???

/* Progress dialog ************************
 */
#define WID_PROG_DIALOG	0x05
/* Signals send to a progress dialog */
/* Flags for progress dialog */
#define S_PDLG_SET_MSG	0x46 // Set progress dialog message, arg1 == 
//      01 - "Dialing...    "
//      02 - "Logging on..."
//      03 - "Connecting to mail server..."
//      04 - "Sending... "
//      05 - "Checking E-Mail..."
//      06 - "Receiving... "
//      07 - "Disconnecting..."
#define S_PDLG_N_OF_M	0x47 // "Sending"/"Receiving" N of M, arg1 = N, arg1 = M XXX dunno what sets send/rec, the above MSG?
#define S_PDLG_STATUS	0x48 // sig_pdlg_status     0x48  //  status message = this  (rsrc string) (at bottom of dialog)
#define S_PDLG_sig_pdlg_scoreboard 0x49  //  Received: this  Rejected: that  (at bottom of dialog)
#define S_PDLG_SET_BAR	0x4A // Advance progress bar?? to arg1 (I think this goes to like 35?)
#define S_PDLG_DIAL_MSG 0x55 // XXX what? sig_pdlg_dial_mesg  0x55  //  Dialing...    this
#define S_PDLG_ANY_MSG	0x58 //XXX???  this  (has bug!!! no good!!!!)


/* Popup widget **************************
 */
#define WID_POPUP_MENU	0x06
/* ??? Nothing else here? */

/* Calendar page? ************************* XXX
 */
#define WID_CALENDAR_PG	0x07
/* XXX???? */


/* String Widget? ********************** ??
 */
#define WID_STRING	0x08
/* flags to pass */
#define F_STRING	0x0200 // Draw string in center???
#define F_STRING_L	0x0800 // Draw string left justified
#define F_STRING_C	0x1000 // Draw string centered
#define F_STRING_R	0x2000 // Draw string right justified


/* Thumbwheel? widget ***************************8
 */
#define WID_THUMBWHEEL	0x09
#define	F_THUMB_CANFOCUS	0x0004 // XXX Same as other canfocus?

/* Checkbox widget ****************************
 */
#define WID_CHECKBOX	0x0A
#define F_CHECK_CANFOCUS	0x0004 // XXX Same as other canfocus?

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