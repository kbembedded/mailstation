#include <stdio.h>
#include <string.h>
#include "mailstation.h"
#include "fyos.h"

unsigned char myglobal = 100;
unsigned char inputstring[256];
unsigned char lastinputstring[256];




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
		if (hextoint(result, &hexint) == 1) printf("%s -> %x\n", result, mempointer[hexint]);
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
   	else printf("%x -> %x\n", hexint, hexbyte);
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
		if (hextoint(result, &hexint) == 1) printf("%s -> %u\n", result, hexint);
			else printf("Invalid hex: %s\n", result);
       		result = strtok( NULL, " " );
   	}
   	
   	if (parmnum == 0) { printf("Usage: hextoint FFC 422A 3B...\n"); }
   	printf("\n");
}



void cmd_help(char *helpcommand)
{	
	if (strlen(helpcommand) < 1)
	{			
		printf("Available commands:\n\n");
		printf(" CLS, EXIT, HELP, HEXTOINT, PEEK, POKE,\n POWERDOWN, REBOOT, RESET\n\n");
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
	else if (strcmp(helpcommand, "reset") == 0) printf("RESET resets FyOS to initial screen.\n\n");
	else if (strcmp(helpcommand, "restart") == 0) printf("RESTART jumps to FyOS init at 0x8000.\n\n");
	else if (strcmp(helpcommand, "reboot") == 0) printf("REBOOT resets the Mailstation to 0x0000.\n\n");
	else if (strcmp(helpcommand, "powerdown") == 0) printf("POWERDOWN turns off the Mailstation\n  via firmware function 0x0A6B.\n\n");
	else printf("Unknown command: %s\n", helpcommand);
	
}


int main()
{
	unsigned int timer = 0;
	unsigned int gotkey = 0;
	char *stringpointer = NULL;	
	
	cursorx = 0;
	cursory = 0;	

	__asm
		call	#0x0AA0		; init_keyboard, prolly not necessary, but clears out prior keypresses
		;call	#0x0A9D  	; init_keybuffer
	__endasm;

	resetprogram:
	clrscr();
	printfcenter("FyOS v0.01\n  by FyberOptic\n \n");
	printf("Mailstation firmware: v%d.%d\n", versionpointer[1], versionpointer[0]);
	if (firmwareversionsafe == 0) printf("Version safe: yes\n\n");
	else if (firmwareversionsafe == 2) printf("Version safe: no, defaulting to v2.53\n\n");
	else if (firmwareversionsafe == 3) printf("Version safe: no, defaulting to v3.03\n\n");

	printf("Global var init test: ");
	if (myglobal == 100) printf("Pass");
	else printf("Fail");
		
	printf("\nP2shadow: %x\nP3shadow: %x\ncgafont_addr: %x\n\n", p2shadow, p3shadow, cgafont_addr);
	//printf("This is a test of a really long string on the screen.  It should probably wrap around since it's using my original assembly code.\n\n");	

	
commandloop:
	printf(">"); gets(inputstring);
	if (inputstring[0] == '\0') goto commandloop;
	strncpy(lastinputstring, inputstring, 255);
		
	stringpointer = strtok(inputstring, " ");		// separate command
   	if (stringpointer == NULL) stringpointer = inputstring;
	
	if (strcmp(stringpointer, "reset") == 0) goto resetprogram;
	else if (strcmp(stringpointer, "exit") == 0) goto endprogram;
	else if (strcmp(stringpointer, "hextoint") == 0) { cmd_hextoint(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "clrscr") == 0) { clrscr(); goto commandloop; }
	else if (strcmp(stringpointer, "cls") == 0) { clrscr(); goto commandloop; }
	else if (strcmp(stringpointer, "peek") == 0) { cmd_peek(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "poke") == 0) { cmd_poke(strtok(NULL, "\0")); goto commandloop; }
	else if (strcmp(stringpointer, "help") == 0) { cmd_help(strtok(NULL, "\0")); goto commandloop; }
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
