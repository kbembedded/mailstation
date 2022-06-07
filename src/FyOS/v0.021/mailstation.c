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
//
//  NOTE: Moved to putchar.s
/////////////////////////////////////////////////
/*
void LCD_CAS(unsigned char casbit)
{
	casbit = (casbit & 1) << 3;
	*p2shadow = (*p2shadow & 0xF7) | casbit;
	port2 = *p2shadow;
}
*/


/////////////////////////////////////////////////
//  Clears text buffer + LCD.  Needs to be redone
//  in assembly for better speed.
//
//  NOTE: Much was optimized into the assembly
//  function ClearLCD() in putchar.s.
/////////////////////////////////////////////////
void clrscr()
{
	//unsigned char slot4000device_old = slot4000device;
	//unsigned char *p4038 = &mem4000 + 0x38;
	//int colnum;	
	
	cursorx = 0;
	cursory = 0;
	memset(textmodebuffer, 0, 640);	
	
	ClearLCD();
	
	/*
	slot4000device = device_LCD_left;
	
	clearagain:
	for (colnum = 0; colnum < 20; colnum++)
	{
		LCD_CAS(0);
		*p4038 = colnum;
		LCD_CAS(1);
		memset(p4038, 0, 128);
	}
	if (slot4000device == device_LCD_left) { slot4000device = device_LCD_right; goto clearagain; }
		
	slot4000device = slot4000device_old;	
	*/
}





///////////////////////////////////////////////////////////
//  Gets a scancode + key state from the Mailstation's
//  keyboard buffer and places the two bytes into the
//  specified "charbuffer" location.  If no key was 
//  returned, the key state, charbuffer[1], will be set
//  to 255.
//
//  Key state bits:
//  0 = Set if key was pressed, clear if key was released
//  5 = Set if Caps Lock was on when key was toggled
//  6 = Set if Shift was held when key was toggled
//  7 = Set if Fn was held when key was toggled
///////////////////////////////////////////////////////////
int getscancode(unsigned char *charbuffer)
{	
	__asm	
	push	af
	push	ix
	
	ld	ix, #2 + #6 + #2	; C-pushed ix + pushed regs + ret address
	add	ix, sp
	ld	l, 0x0(ix)
	ld	h, 0x1(ix)
	
	;ld	a, h
	;ld	(#0xc010), a
	;ld	a, l
	;ld	(#0xc011), a

	push	hl
	call	ms_getkeycodefrombuffer	;#0x0A9A MS firmware getkeycodefrombuffer
	pop	hl
	inc	hl
		
	jr	nz, endgetscancode
	ld	a, #0d255
	ld	(hl), a
endgetscancode:
	ld	a, (hl)
	ld	h, #0
	ld	l, a
	pop	ix
	pop	af	
	__endasm;

	
	return charbuffer[1];	
}


/////////////////////////////////////////////////
//  Works like putchar except lets you specify 
//  x/y coordinates to place it at.
/////////////////////////////////////////////////
/*void putcharXY(unsigned char x, unsigned char y, unsigned char c)
{	
	unsigned char oldx, oldy;
	oldx = cursorx;
	oldy = cursory;
	
	cursorx = x;
	cursory = y;
	putchar(c);
	
	cursorx = oldx;
	cursory = oldy;
}*/


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
//  invalid hex character is found.
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
		tempint <<= 4;
		tempint |= tempnibble;
	}
	*hexint = tempint;
	return 1;
}


/////////////////////////////////////////////////
//  Takes hexstring and converts it into an
//  unsigned char, placing it at the location
//  pointed to by hexbyte.  Returns -1 if an
//  invalid hex character is found.
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
//
//  Modified to filter out extended keys
/////////////////////////////////////////////////
char *gets(char *s)
{
	char c;
	unsigned int count=0;
  
	while (1)
	{
		c=getchar();
		switch(c)
		{
    			case 0:	// Filter extended keys
    				getchar(); break;
    
    			case '\b': // backspace
      				if (count)
      				{
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
      				if (count < 255)	// limit string to 255 chars
      				{
      					*s++=c;
      					count++;
      					putchar(c);
      				}
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
	return upperchar;
}


/////////////////////////////////////////////////
//  Converts an entire string to lowercase.
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

