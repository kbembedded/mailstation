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
	char name[9];
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
	{STR_IDX_APP01, MENU_F2, SC_F2},
	{STR_IDX_APP02, MENU_F3, SC_F3},
	{STR_IDX_APP03, MENU_F4, SC_F4},
	{STR_IDX_NEXT, MENU_F5, SC_F5},
	{STR_IDX_PREV, MENU_F1_2, SC_F1},
	{STR_IDX_APP04, MENU_F2_2, SC_F2},
	{STR_IDX_APP05, MENU_F3_2, SC_F3},
	{STR_IDX_APP06, MENU_F4_2, SC_F4},
	{STR_IDX_APP07, MENU_F5_2, SC_F5},
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
	char buf[21];
	/* This ends up in RAM not stack space */
	static char textbuf[256];
	static uint8_t textwidget;
	uint8_t textwidget2;
	uint8_t textwidget3;
	static uint8_t progbar;
	struct menubar hellobar[5];
	static unsigned int timeout;
	static int timer;


	switch(signal) {
	  case SIG_INIT: //sig_init
		/* Do we need a menu? XXX*/
		/* Needs to be copied in to stack var */
		//memcpy(hellobar, menudata, sizeof(hellobar));
		//msfw_menubar_set(appid, hellobar, 5);

		/*XXX:  Is there a way to request a larger memory area for this? I don't think ramdisk_* provides a buffer but rather
		 * a handle to the buffer */
		/* Clear buffer on startup? */
		textwidget = msfw_widget_new(WID_TEXTENTRY, F_TEXT_MLINE_SPELL|F_BORDER|F_CANFOCUS, 0, 5, 320, 55, appid, 1, 0);
		msfw_widget_event_handle(textwidget, S_TEXT_SETBUF, (uint16_t)textbuf, sizeof(textbuf));
		msfw_widget_focus_set(textwidget);

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
			msfw_led_set(1);
			break;
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

			//memset(buf, '\0', 20);
			//memcpy(buf, "test", 4);
			//msfw_widget_event_handle(textwidget, S_TEXT_CAT, (uint16_t)buf, sizeof(textbuf));
			/* Doesn't do anything :( */
			//msfw_widget_event_handle(textwidget, S_TEXT_REFORMAT, (uint16_t)buf, (uint16_t)buf);
			;
			break;
		  case MENU_F3:
			/* Spawn progress bar with timer */
			//progbar = msfw_msgbox_progbar(STR_IDX_APP00, STR_IDX_APP09);
			//msfw_widget_event_handle(progbar, sig_pdlg_status, STR_IDX_APP11, 0);
			//timer = msfw_timer_new(appid, 1000, 1);
			timeout = 0;
			break;
		  case MENU_F4:
			msfw_msgbox_new(STR_IDX_APP03, MSG_CAN_OK);
			break;
		  case MENU_F5:
			memcpy(hellobar, &menudata[5], sizeof(hellobar));
			msfw_menubar_set(appid, hellobar, 5);
			break;
		  case MENU_F1_2:
			memcpy(hellobar, menudata, sizeof(hellobar));
			msfw_menubar_set(appid, hellobar, 5);
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
