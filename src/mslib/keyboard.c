/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2021 KBEmbedded */

#include <stdint.h>
#include <keyboard.h>

/* This lookup table is whatever right now */
const char scode_lower[160] = {
/*	Main	Back	Print	F1	F2	F3	F4	F5	*/
	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,
/*	NULL	NULL	NULL	@	Size	Chk Spl	Get Eml	PgUp	*/
	0x00,	0x00,	0x00,	'@',	0x00,	0x00,	0x00,	0x00,
/*	`	1	2	3	4	5	6	7	*/
	'`',	'1',	'2',	'3',	'4',	'5',	'6',	'7',
/*	8	9	0	-	=	Del	\	PgDn	*/
	'8',	'9',	'0',	'-',	'=',	0x08,	'\\',	0x00,
/*	Tab	q	w	e	r	t	y	u	*/
	0x09,	'q',	'w',	'e',	'r',	't',	'y',	'u',
/*	i	o	p	[	]	;	'	Enter	*/
	'i',	'o',	'p',	'[',	']',	';',	'\'',	0x0A,
/*	Caps	a	s	d	f	g	h	j	*/
	0x00,	'a',	's',	'd',	'f',	'g',	'h',	'j',
/*	k	l	,	.	/	UpAr	DnAr	RiAr	*/
	'k',	'l',	',',	'.',	'/',	0x00,	0x00,	0x00,
/*	LShift	z	x	c	v	b	n	m	*/
	0x00,	'z',	'x',	'c',	'v',	'b',	'n',	'm',
/*	Fn	NULL	NULL	Space	NULL	NULL	RShift	LeAr	*/
	0x00,	0x00,	0x00,	' ',	0x00,	0x00,	0x00,	0x00,

/*	Main	Back	Print	F1	F2	F3	F4	F5	*/
	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,
/*	NULL	NULL	NULL	@	Size	Chk Spl	Get Eml	PgUp	*/
	0x00,	0x00,	0x00,	'@',	0x00,	0x00,	0x00,	0x00,
/*	`	1	2	3	4	5	6	7	*/
	'~',	'!',	'@',	'#',	'$',	'%',	'^',	'&',
/*	8	9	0	-	=	Del	\	PgDn	*/
	'*',	'(',	')',	'_',	'+',	0x08,	'|',	0x00,
/*	Tab	q	w	e	r	t	y	u	*/
	0x09,	'Q',	'W',	'E',	'R',	'T',	'Y',	'U',
/*	i	o	p	[	]	;	'	Enter	*/
	'I',	'O',	'P',	'{',	'}',	':',	'\"',	0x0A,
/*	Caps	a	s	d	f	g	h	j	*/
	0x00,	'A',	'S',	'D',	'F',	'G',	'H',	'J',
/*	k	l	,	.	/	UpAr	DnAr	RiAr	*/
	'K',	'L',	'<',	'>',	'?',	0x00,	0x00,	0x00,
/*	LShift	z	x	c	v	b	n	m	*/
	0x00,	'Z',	'X',	'C',	'V',	'B',	'N',	'M',
/*	Fn	NULL	NULL	Space	NULL	NULL	RShift	LeAr	*/
	0x00,	0x00,	0x00,	' ',	0x00,	0x00,	0x00,	0x00,
};

void kbd_flush(void)
{
	uint8_t buf[2];

	while(msfw_get_scancode(buf));
}

void kbd_anykey(void)
{
	uint8_t buf[2] = {0};

	/* Loop getting keyboard scancodes until there is a valid button down event */
	while (!msfw_get_scancode(buf) || !(buf[1] & 0x1));
}

