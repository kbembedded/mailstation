/* SPDX-License-Identifier: BSD-2-Clause */
/* Based on work from FybderOptic (fyberoptic@gmail.com) which was based
 * on work from Cyrano Jones of the original Yahho! Mailstation group. */

/* Used to send binary blobs between host PC and Mailstation device.
 *
 * This was put together quickly to address a few shortcomings and unify send/
 * recv to a single tool. Meant to be used in conjunction with the MS Loader
 * tool on the Mailstation to download or upload binary blobs of data.
 *
 * This tool is pretty rough and poorly implemented, but it should at least now
 * be compatible with PCIe Parallel port devices on a host that may not lie
 * anywhere close to the traditional IO addresses. See help for use.
 *
 * Uses inpout32.dll to interface with I/O port of the parallel interface.
 * This .dll is included in this repo since I have no idea where the sources
 * are. This is a 32-bit dll I think.
 *
 * Compilation has only been tested with 32-bit MinGW from a Linux host, e.g.
 * i686-w64-mingw32-gcc  This should also work with a MinGW install in Windows.
 */

#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <unistd.h>
//#include <windows.h>
#include "vparlib.h"

uint16_t DATA;
uint16_t STATUS;
uint16_t CONTROL;

const unsigned char BSY_IN = 0x40;
const unsigned char BSY_OUT = 0x08;
const unsigned char STB_IN = 0x80;
const unsigned char STB_OUT = 0x10;
const unsigned char TRIBMASK = 0x07;
const unsigned char DIBMASK = 0x03;

const struct conn_opts opts = {
	.hostpubsock = "8888",
	.devpubsock = "9999",
	.hosturl = "localhost",
	.devurl = "localhost",
	.conn_role = DEVICE,
	.conn_cable = VPAR_MODE_MS_LAPLINK,
	.blocking = VPAR_DONTWAIT,
};

enum operation {
	OP_NONE = 0,
	OP_SEND = 1,
	OP_RECV = 2
};

uint8_t  Inp32 (void *handle, short portaddr)
{
	uint8_t rc = vpar_read_reg(handle, portaddr);
	return rc;
}

void  Out32 (void *handle, short portaddr, uint8_t datum)
{
	vpar_update_tx_reg_and_write(handle, portaddr, datum);
	//usleep(100000);
}


int errcount = 0;
void handlerror(int code)
{
	if (code == 1)
		printf("\ntimeout waiting for ms to drop busy.\n");
	else if (code == 2)
		printf("\ntimeout waiting for ms to ack.\n");
	else if (code == 3)
		printf("\ntimeout waiting for ms to strobe.\n");
	else if (code == 4)
		printf("\ntimeout waiting for ms to drop strobe.\n");
	else if (code == 5)
		printf("\ntimeout waiting for ms to drop busy/ack.\n");
	else if (code == 6)
		printf("\naborted waiting for ms to send.\n");

	if (errcount > 20) {
		errcount = 0;
		printf("Too many errors?\n");
		exit(-1);
	}
}


uint8_t recvtribble(void *handle)
{
	uint8_t trib;

	/* Wait for MS to raise Busy and ACK it*/
	while (!(Inp32(handle, STATUS) & BSY_IN));
	Out32(handle, DATA, 0);

	/* XXX: Add timeout? */
	/* Wait for strobe from MS, grab tribble of data, ACK data received,
	 * then wait for MS to ACK our ACK? */
	while ((Inp32(handle, STATUS) & STB_IN) != 0);
	trib = (Inp32(handle, STATUS) >> 3) & TRIBMASK;
	Out32(handle, DATA, BSY_OUT);
	while ((Inp32(handle, STATUS) & STB_IN) == 0);

	return trib;
}

uint8_t recvbyte(void *handle)
{
	return (recvtribble(handle) + (recvtribble(handle) << 3) + ((recvtribble(handle) & DIBMASK) << 6));
}

int sendtribble(void *handle, uint8_t trib)
{
	unsigned long int timeout = 0;

	//printf("sending trib 0x%02x\n", trib);

	/* Set Busy out and wait for Busy in */
	Out32(handle, DATA, BSY_OUT);

	while ((Inp32(handle, STATUS) & BSY_IN) != 0) {
		timeout++;
		if (timeout > 5000) {
			handlerror(1);
			return 0;
		}
		usleep(1);

	}

	/* Set data and strobe output, clear Busy out for some reason? XXX: */
	Out32(handle, DATA, ((trib & TRIBMASK) | STB_OUT));
	timeout = 0;

	/* Wait for data acknowledge */
	while ((Inp32(handle, STATUS) & BSY_IN) == 0) {
		timeout++;
		if (timeout > 5000) {
			handlerror(2);
			return 0;
		}
		usleep(1);
	}

	/* Set Busy out again? */
	//Out32(DATA, 0);
	Out32(handle, DATA, BSY_OUT);

	return 1;
}

int sendbyte(void *handle, uint8_t dat)
{
  //printf("sending byte 0x%02x\n", dat);
  if (!sendtribble(handle, dat & TRIBMASK)) return 0;

  dat >>= 3;
  if (!sendtribble(handle, dat & TRIBMASK)) return 0;

  dat >>= 3;
  if (!sendtribble(handle, dat & TRIBMASK)) return 0;

  return 1;
}


void usage(char **argv)
{
	fprintf(stderr,
	  "Usage:\n"
	  "  %s OPERATION [OPTION] ...\n"
	  "Send or recieve data from the Mailstation Loader Utility\n\n"
	  "OPERATION is one of:\n"
	  "  -s, --send      Send file to Mailstation via parallel port\n"
	  "  -r, --revc      Receive file from Mailstation via parallel port\n\n"
	  "OPTIONS are:\n"
	  "  -h, --help       This help\n"
	  "  -p, --port=ADDR  LPT port address [default 0x378]\n"
	  "  -f, --file=FILE  Filename to send\n"
	  "  -l, --len=LEN    Length of file to recv [default 0x100000]\n",
	  argv[0]);
}


int main(int argc, char **argv)
{
	int c, i;
	uint16_t port = 0x0378;
	FILE *fd = NULL;
	uint8_t *fbuf = NULL;
	char *fpath = NULL;
	unsigned int filesize = 0x100000; // 1 MiB
	int bytecnt;
	enum operation opt_operation = OP_NONE;
	void *handle = NULL;

	static struct option long_options[] = {
	  { "send",	no_argument,		NULL, 's' },
	  { "recv",	no_argument,		NULL, 'r' },
	  { "port",	required_argument,	NULL, 'p' },
	  { "file",	required_argument,	NULL, 'f' },
	  { "help",	no_argument,		NULL, 'h' },
	  { "len",	required_argument,	NULL, 'l' },
	  { NULL,	no_argument,		NULL,  0  }
	};

	if (argc == 1) {
		usage(argv);
		return 1;
	}

	while ((c = getopt_long(argc, argv,
	  "srp:f:l:h",
	  long_options, NULL)) != -1) {
		switch (c) {
		  case 's': /* Send data */
			opt_operation = OP_SEND;
			break;
		  case 'r': /* Recv data */
			opt_operation = OP_RECV;
			break;
		  case 'p': /* Set port */
			port = (uint16_t)strtoul(optarg, NULL, 0);
			break;
		  case 'f': /* File to send/recv */
			/* XXX: I know nothing of the intracacies of MAX_PATH
			 * in Windows. This might be unsafe. You've been
			 * warned! */

			/* strlen does not include trailing \0 in its count */
			fpath = (char *)malloc((size_t)strlen(optarg) + 1);
			strcpy(fpath, optarg);
			break;
		  case 'l': /* Length of file to recv */
			filesize = strtoul(optarg, NULL, 0);
			break;
		  default:
			usage(argv);
			break;
		}
	}

	DATA = VPAR_DR;
	STATUS = VPAR_SR;
	CONTROL = VPAR_CR;

	handle = vpar_init(&opts);


	/* Clear the data output of the parallel port pins */
	/* XXX: Do we need to clear CTRL too? */
	Out32(handle, DATA, 0);

	/* At least one operation must be specified */
	if (opt_operation == OP_NONE) {
		fprintf(stderr, "A send or recv operation must be specified!\n\n");
		usage(argv);
		return 1;
	}

	/* File must be passed */
	if (fpath == NULL) {
		fprintf(stderr, "Both send and recv require a file argument!\n\n");
		usage(argv);
		return 1;
	}

	if (opt_operation == OP_SEND) {
		fd = fopen(fpath, "rb");
		if (fd == NULL) {
			fprintf(stderr, "Error opening file: \'%s\'\n", fpath);
			free(fpath);
			return 1;
		}
		free(fpath);

		/* Get filesize, allocate buffer, fill buffer, close file */
		fseek(fd, 0, SEEK_END);
		filesize = ftell(fd);
		fseek(fd, 0, SEEK_SET);
		fbuf = (uint8_t *)malloc(filesize);
		/* XXX: No checking of malloc return! */
		fread(fbuf, 1, filesize, fd);
		fclose(fd);

		fprintf(stderr, "%d bytes loaded.\nPrepare Mailstation for transfer, and press enter to continue\n", filesize);
		getchar();
		Inp32(handle, DATA);

		/* Send length of file information to MS, LSB first */
		if (!sendbyte(handle, filesize & 0xFF)) {
			fprintf(stderr, "FAIL SEND LOWBYTE");
			return 1;
		}
		if (!sendbyte(handle, (filesize >> 8) & 0xFF)) {
			fprintf(stderr, "FAIL SEND HIGHBYTE");
			return 1;
		}

		for (i = 0; i < filesize; i++)
		{
			if (!sendbyte(handle, fbuf[i])) {
				printf("FAIL SEND @ byte %d\n", i+1);
				return 1;
			}
			printf("\rSent: %d/%d", (i + 1), filesize);

		}
		printf("\n");
	}
	if (opt_operation == OP_RECV) {
		fprintf(stderr, "Waiting for %d bytes, writing to \'%s\'\n",
		  filesize, fpath);
		/* Open file for writing */
		fd = fopen(fpath, "wb");
		if (fd == NULL) {
			fprintf(stderr, "Error opening file: \'%s\'\n", fpath);
			free(fpath);
			return 1;
		}
		free(fpath);

		fbuf = (uint8_t *)malloc(filesize);

		/* XXX: At some point, implement the following */
		/* Wait for first byte, then collect bytes until they stop. This
		 * is a bit of a hack because 2 bytes is not enough to express
		 * the size of DF or CF for dumping. This is a weird situation
		 * thats going to exist for now. Need to design a sane header
		 * that can go both directions but still be compatible with the
		 * stage 0 loader. */
		bytecnt = 0;
		while (bytecnt < (filesize)) {
			fbuf[bytecnt] = recvtribble(handle);
			fbuf[bytecnt] |= ((recvtribble(handle) & TRIBMASK) << 3);
			fbuf[bytecnt] |= ((recvtribble(handle) & DIBMASK) << 6);
			bytecnt++;
			fprintf(stderr, "\rReceived: %d bytes", bytecnt);
		}

		bytecnt = 0;
		while (bytecnt < (filesize)) {
			fputc(fbuf[bytecnt], fd);
			bytecnt++;
		}
		fclose(fd);
		fprintf(stderr, "\n");
	}


	return 0;

}

