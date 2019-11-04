/*	
 * Based on maildump.cpp
 *
 * Used to send data from host PC to Mailstation. Used in conjunction with
 * the Mailstation `Loader` app.
 *	
 * NOTE: It is unknown the last time this was compiled. At some point this
 * needs to be addressed and set up to be able to cleanly compile.
 *
 * Uses inpout32.dll to interface with I/O port of the parallel interface.
 */


#include <windows.h>
#include <stdio.h>
#include <math.h>

#define PORTADDRESS 0x378

#define DATA PORTADDRESS+0
#define STATUS PORTADDRESS+1
#define CONTROL PORTADDRESS+2

const unsigned char bsyin = 0x40;
const unsigned char bsyout = 0x08;
const unsigned char stbin = 0x80;
const unsigned char stbout = 0x10;
const unsigned char tribmask = 0x07;
const unsigned char dibmask = 0x03;

typedef short (_stdcall *inpfuncPtr)(short portaddr);
typedef void (_stdcall *oupfuncPtr)(short portaddr, short datum);

inpfuncPtr inp32fp;
oupfuncPtr oup32fp;

short  Inp32 (short portaddr)
{
	return (inp32fp)(portaddr);
}

void  Out32 (short portaddr, short datum)
{
	(oup32fp)(portaddr,datum);
} 


int InitIOLibrary()
{
	HINSTANCE hLib;

	hLib = LoadLibrary("inpout32.dll");

	if (hLib == NULL) {
		fprintf(stderr,"LoadLibrary Failed.\n");
		return -1;
	}

	inp32fp = (inpfuncPtr) GetProcAddress(hLib, "Inp32");

	if (inp32fp == NULL) {
		fprintf(stderr,"GetProcAddress for Inp32 Failed.\n");
		return -1;
	}

	oup32fp = (oupfuncPtr) GetProcAddress(hLib, "Out32");

	if (oup32fp == NULL) {
		fprintf(stderr,"GetProcAddress for Oup32 Failed.\n");
		return -1;
	}
}

int errcount = 0;
void handlerror(int code)
{
 	if (code == 1)
 		printf("timeout waiting for ms to drop busy.\n");
 	else if (code == 2)
 		printf("timeout waiting for ms to ack.\n");
 	else if (code == 3)
 		printf("timeout waiting for ms to strobe.\n");
 	else if (code == 4)
 		printf("timeout waiting for ms to drop strobe.\n");
 	else if (code == 5)
 		printf("timeout waiting for ms to drop busy/ack.\n");
 	else if (code == 6)
 		printf("aborted waiting for ms to send.\n");
  
	if (errcount > 20)
  	{
  		errcount = 0;
    	printf("Too many errors? hit esc to bail, other to continue:\n");
    	exit(-1);
  	}
}


unsigned char recvtribble()
{
	Out32(DATA,0);	// raise? (inverted?) busy/ack
	while ((Inp32(STATUS) & stbin) != 0) {}		// wait for strobe	
	unsigned char mytribble = (Inp32(STATUS) >> 3) & tribmask;	// grab tribble
	Out32(DATA,bsyout);		// drop? (inverted?) busy/ack	
	while ((Inp32(STATUS) & stbin) == 0) {}		// wait for UNstrobe	
	return mytribble;
}

unsigned char recvbyte()
{
	return (recvtribble() + (recvtribble() << 3) + ((recvtribble() & dibmask) << 6));
}


void printbinary(unsigned char x)
{
   int n;
   for(n=0; n<8; n++)
   {
      if((x & 0x80) !=0)
      {
         printf("1");
      }
      else
      {
         printf("0");
      }
      if (n==3)
      {
         //printf(" "); /* insert a space between nybbles */
      }
      x = x<<1;
   }
   printf(" ");
}

int sendtribble(unsigned char t)
{
	unsigned long int timeout = 0;
	Out32(DATA, bsyout);
	//Out32(DATA,0);
	
	while ((Inp32(STATUS) & bsyin) != 0) {  timeout++; if (timeout > 50000) { handlerror(1); return 0; } }
	//Out32(DATA, t & tribmask);
	Out32(DATA, (t & tribmask) | stbout);
	timeout = 0;
	
	while ((Inp32(STATUS) & bsyin) == 0) {  timeout++; if (timeout > 50000) { handlerror(2); return 0; } }		// wait for (inverted) UNstrobe
	//Out32(DATA, 0);
	Out32(DATA, bsyout);
	return 1;
}
int sendbyte(unsigned char b)
{
  unsigned char orgb = b;
  if (!sendtribble(b)) return 0;
  //printf("TRIBBLE: %d\n", b & tribmask);
  b >>= 3;
  if (!sendtribble(b)) return 0;
  //printf("TRIBBLE: %d\n", b & tribmask);
  b >>= 3;
  if (!sendtribble(b)) return 0;
  //printf("TRIBBLE: %d\n", b & tribmask);
  //printf("Sent %d\n", orgb);
  return 1;
}


void showhelp()
{
	printf("Mailsend v1.0 - by FyberOptic (fyberoptic@gmail.com)\n\nUsage:\n\tmailsend fyos.bin\n");
}


int main(int ARGC, void **ARGV)
{
	
	if (ARGC < 2) { showhelp(); return -1; }
	if (strcmp((char*)ARGV[1],"?") == 0 || 
	    strcmp((char*)ARGV[1],"/?") == 0 || 
	    strcmp((char*)ARGV[1],"-h") == 0) { showhelp(); return -1; }
	
	if (!InitIOLibrary()) { printf("Failed to initialize port I/O library\n"); return -1; }
	
	//Out32(DATA, stbout);
	//Out32(DATA,bsyout);
	Out32(DATA,0);
	
	/*while (1) { 
		int myrand = rand() % 256; 
		//myrand = 123; 
		if (!sendbyte(myrand)) { printf("FAIL SEND %d\n", myrand); return 0; Sleep(1000); } 
		else printf("%d\n", myrand); 
	}*/
	
	
	FILE * pFile;
  	unsigned int filesize;

  	pFile = fopen ((char*)ARGV[1],"rb");
  	if (pFile==NULL) { printf("Error opening file: %s\n",(char*)ARGV[1]); return -1; }

	fseek (pFile, 0, SEEK_END);
	filesize=ftell (pFile);
	fseek (pFile, 0, SEEK_SET);
	
	unsigned char *mycode = new unsigned char[filesize];
	fread ( mycode, 1, filesize, pFile );
	

	printf("%d bytes loaded.\nPrepare Mailstation for transfer, and press enter to continue\n", filesize);
	getchar();


	if (!sendbyte(filesize & 0xFF)) { printf("FAIL SEND LOWBYTE"); return 0; }
	if (!sendbyte(filesize >> 8)) { printf("FAIL SEND HIGHBYTE"); return 0; }
	
	int bytessent = 0;
	for (int n = 0; n < filesize; n++)
	{
		unsigned char currentbyte = mycode[n];
		if (!sendbyte(currentbyte)) { printf("FAIL SEND %d\n", currentbyte); return 0; }
		bytessent++;
		printf("\rSent: %d/%d",bytessent,filesize);
		
	}
	printf("\n");

	
	return 0;

}

