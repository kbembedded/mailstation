#include <CFfuncs.h>
#include <stdint.h>
#include <ms_ports.h>

#include <stddef.h>

#include <string.h>

#include "hello_world-app_info.h"

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

char textbuff[10];
struct string_info {
	uint16_t str_len;
	uint16_t str_offs;
};

const struct string_hdr {
	uint16_t str_cnt;
	struct string_info str_info_list[15];
	char name[7];
	char menuF1[5];
	char menuF2[7];
	char menuF3[10];
	char menuF4[8];
	char menuF5[3];
	char menuF1_2[3];
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
		{sizeof(app_name.menuF1),	offsetof(struct string_hdr, menuF1)},
		{sizeof(app_name.menuF2),	offsetof(struct string_hdr, menuF2)},
		{sizeof(app_name.menuF3),	offsetof(struct string_hdr, menuF3)},
		{sizeof(app_name.menuF4),	offsetof(struct string_hdr, menuF4)},
		{sizeof(app_name.menuF5),	offsetof(struct string_hdr, menuF5)},
		{sizeof(app_name.menuF1_2),	offsetof(struct string_hdr, menuF1_2)},
		{sizeof(app_name.menuF2_2),	offsetof(struct string_hdr, menuF2_2)},
		{sizeof(app_name.menuF3_2),	offsetof(struct string_hdr, menuF3_2)},
		{sizeof(app_name.menuF4_2),	offsetof(struct string_hdr, menuF4_2)},
		{sizeof(app_name.menuF5_2),	offsetof(struct string_hdr, menuF5_2)},
		{sizeof(app_name.right_title),	offsetof(struct string_hdr, right_title)},
		{sizeof(app_name.progtitle),	offsetof(struct string_hdr, progtitle)},
		{sizeof(app_name.progsub),	offsetof(struct string_hdr, progsub)},
		{sizeof(app_name.progbot),	offsetof(struct string_hdr, progbot)},
	},
	"Hello!",

	"Back",
	"Images",
	"Prog. Bar",
	"Msg Box",
	">>",

	"<<",
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
	{0x8001, 1, 3},
	{0x8002, 2, 4},
	{0x8003, 3, 5},
	{0x8004, 4, 6},
	{0x8005, 5, 7},
	{0x8006, 6, 3},
	{0x8007, 7, 4},
	{0x8008, 8, 5},
	{0x8009, 9, 6},
	{0x800a, 10, 7},
};

/* XXX: I HAVE NO CLUE WHAT APPSTATE REALL DOES, IT APPEARS IT AFFECTS SIGNAL SOME HOW? */
uint16_t main(uint16_t appid, uint16_t appstate, uint16_t signal, uint16_t val1, uint16_t val2)
{
	char buf[21];
	//char textbuff[10];
	static uint8_t textwidget;
	uint8_t textwidget2;
	uint8_t textwidget3;
	static uint8_t progbar;
	struct menubar hellobar[5];
	static unsigned int timeout;
	static int timer;

	//msfw_localize((uint16_t)(-20));

	switch(signal) {
	  case SIG_INIT: //sig_init
		//init globals here
		//msfw_new_timer(appid, 100, 1);
		msfw_string_get_resource(0x8000, buf, sizeof(app_name.name));
		msfw_draw_string_foldertab(buf);

		msfw_string_get_resource(0x800B, buf, sizeof(app_name.right_title));
		msfw_draw_string_right_title(buf);

		memcpy(hellobar, menudata, sizeof(hellobar));
		msfw_menubar_set(appid, hellobar, 5);

		/*XXX:  Is there a way to request a larger memory area for this? I don't think ramdisk_* provides a buffer but rather
		 * a handle to the buffer */
		textwidget = msfw_widget_new(WID_TEXTENTRY, TEXT_MLINE_CLIP|TEXT_CANFOCUS|TEXT_BORDER, 0, 5, 290, 55, appid, 1, 0);
		msfw_widget_event_handle(textwidget, sig_setbuff, (uint16_t)textbuff, sizeof(textbuff));
		msfw_widget_focus_set(textwidget);

#if 0
		textwidget2 = msfw_widget_new(WID_TEXTENTRY, TEXT_PHONE|TEXT_CANFOCUS|TEXT_HSCROLL|TEXT_BORDER, 0, 60, 200, 10, appid, 3, 0);
		msfw_widget_event_handle(textwidget2, sig_setbuff, (uint16_t)textbuff, sizeof(textbuff));

		textwidget3 = msfw_widget_new(WID_TEXTENTRY, TEXT_IP|TEXT_CANFOCUS|TEXT_HSCROLL|TEXT_UNDERLINE, 0, 80, 200, 10, appid, 2, 0);
		msfw_widget_event_handle(textwidget3, sig_setbuff, (uint16_t)textbuff, sizeof(textbuff));
		msfw_widget_focus_set(textwidget3);
#endif
		appstate = 1;
		break;
	  case SIG_TIMER: //sig_timer
		timeout++;
		msfw_widget_event_handle(progbar, sig_pdlg_set_bar, timeout, 0); // set progress bar to 5???
		//msfw_widget_event_handle(progbar, sig_pdlg_scoreboard, 10, 3); // set progress bar to 5???
		//msfw_widget_event_handle(progbar, sig_pdlg_n_of_m, timeout, 35); // set progress bar to 5???
		//msfw_widget_event_handle(progbar, sig_pdlg_any_mesg, (uint16_t)&buf[0], 0); // This is buggy somehow
		//msfw_widget_event_handle(progbar, sig_pdlg_set_mesg, 1, 0);
		if (timeout == 35) {
			msfw_msgbox_destroy(progbar);
			msfw_timer_free(timer);
		}
		msfw_led_set(1);

		break;

	  /*XXX: Testing has shown that the app itself has to handle the "back" key
	   * and its not something that can be passed on to the default handler
	   * (which would make sense to do...)
	   */
	  case SIG_KEYDN: //sig_keydown
		if (val1 == 0x01) { //back scancode
			msfw_led_set(0);
			msfw_event_put_goprev();
		}
		break;
	  case SIG_MENU:
		/* With this signal, val1 is set to the relevant menu item */
		switch (val1) {
		  case MENU_F1:
			msfw_event_put_goprev();
			break;
		  case MENU_F2:
			/* Do nothing right now */
			;
			break;
		  case MENU_F3:
			/* Spawn progress bar with timer */
			progbar = msfw_msgbox_progbar(0x8000, 0x800C);
			msfw_widget_event_handle(progbar, sig_pdlg_status, 0x800E, 0);
			timer = msfw_timer_new(appid, 1000, 1);
			timeout = 0;
			break;
		  case MENU_F4:
			msfw_msgbox_new(0x8004, MSG_CAN_OK);
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