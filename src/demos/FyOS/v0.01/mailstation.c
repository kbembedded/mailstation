#include <stdio.h>
#include <string.h>
#include "mailstation.h"


/////////////////////////////////////////////////
//  Simply calls the mailstation firmware's
//  function at 0x0A6B to power down the unit.
/////////////////////////////////////////////////
void powerdownmode()
{
	__asm
		call #0x0A6B ; Mailstation firmware powerdownmode function
	__endasm;
}


/////////////////////////////////////////////////
//  Sets the LCD column address select bit.
// 
//  0 = CAS enabled
//  1 = CAS disabled
/////////////////////////////////////////////////
void LCD_CAS_C(unsigned char casbit)
{
	casbit = (casbit & 1) << 3;
	*p2shadow = (*p2shadow & 0xF7) | casbit;
	port2 = *p2shadow;
}



/////////////////////////////////////////////////
//  Clears text buffer + LCD.  Needs to be redone
//  in assembly for better speed.
/////////////////////////////////////////////////
void clrscr()
{
	unsigned char slot4000device_old = slot4000device;
	unsigned char *p4038 = &mem4000 + 0x38;
	int colnum;	
	
	cursorx = 0;
	cursory = 0;
	memset(textmodebuffer, 0, 640);	
	
	slot4000device = device_LCD_left;
	
	clearagain:
	for (colnum = 0; colnum < 20; colnum++)
	{
		LCD_CAS_C(0);
		*p4038 = colnum;
		LCD_CAS_C(1);
		memset(p4038, 0, 128);
	}
	if (slot4000device == device_LCD_left) { slot4000device = device_LCD_right; goto clearagain; }
		
	slot4000device = slot4000device_old;	
}


///////////////////////////////////////////////////////////
//  The following two functions were used for testing
//  purposes early on.  getchar works now so there's not
//  a lot of reason to need these at the moment.  getch 
//  waits for a scancode then returns with it in the
//  mycharbuffer variable, while getscancode returns 
//  immediately, placing "255" in the key state byte of 
//  mycharbuffer (second byte) if no scancode returned.
///////////////////////////////////////////////////////////
/*volatile unsigned char mycharbuffer[2];
unsigned char getch()
{	
	mycharbuffer[1] = 0;
	
	_asm
	push	af
	push 	de	
	; wait till a key is available
keyagain:
	ld	de, #_mycharbuffer
	push	de	
	call	#0x0A9A			; getkeycodefrombuffer	
	pop	de	
	jp	z, keyagain
	ld	a, (_mycharbuffer + 1)
	or	a
	jr	z, keyagain
	pop	de
	pop	af
	_endasm;	
	
	return mycharbuffer[0];
}*/

/*unsigned char getscancode()
{	
	//mycharbuffer[1] = 255;
	
	_asm
	; wait till a key is available
	ld	de, #_mycharbuffer
	push	de	
	call	#0x0A9A			; v3.03a firmware getkeycodefrombuffer	
	pop	de
	jr	nz, endgetscancode
	ld	a, #0d255
	ld	(_mycharbuffer + 1), a
endgetscancode:
	_endasm;	
	
	return mycharbuffer[1];
	
}*/


/////////////////////////////////////////////////
//  Works like putchar except lets you specify 
//  x/y coordinates to place it at.
/////////////////////////////////////////////////
void putcharXY(unsigned char x, unsigned char y, unsigned char c)
{
	unsigned char oldx, oldy;
	oldx = cursorx;
	oldy = cursory;
	
	cursorx = x;
	cursory = y;
	putchar(c);
	
	cursorx = oldx;
	cursory = oldy;
}


/////////////////////////////////////////////////
//  Works just like printf, except lets you
//  specify x/y coordinates to place it at.
/////////////////////////////////////////////////
void printfXY(unsigned char x, unsigned char y, char *xystring, ...)
{
	unsigned char oldx, oldy;
	va_list args;
	
	oldx = cursorx;
	oldy = cursory;     
	cursorx = x;
	cursory = y;
     
     	va_start( args, xystring );	
	vprintf( xystring, args );
	va_end( args );
	//printf(xystring, stringvars);

	cursorx = oldx;
	cursory = oldy;	
}


/////////////////////////////////////////////////
//  Works just like printf, except centers the
//  string(s).  Can deal with line feeds, but 
//  multiple line feeds must at least be sep-
//  arated by a space character.
/////////////////////////////////////////////////
void printfcenter(char *centerstring, ...)
{
	va_list args;
	char tempstring[255];
	char *result = NULL;
	
	va_start( args, centerstring );	
	vsprintf(tempstring, centerstring, args);
	va_end( args );
		
   	result = strtok(tempstring, "\n");
   	while (result != NULL) 
   	{
		cursorx = (40 - strlen(result)) / 2;
		printf("%s\n", result);
       		result = strtok( NULL, "\n" );
   	}            
	
	
}



/////////////////////////////////////////////////
//  Converts the single hex character into its
//  numeric equivalent.  Returns -1 if not a
//  valid hex byte.
/////////////////////////////////////////////////
int hex_nibble (char x) 
{ 
        if (x >= '0' && x <= '9') return x - '0'; 
        if (x >= 'a' && x <= 'f') return x - 'a' + 10; 
        if (x >= 'A' && x <= 'F') return x - 'A' + 10; 
        return -1;
}


/////////////////////////////////////////////////
//  Takes hexstring and converts it into an
//  unsigned integer, placing it at the location
//  pointed to by hexint.  Returns -1 if an
//  invalid character is found.
/////////////////////////////////////////////////
char hextoint(char *hexstring, unsigned int *hexint)
{
	unsigned int tempint = 0;
	char tempnibble;
	unsigned int n;
	
	for (n = 0; n < strlen(hexstring); n++)
	{
		tempnibble = hex_nibble(hexstring[n]);
		if (tempnibble == -1) return -1;
		tempint = tempint << 4;
		tempint |= tempnibble;
	}
	*hexint = tempint;
	return 1;
}


/////////////////////////////////////////////////
//  Takes hexstring and converts it into an
//  unsigned char, placing it at the location
//  pointed to by hexbyte.  Returns -1 if an
//  invalid character is found.
/////////////////////////////////////////////////
char hextobyte(char *hexstring, unsigned char *hexbyte)
{
	unsigned int tempbyte = 0;
	char tempnibble;
	unsigned int n;
	
	for (n = 0; n < strlen(hexstring); n++)
	{
		tempnibble = hex_nibble(hexstring[n]);
		if (tempnibble == -1) return -1;
		tempbyte = tempbyte << 4;
		tempbyte |= tempnibble;
	}
	*hexbyte = tempbyte;
	return 1;
}



/////////////////////////////////////////////////
//  Reads a string from the console into s, and
//  returns pointer to same .  This function
//  was taken from SDCC's SRC directory.
/////////////////////////////////////////////////
char * gets(char *s) {
  char c;
  unsigned int count=0;
  
  while (1) {
    c=getchar();
    switch(c) {
    case '\b': // backspace
      if (count) {
	putchar ('\b');
	putchar (' ');
	putchar ('\b');
	s--;
	count--;
      }
      break;
    case '\n':
    case '\r': // CR or LF
      putchar('\r');
      putchar('\n');
      *s=0;
      return s;
    default:
      *s++=c;
      count++;
      putchar(c);
      break;
    }
  }
}

/////////////////////////////////////////////////
//  Returns 1 if parameter is uppercase, 0 if not
/////////////////////////////////////////////////
char isupper(char upperchar)
{
	if (upperchar >= 65 && upperchar <= 90) return 1;
	return 0;
}


/////////////////////////////////////////////////
//  Converts a single character to lowercase,
//  returns the result.
/////////////////////////////////////////////////
char tolower(char upperchar)
{
	if (isupper(upperchar)) return upperchar + 32;
		else return upperchar;
}


/////////////////////////////////////////////////
//  Converts an entire string to uppercase.
/////////////////////////////////////////////////
void strtolower(char *upperstring)
{
	char *stringpointer = upperstring;
	
	while (*stringpointer != 0)
	{
		*stringpointer = tolower(*stringpointer);
		stringpointer++;		
	}
}

