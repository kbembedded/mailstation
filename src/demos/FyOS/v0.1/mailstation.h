#ifndef _INCL_MAILSTATION
#define _INCL_MAILSTATION

// External variables defined in assembly code
extern volatile unsigned char textmodebuffer[640];
extern volatile unsigned char cursorx;
extern volatile unsigned char cursory;
extern unsigned char *cgafont_addr;
extern unsigned char *p2shadow;
extern unsigned char *p3shadow;
extern unsigned char firmwareversionsafe;
extern unsigned char *_scancode_table;

extern unsigned char _getcharbuffer;
extern unsigned char *_getcharbuffer_ptr;
extern unsigned char _getcharbuffer_in;
extern unsigned char _getcharbuffer_out;
	
// Pointer to the graphical LCD buffer, if wanted (5120 bytes)
//volatile unsigned char *graphicsmodebuffer = (unsigned char *)0xC010;

// Pointers for easy page4000 addressing
volatile unsigned char __at 0x4000 mem4000;
//unsigned char *pmem4000 = &mem4000;

// Pointer to the Mailstation firmware version
// versionpointer[0] is the minor version
// versionpointer[1] is the major version
//unsigned char *versionpointer = (unsigned char *)0x0036;


// Define some ports
__sfr __at 0x02 port2;
__sfr __at 0x05 slot4000page;
__sfr __at 0x06 slot4000device;
__sfr __at 0x07 slot8000page;
__sfr __at 0x08 slot8000device;
__sfr __at 0x21 port_printerstatus;
__sfr __at 0x2d port_printerdata;

// Define some device IDs
#define device_codeflash	0x00	// 64 pages
#define device_ram		0x01	// 08 pages
#define device_LCD_left		0x02	// 01 pages
#define	device_dataflash	0x03	// 32 pages
#define device_LCD_right	0x04	// 01 pages
#define device_modem		0x05	// 01 pages


//int (*getkeycodefrombuffer)(char *scancodedest) = (int (*)(char*))0x0A9A;

// Define some functions.  These are described in mailstation.c.
void powerdownmode();
void clrscr();
int getscancode(unsigned char *charbuffer);
//void putcharXY(unsigned char x, unsigned char y, unsigned char c);
void printfXY(unsigned char x, unsigned char y, char *xystring, ...);
void printfcenter(char *centerstring, ...);
int hex_nibble (char x) ;
char hextoint(char *hexstring, unsigned int *hexint);
char hextobyte(char *hexstring, unsigned char *hexbyte);
char *gets(char *s);
char isupper(char upperchar);
char tolower(char upperchar);
void strtolower(char *upperstring);

// External functions, described in putchar.s
extern void LCD_CAS(char);
extern void ClearLCD();
extern void scrollscreen();
extern void UpdateCharLCD();
extern void putcharXY(unsigned char x, unsigned char y, unsigned char c, unsigned char ordata);

// External functions, described in getchar.s
extern void fillcharbuffer();
extern int kbhit();
extern void disable_charbuffer();
extern void enable_charbuffer();


// External functions, described in ms_plink.s
extern int send_byte_busy(char sendchar);
extern int recv_byte(char *charpointer);

// External functions, described in graphicslcd.s
extern void UpdateGraphicsLCD();

#endif
