#include <stdio.h>
#include <string.h>
#include "mailstation.h"
#include "fyos.h"

unsigned char myglobal = 100;
unsigned char inputstring[256];
//unsigned char lastinputstring[256];

extern volatile unsigned int interrupt_counter;

void cmd_peek(char *inputstring)
{
	char *result = NULL;
	unsigned char *mempointer = 0;
	unsigned int hexint;
	int parmnum = 0;
	
	result = strtok(inputstring, " ");
   	while (result != NULL) 
   	{
		parmnum++;
		hexint = 0;
		if (hextoint(result, &hexint) == 1) printf("%04x -> %02x\n", hexint, mempointer[hexint]);
			else printf("Invalid hex: %s\n", result);
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: peek FFFF D42 F03B...\n"); }
   	printf("\n");
}

void cmd_poke(char *inputstring)
{
	char *result = NULL;
	unsigned char *mempointer = 0;
	unsigned int hexint = 0;
	unsigned char hexbyte = 0;
	int parmnum = 0;
	
	result = strtok(inputstring, " ");
   	while (result != NULL) 
   	{
		parmnum++;
		if (parmnum == 1)
		{
			hexint = 0;
			if (hextoint(result, &hexint) == 1) mempointer = (unsigned char *)hexint;
			else { printf("Invalid address: %s\n\n", result); return; }
       		}
       		if (parmnum == 2)
       		{
       			hexbyte = 0;
       			if (hextobyte(result, &hexbyte) == 1) *mempointer = hexbyte;
       			else { printf("Invalid data byte: %s\n\n", result); return; }
       		}
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: poke ABCD E1\n"); }
   	else printf("%04x -> %02x\n", hexint, hexbyte);
   	printf("\n");
}



void cmd_port_in(char *inputstring)
{
	char *result = NULL;
	unsigned char *mempointer = 0;
	unsigned int hexint = 0;
	volatile unsigned char hexbyte = 0;
	int parmnum = 0;
	
	result = strtok(inputstring, " ");
   	while (result != NULL) 
   	{
		parmnum++;
		hexint = 0;
		hexbyte = 0;
		if (hextoint(result, &hexint) == 1)
		{
       			__asm
				push	af
				push	bc
				ld	c, -4(ix)	; low byte hexint		
       				ld	b, -3(ix)	; high byte hexint       				
       				in	a, (C)
       				ld	-5(ix), a	; hexbyte
       				pop	bc
       				pop	af
       			__endasm;
       			printf("%04x -> %02x\n", hexint, hexbyte);
		}
		else { printf("Invalid address: %s\n\n", result); return; }       		
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: PORT_IN AB E1...\n"); }   	
   	printf("\n");
}



void cmd_port_out(char *inputstring)
{
	char *result = NULL;
	unsigned char *mempointer = 0;
	unsigned int hexint = 0;
	unsigned char hexbyte = 0;
	int parmnum = 0;
	
	result = strtok(inputstring, " ");
   	while (result != NULL) 
   	{
		parmnum++;
		if (parmnum == 1)
		{
			hexint = 0;
			if (hextoint(result, &hexint) == 1) {}
			else { printf("Invalid address: %s\n\n", result); return; }
       		}
       		if (parmnum == 2)
       		{
       			hexbyte = 0;
       			if (hextobyte(result, &hexbyte) == 1)
       			{
       				__asm
					push	af
					push	bc
					ld	c, -4(ix)	; low byte hexint		
       					ld	b, -3(ix)	; high byte hexint
       					ld	a, -5(ix)	; hexbyte
       					out	(C), a
       					pop	bc
       					pop	af
       				__endasm;
       			}
       			else { printf("Invalid data byte: %s\n\n", result); return; }
       		}
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: PORT_OUT AB E1\n"); }
   	else printf("%04x -> %02x\n", hexint, hexbyte);
   	printf("\n");
}



void cmd_hextoint(char *inputstring)
{
	char *result = NULL;
	unsigned int hexint;
	int parmnum = 0;
	
	result = strtok(inputstring, " ");
   	while (result != NULL) 
   	{
		parmnum++;
		hexint = 0;
		if (hextoint(result, &hexint) == 1) printf("%4s -> %u\n", result, hexint);
			else printf("Invalid hex: %s\n", result);
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: hextoint FFC 422A 3B...\n"); }
   	printf("\n");
}


void cmd_scancodes()
{
	unsigned char lastkey = 0;
	unsigned char mycharbuffer[2];
	
	while (getscancode(mycharbuffer) == 255) {} // get last scancodes just to clear it out
	
	printf("Press any key to show scancode, or Back to return to command prompt.\n\n");
	
	while (lastkey != 1)
	{		
		if (getscancode(mycharbuffer) != 255)
		{
			printfcenter("Scancode: %03d   Key state: %03d\n", mycharbuffer[0], mycharbuffer[1]);
			lastkey = mycharbuffer[0];
		}		
	}
	printf("\n");
	while (kbhit()) getchar();
}


void cmd_help(char *helpcommand)
{	
	// if (strlen(helpcommand) < 1)
	// Saves some bytes to do this instead of strlen
	if (helpcommand[0] == 0)
	{			
		printf("Available commands:\n\n");
		printf(" CLS, EXIT, HELP, HEXTOINT, PEEK, POKE,\n PORT_IN, PORT_OUT, POWERDOWN, REBOOT,\n RESET, SCANCODES\n\n");
		printf("Use HELP <COMMAND> for more info.\n\n");
		return;
	}
	strtolower(helpcommand);
	if (strcmp(helpcommand, "cls") == 0) printf("CLS clears the screen.\n\n");	
	else if (strcmp(helpcommand, "exit") == 0) printf("EXIT launches original page4000 loader.\n\n");
	else if (strcmp(helpcommand, "help") == 0) printf("You're looking at it.\n\n");
	else if (strcmp(helpcommand, "hextoint") == 0) printf("HEXTOINT displays hex strings as\n  integers.\n\n");
	else if (strcmp(helpcommand, "peek") == 0) printf("PEEK displays memory locations in hex.\n\n");
	else if (strcmp(helpcommand, "poke") == 0) printf("POKE writes a byte to a memory location.\n\n");
	else if (strcmp(helpcommand, "port_out") == 0) printf("PORT_OUT writes a byte to a port.\n\n");
	else if (strcmp(helpcommand, "port_in") == 0) printf("PORT_IN reads a byte from port(s).\n\n");
	else if (strcmp(helpcommand, "reset") == 0) printf("RESET resets FyOS to initial screen.\n\n");
	else if (strcmp(helpcommand, "restart") == 0) printf("RESTART jumps to FyOS init at 0x8000.\n\n");
	else if (strcmp(helpcommand, "reboot") == 0) printf("REBOOT resets the Mailstation to 0x0000.\n\n");
	else if (strcmp(helpcommand, "scancodes") == 0) printf("SCANCODES is an interactive key viewer.\n\n");
	else if (strcmp(helpcommand, "powerdown") == 0) printf("POWERDOWN turns off the Mailstation\n  via firmware function 0x0A6B.\n\n");
	else printf("Unknown command: %s\n", helpcommand);	
}


void printSP()
{
	volatile unsigned int SPval = 0;
	
	__asm
		ld	hl, #0
		add	hl, sp
		ld	-1(ix), h
		ld	-2(ix), l
	__endasm;
		
	printf("SP: %x\n", SPval);
}


int main()
{
	unsigned int timer = 0;
	unsigned int gotkey = 0;
	char *stringpointer = NULL;	
	
	cursorx = 0;
	cursory = 0;	

	/*
	_asm
		call	#0x0AA0		; init_keyboard
		;call	#0x0A9D  	; init_keybuffer
	_endasm;
	*/

	resetprogram:
	clrscr();
	printfcenter("FyOS v0.021\n  by FyberOptic\n \n");
	printf("Mailstation firmware: v%d.%d\n", versionpointer[1], versionpointer[0]);
	
	printf("Version safe: ");
	switch (firmwareversionsafe)
	{
		case 0:	printf("yes"); break;
		case 2: printf("no, defaulting to v2.53"); break;
		case 3: printf("no, defaulting to v3.03"); break;
		default: printf("unknown"); break;
	}	

	printf("\n\nGlobal var init test: ");
	if (myglobal == 100) printf("Pass");
	else printf("Fail");
		
	printf("\nP2shadow: %x\nP3shadow: %x\ncgafont_addr: %x\n\n", p2shadow, p3shadow, cgafont_addr);	

	printSP();

	//memset(graphicsmodebuffer, 255, 5120);
	//UpdateGraphicsLCD();
	//getchar();
	
commandloop:
	printf(">"); gets(inputstring);
	printf("Counter: %u\n", interrupt_counter);
	if (inputstring[0] == '\0') goto commandloop;
	//strncpy(lastinputstring, inputstring, 255);
		
	stringpointer = strtok(inputstring, " ");		// separate command
   	if (stringpointer == NULL) stringpointer = inputstring;
	
	if (strcmp(stringpointer, "reset") == 0) goto resetprogram;
	else if (strcmp(stringpointer, "exit") == 0) goto endprogram;
	else if (strcmp(stringpointer, "hextoint") == 0) { cmd_hextoint(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "clrscr") == 0) { clrscr(); goto commandloop; }
	else if (strcmp(stringpointer, "cls") == 0) { clrscr(); goto commandloop; }
	else if (strcmp(stringpointer, "peek") == 0) { cmd_peek(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "poke") == 0) { cmd_poke(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "port_in") == 0) { cmd_port_in(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "port_out") == 0) { cmd_port_out(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "help") == 0) { cmd_help(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "scancodes") == 0) { cmd_scancodes(); goto commandloop; }
	else if (strcmp(stringpointer, "powerdown") == 0) { powerdownmode(); goto commandloop; }
	else if (strcmp(stringpointer, "restart") == 0)
	{
		__asm
			jp 0x8000
		__endasm;
	}
	else if (strcmp(stringpointer, "reboot") == 0)
	{
		__asm
			jp 0x0000
		__endasm;
	}
	else
	{		
		printf("Unknown command: %s\n\n", inputstring);
		goto commandloop;
	}

	
	endprogram:
	clrscr();
	printf("\n\n\n\n\n\n\n\n        Waiting for transfer...");
	return 0;
	
}
