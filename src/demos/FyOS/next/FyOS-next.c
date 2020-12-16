#include <CFfuncs.h>
#include <msfw_menubar.h>
#include <msfw_widget.h>
#include <CFstrings.h>
#include <keyboard.h>
#include <stdint.h>
#include <ms_ports.h>

#include <stddef.h>

#include <string.h>

#include "FyOS-next-app_info.h"

enum MENU_VAL1 {
	MENU_F1		= 0x01,
	MENU_F2		= 0x02,
	MENU_F3		= 0x03,
	MENU_F4		= 0x04,
	MENU_F5		= 0x05,
	MENU_F1_2	= 0x06,
	MENU_F2_2	= 0x07,
	MENU_F3_2	= 0x08,
	MENU_F4_2	= 0x09,
	MENU_F5_2	= 0x0A,
};

struct string_info {
	uint16_t str_len;
	uint16_t str_offs;
};

const struct string_hdr {
	uint16_t str_cnt;
	struct string_info str_info_list[12];
	char name[10];
	char menuF2[7];
	char menuF3[10];
	char menuF4[8];
	char menuF2_2[5];
	char menuF3_2[5];
	char menuF4_2[4];
	char menuF5_2[6];
	char right_title[17];
	char progtitle[19];
	char progsub[8];
	char progbot[17];
} app_name = {

	sizeof(app_name.str_info_list) / sizeof(struct string_info),
	{
		{sizeof(app_name.name),		offsetof(struct string_hdr, name)},
		{sizeof(app_name.menuF2),	offsetof(struct string_hdr, menuF2)},
		{sizeof(app_name.menuF3),	offsetof(struct string_hdr, menuF3)},
		{sizeof(app_name.menuF4),	offsetof(struct string_hdr, menuF4)},
		{sizeof(app_name.menuF2_2),	offsetof(struct string_hdr, menuF2_2)},
		{sizeof(app_name.menuF3_2),	offsetof(struct string_hdr, menuF3_2)},
		{sizeof(app_name.menuF4_2),	offsetof(struct string_hdr, menuF4_2)},
		{sizeof(app_name.menuF5_2),	offsetof(struct string_hdr, menuF5_2)},
		{sizeof(app_name.right_title),	offsetof(struct string_hdr, right_title)},
		{sizeof(app_name.progtitle),	offsetof(struct string_hdr, progtitle)},
		{sizeof(app_name.progsub),	offsetof(struct string_hdr, progsub)},
		{sizeof(app_name.progbot),	offsetof(struct string_hdr, progbot)},
	},
	"FyOS Next",
	/* Add version here? */

	"Images",
	"Prog. Bar",
	"Msg Box",

	"More",
	"Less",
	"End",
	"What?",

	"Text demos",

	"Progress Bar Title",
	"Wait...",
	"Delaying 40 s..."
};

/* XXX: In order for this to be effective, need to solve the struct problem! */
const struct menubar menudata[] = {
	{STR_IDX_BACK, MENU_F1, SC_F1},
};

/* XXX: I HAVE NO CLUE WHAT APPSTATE REALL DOES, IT APPEARS IT AFFECTS SIGNAL SOME HOW? */
/* Variables that need to persist should be static locals or globals. These are
 * put in to RAM at runtime which is safe to do.
 * Variables that need to be passed to other MSFW functions MUST be on the stack.
 * this does mean, however, that string constants don't NEED to be in the
 * app_string list and can be constants so long as they can be put on the stack.
 */
uint16_t main(uint16_t appid, uint16_t appstate, uint16_t signal, uint16_t val1, uint16_t val2)
{
	char buf[10];
	/* This ends up in RAM not stack space */
	static char histbuf[512];
	static char linebuf[32];
	static char histbox_wid;
	static char bodybox_wid;
	static char line_wid;
	struct menubar fy_menu[1];


	switch(signal) {
	  case SIG_INIT: //sig_init
		/* Create menu bar at the bottom */
		memcpy(fy_menu, menudata, sizeof(fy_menu));
		msfw_menubar_set(appid, fy_menu, 1);

		/* Draw foldertab/tile */
		msfw_string_get_resource(STR_IDX_APP00, buf, sizeof(app_name.name));
		msfw_draw_string_foldertab(buf);

		/* Create simple bounding box for prettyness */
		bodybox_wid = msfw_widget_new(WID_RESOURCE, F_RES_BOX, 2, 1, 0x13c, 0x55, appid, 5, 0); // Why 5? inbox app used this, not sure what this does
		msfw_widget_event_handle(bodybox_wid, S_TEXT_REFORMAT, 0, 0); //reformat?

		/* Put textbox inside of this */
		memset(histbuf, '\0', sizeof(histbuf));
		histbox_wid = msfw_widget_new(WID_TEXTENTRY, F_TEXT_MLINE_SPELL|F_TEXT_MLINE_CLIP|F_TEXT_RO, 3, 2, 0x13a, 0x4a, appid, 6, 0);
		msfw_widget_event_handle(histbox_wid, S_TEXT_SETBUF, (uint16_t)histbuf, sizeof(histbuf));
		msfw_widget_event_handle(histbox_wid, S_TEXT_REFORMAT, 0, 0);
		msfw_widget_event_handle(histbox_wid, S_TEXT_UKN1, 1, 0); // Make RO?

		/* Input box */
		memset(linebuf, '\0', sizeof(linebuf));
		line_wid = msfw_widget_new(WID_TEXTENTRY, F_TEXT_ALPHA|F_TEXT_HSCROLL, 3, 0x4b, 0x13a, 0x9, appid, 7, 0); // is HSCROLL needed? 
		msfw_widget_event_handle(line_wid, S_TEXT_SETBUF, (uint16_t)linebuf, sizeof(linebuf));
		msfw_widget_event_handle(line_wid, S_TEXT_REFORMAT, 0, 0);
		msfw_widget_focus_set(line_wid);



#if 0
		strcpy(bodystring, "Test\r\nI wonder if the box prefers return vs newline\r\nor if it doesn't care and just wants to wordwrap on its own. So here is a nice long line to let that happen\r\n\r\nThat was two returns.\r\n\r\nthis was two newlines. You know I never tried \r\nfor return newline.\r\nLets\r\nMake\r\nSome\r\nSCROLLL");
		bodystring_wid = msfw_widget_new(WID_TEXTENTRY, F_TEXT_MLINE_SPELL|F_TEXT_MLINE_CLIP|F_TEXT_RO, 2, 0x1e, 0x13c, 0x4a, appid, 0xC, 0);
		msfw_widget_event_handle(bodystring_wid, S_TEXT_SETBUF, (uint16_t)bodystring, sizeof(bodystring));
		msfw_widget_event_handle(bodystring_wid, S_TEXT_REFORMAT, 0, 0);
		msfw_widget_event_handle(bodystring_wid, S_TEXT_UKN1, 1, 0);
		/* I think this is supposed to happen in another state? in the inbox app, the draw sig is sent to everything before the following lines show up. If done in this order here, the 0x22 signals go before the draw signal, and that ends up leaving cursor artifact on the screen */
		/* Need to figure out what sig 0x22 is to widget */
		msfw_widget_event_handle(bodystring_wid, 0x22, 4, 0);
		msfw_widget_event_handle(bodystring_wid, 0x22, 4, 0);
		msfw_widget_focus_set(bodystring_wid);

New Widget, type: 0x0003, flags: 0x0800, left: 0x000E, top: 0x0000, width: 0x0016, height: 0x0009, appid: 0x0001, seqnum: 0x0005, str_etc: 0x003C
Widget event, handle: 0x0000, signal: 0x000E, arg1: 0x003C, arg2: 0x003C
Widget event, handle: 0x0000, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0000, flags: 0x0100, left: 0x0024, top: 0x0001, width: 0x0050, height: 0x0009, appid: 0x0001, seqnum: 0x0006, str_etc: 0x0000
Widget event, handle: 0x0001, signal: 0x000E, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0001, signal: 0x0037, arg1: 0x9016, arg2: 0x0009
Widget event, handle: 0x0001, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0003, flags: 0x0800, left: 0x000B, top: 0x0009, width: 0x0019, height: 0x0009, appid: 0x0001, seqnum: 0x0007, str_etc: 0x004C
Widget event, handle: 0x0002, signal: 0x000E, arg1: 0x004C, arg2: 0x004C
Widget event, handle: 0x0002, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0000, flags: 0x0100, left: 0x0024, top: 0x000A, width: 0x011C, height: 0x0009, appid: 0x0001, seqnum: 0x0008, str_etc: 0x0000
Widget event, handle: 0x0003, signal: 0x000E, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0003, signal: 0x0037, arg1: 0x905C, arg2: 0x0051
Widget event, handle: 0x0003, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0003, flags: 0x0800, left: 0x0001, top: 0x0012, width: 0x0023, height: 0x0009, appid: 0x0001, seqnum: 0x0009, str_etc: 0x003D
Widget event, handle: 0x0004, signal: 0x000E, arg1: 0x003D, arg2: 0x003D
Widget event, handle: 0x0004, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0000, flags: 0x0100, left: 0x0024, top: 0x0013, width: 0x011C, height: 0x0009, appid: 0x0001, seqnum: 0x000A, str_etc: 0x0000
Widget event, handle: 0x0005, signal: 0x000E, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0005, signal: 0x0037, arg1: 0x901F, arg2: 0x003D
Widget event, handle: 0x0005, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0003, flags: 0x0100, left: 0x0002, top: 0x001C, width: 0x013C, height: 0x0001, appid: 0x0001, seqnum: 0x000B, str_etc: 0x0000
Widget event, handle: 0x0006, signal: 0x000E, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0006, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
New Widget, type: 0x0000, flags: 0x8204, left: 0x0002, top: 0x001E, width: 0x013C, height: 0x004A, appid: 0x0001, seqnum: 0x000C, str_etc: 0x0000
Widget event, handle: 0x0007, signal: 0x000E, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x0037, arg1: 0x945D, arg2: 0x1F67
Widget event, handle: 0x0007, signal: 0x0016, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x0038, arg1: 0x0001, arg2: 0x0000
Widget event, handle: 0x0000, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0001, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0002, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0003, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0004, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0005, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0006, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x000D, arg1: 0x0000, arg2: 0x0000
Widget event, handle: 0x00FF, signal: 0x0011, arg1: 0x0000, arg2: 0x0000

Widget event, handle: 0x0007, signal: 0x0022, arg1: 0x0004, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x0022, arg1: 0x0004, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x003F, arg1: 0x0007, arg2: 0x0000
Widget event, handle: 0x0007, signal: 0x0009, arg1: 0x0057, arg2: 0x000D
#endif
#if 0
		/* This is all crap maybe, starting over from the email read app */
		/* Do we need a menu? XXX*/
		/* Needs to be copied in to stack var */
		memcpy(hellobar, menudata, sizeof(hellobar));
		msfw_menubar_set(appid, hellobar, 5);

		/* Not sure how newline is actually represented in buffer inside mailstation */
		//strcpy(histbuf, "This is\ra long\rmulti-line string\r in an attempt\rto try scrolling\rpenis");

		/*XXX:  Is there a way to request a larger memory area for this? I don't think ramdisk_* provides a buffer but rather
		 * a handle to the buffer */
		/* Clear buffer on startup? */
		/* Is there a read-only flag like inbox email? */
		//text_history_wid = msfw_widget_new(WID_TEXTENTRY, F_CANFOCUS|F_TEXT_MLINE_SPELL|F_BORDER, 5, 5, 315, 55, appid, 0, 0);
		//msfw_widget_focus_set(text_history_wid);
		//msfw_widget_event_handle(text_history_wid, S_TEXT_SETBUF, (uint16_t)histbuf, sizeof(histbuf));
		/* Why the fuck does this widget do its own thing and not render where I expect it? */
		text_input_wid = msfw_widget_new(WID_TEXTENTRY, F_TEXT_RO|F_BORDER, 5, 55, 315, 62, appid, 1, 1);
		/* Buf needs to be no longer than the length of the textbox, otherwise issues with render */
		strcpy(histbuf, "A string");
		msfw_widget_event_handle(text_input_wid, S_TEXT_SETBUF, (uint16_t)histbuf, sizeof(histbuf));
		msfw_widget_focus_set(text_input_wid);
		/* XXX Check out CFp07/08 09? for inbox app use. Need to know what widget is being used for read only string log */
		//text_input_wid = msfw_widget_new(WID_RESOURCE, F_RES_STRING, 0, 5, 320, 55, appid, 1, 1);
		/* below doesn't work, figure that out */
		//textwidget = msfw_widget_new(WID_STRING, F_STRING, 0, 5, 320, 55, appid, 1, 1);
		//msfw_widget_event_handle(textwidget, S_TEXT_SETBUF, (uint16_t)histbuf, sizeof(histbuf));
		//msfw_widget_focus_set(textwidget);
#endif

		appstate = 1;
		break;
	  case SIG_TIMER: //sig_timer
		//timeout++;
		//msfw_widget_event_handle(progbar, sig_pdlg_set_bar, timeout, 0); // set progress bar to 5???
		////msfw_widget_event_handle(progbar, sig_pdlg_scoreboard, 10, 3); // set progress bar to 5???
		////msfw_widget_event_handle(progbar, sig_pdlg_n_of_m, timeout, 35); // set progress bar to 5???
		////msfw_widget_event_handle(progbar, sig_pdlg_any_mesg, (uint16_t)&buf[0], 0); // This is buggy somehow
		////msfw_widget_event_handle(progbar, sig_pdlg_set_mesg, 1, 0);
		//if (timeout == 35) {
		//	msfw_msgbox_destroy(progbar);
		//	msfw_timer_free(timer);
		//}
		msfw_led_set(1);

		break;

	  /*XXX: Testing has shown that the app itself has to handle the "back" key
	   * and its not something that can be passed on to the default handler
	   * (which would make sense to do...)
	   */
	  case SIG_KEYDN: //sig_keydown
		switch (val1) {
		  case SC_BACK:
			msfw_led_set(0);
			msfw_event_put_goprev();
			break;
		  case SC_ENTER:
			memset(linebuf, '\0', sizeof(linebuf));
			msfw_widget_event_handle(line_wid, S_TEXT_SETBUF, (uint16_t)linebuf, sizeof(linebuf));
			msfw_widget_event_handle(line_wid, S_TEXT_REFORMAT, 0, 0);
			/* Send a backspace event to the wid to cause it to redraw the empty buffer.
			 * Strangely, sending SIG_DRAW doesn't actually clear the current buf*/
			msfw_widget_event_handle(line_wid, SIG_KEYDN, SC_BKSP, 0);
			msfw_widget_event_handle(line_wid, SIG_KEYUP, SC_BKSP, 0);
			break;
#if 0
			/* Clearing the buffer then re-setting it does *sort of* do what I want */
			memset(histbuf, '\0', sizeof(histbuf));
			//msfw_widget_event_handle(text_input_wid, S_TEXT_SETBUF, (uint16_t)histbuf2, sizeof(histbuf2));
			//msfw_widget_event_handle(text_input_wid, S_TEXT_REFORMAT, 1, 1);
			//msfw_widget_event_handle(text_input_wid, SIG_DRAW, 0, 0);
			/* is there a way to tell SOMEONE to redraw the contents of the widget? */
			//msfw_default_handler(appid, appstate, SIG_DRAW, 0, 0);
			msfw_msgbox_destroy(text_input_wid);
			text_input_wid = msfw_widget_new(WID_TEXTENTRY, F_TEXT_ALPHA|F_BORDER, 5, 55, 315, 62, appid, 1, 1);
			/* Buf needs to be no longer than the length of the textbox, otherwise issues with render */
			msfw_widget_event_handle(text_input_wid, S_TEXT_SETBUF, (uint16_t)histbuf, sizeof(histbuf));
			msfw_widget_focus_set(text_input_wid);
			//msfw_widget_event_handle(text_input_wid, S_TEXT_SETCUR, 0, 0);
			break;
#endif
		  default:
			break;
		}

		break;
	  case SIG_MENU:
		/* With this signal, val1 is set to the relevant menu item */
		switch (val1) {
		  case MENU_F1:
			msfw_event_put_goprev();
			/* No idea how sig_exit should work */
			appstate = SIG_EXIT;
			break;
		  case MENU_F2:
			/* Do nothing right now */
			//msfw_widget_event_handle(textwidget, S_TEXT_SET_CUR, 2, 0);

			memset(buf, '\0', 20);
			memcpy(buf, "test", 4);
			//msfw_widget_event_handle(textwidget, S_TEXT_CAT, (uint16_t)buf, sizeof(histbuf));
			//msfw_widget_event_handle(textwidget, SIG_DRAW, (uint16_t)buf, (uint16_t)buf);
			;
			break;
		  case MENU_F3:
			/* Spawn progress bar with timer */
			//progbar = msfw_msgbox_progbar(STR_IDX_APP00, STR_IDX_APP09);
			//msfw_widget_event_handle(progbar, sig_pdlg_status, STR_IDX_APP11, 0);
			//timer = msfw_timer_new(appid, 1000, 1);
			break;
		  default:
			break;
		}
		break;
			
	  default:
		msfw_default_handler(appid, appstate, signal, val1, val2);
		break;
	}

	return appstate;
}
