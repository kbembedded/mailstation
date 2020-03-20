#ifndef __GRAPHICS_TEXTMODE_H__
#define __GRAPHICS_TEXTMODE_H__

void g_textmode_set_invert(uint8_t inv);
void g_textmode_clear_line(uint8_t line);
void g_textmode_invert_line(uint8_t line);
void g_textmode_set_ypos(uint8_t new_pos);
void g_textmode_set_xpos(uint8_t new_pos);
uint8_t g_textmode_get_ypos(void);
uint8_t g_textmode_get_xpos(void);
void g_textmode_init(void);
int putchar(int val);
//void putchar(char val);

#endif // __GRAPHICS_TEXTMODE_H__
