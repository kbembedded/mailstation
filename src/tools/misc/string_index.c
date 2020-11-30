/* SPDX lkasdfkjasdf BSD whatever fix this */

/* Add overall commens here */

#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int fd;
	int i;
	uint16_t num_strings;
	off_t file_loc;
	size_t strlen;
	off_t strstart;
	ssize_t num_read;
	unsigned char *buf;
	size_t buflen;
	

	/* Check args here */

	fd = open(argv[1], O_NOCTTY,  O_RDONLY);
	if (!fd) /* Error */ ;

	/* Initially allocate 32 bytes, arbitrary */
	buf = (unsigned char *)(calloc(32, sizeof(char)));
	buflen = 32;

	/* TODO: Add rough breakdown of the string index struct */
	/* Read total number of strings */
	/* All numbers are going to be byteswapped */
	num_read = read(fd, buf, 2);
	file_loc = 2;
	num_strings = (buf[1] << 8) | (buf[0]);

	/* For each string, get the info and print it */
	for (i = 0; i <= num_strings; i++) {
		num_read = read(fd, buf, 2);
		strlen = ((buf[1] << 8) | (buf[0]));
		num_read = read(fd, buf, 2);
		strstart = ((buf[1] << 8) | (buf[0]));
		file_loc += 4;

		/* Make sure that the char buffer is going to be long enough! */
		if (buflen <= strlen) {
			buf = realloc(buf, strlen+1);
			buflen = strlen+1;
		}

		lseek(fd, strstart, SEEK_SET);
		memset(buf, '\0', buflen);
		num_read = read(fd, buf, strlen);

		/* For some reason, string 0 is just "+" ? */
		printf("#define STR_IDX_\t0x%04X\t// \'%s\'\n", i+1, buf);

		/* Return to the correct file location for the next string */
		lseek(fd, file_loc, SEEK_SET);
	}
}
