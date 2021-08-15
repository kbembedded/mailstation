#include <CFfuncs.h>
#include <CFstrings.h>
#include <msfw_menubar.h>
#include <keyboard.h>
#include <stdint.h>
#include <ms_ports.h>

#include <stddef.h>

#include <string.h>

#include "hello_world-app_info.h"

enum MENU_VAL1 {
	MENU_F1		= 0x01,
};

struct string_info {
	uint16_t str_len;
	uint16_t str_offs;
};

const struct string_hdr {
	uint16_t str_cnt;
	struct string_info str_info_list[1];
	char name[7];
} app_name = {

	sizeof(app_name.str_info_list) / sizeof(struct string_info),
	{
		{sizeof(app_name.name),		offsetof(struct string_hdr, name)},
	},
	"Hello!",
};

/* XXX: In order for this to be effective, need to solve the struct problem! */
const struct menubar menudata[] = {
	{STR_IDX_YES, MENU_F1, SC_F1},
};

/* XXX: I HAVE NO CLUE WHAT APPSTATE REALL DOES, IT APPEARS IT AFFECTS SIGNAL SOME HOW? */
uint16_t main(uint16_t appid, uint16_t appstate, uint16_t signal, uint16_t val1, uint16_t val2)
{
	/*XXX: It looks like RAMp02 is _always_ used for app RAM? */
	char buf[21];
	struct menubar f_menu[1];

	switch(signal) {
	  case SIG_INIT:
		msfw_string_get_resource(0x8000, buf, sizeof(app_name.name));
		msfw_draw_string_foldertab(buf);

		memcpy(f_menu, menudata, sizeof(f_menu));
		msfw_menubar_set(appid, f_menu, 1);

		appstate = 1;
		break;
	  case SIG_KEYDN:
		if (val1 == SC_BACK) {
			msfw_event_put_goprev();
		}
		break;
	  case SIG_MENU:
		switch (val1) {
		  case MENU_F1:
			msfw_event_put_goprev();
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
