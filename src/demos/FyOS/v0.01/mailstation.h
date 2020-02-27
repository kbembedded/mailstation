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


// Define some pointers for page4000 addressing
volatile unsigned char __at 0x4000 mem4000;
//unsigned char *pmem4000 = &mem4000;

// Define some ports
__sfr __at 0x02 port2;
__sfr __at 0x05 slot4000page;
__sfr __at 0x06 slot4000device;
__sfr __at 0x07 slot8000page;
__sfr __at 0x08 slot8000device;

// Define some device IDs
#define device_codeflash	0x00	// 64 pages
#define device_ram		0x01	// 08 pages
#define device_LCD_left		0x02	// 01 pages
#define	device_dataflash	0x03	// 32 pages
#define device_LCD_right	0x04	// 01 pages
#define device_modem		0x05	// 01 pages



// Define some functions
void powerdownmode();
void LCD_CAS_C(unsigned char casbit);
void clrscr();
//unsigned char getch();
//unsigned char getscancode();
void putcharXY(unsigned char x, unsigned char y, unsigned char c);
void printfXY(unsigned char x, unsigned char y, char *xystring, ...);
void printfcenter(char *centerstring, ...);
int hex_nibble (char x) ;
char hextoint(char *hexstring, unsigned int *hexint);
char hextobyte(char *hexstring, unsigned char *hexbyte);
char *gets(char *s);
char isupper(char upperchar);
char tolower(char upperchar);
void strtolower(char *upperstring);


#endif
