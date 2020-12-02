/* SPDX-License-Identifier: BSD-2-Clause */
/* Copyright (c) 2020 KBEmbedded */

#ifndef __KEYBOARD_H__
#define __KEYBOARD_H__

#define SC_MAIN		0x00
#define SC_BACK		0x01
#define SC_PRINT	0x02
#define SC_F1		0x03
#define SC_F2		0x04
#define SC_F3		0x05
#define SC_F4		0x06
#define SC_F5		0x07
#define SC_POWER	0x0F
#define SC_AT		0x13
#define SC_SIZE		0x14
#define SC_SPELL	0x15
#define SC_EMAIL	0x16
#define SC_PGUP		0x17
#define SC_BACKTICK	0x20
#define SC_1		0x21
#define SC_2		0x22
#define SC_3		0x23
#define SC_4		0x24
#define SC_5		0x25
#define SC_6		0x26
#define SC_7		0x27
#define SC_8		0x30
#define SC_9		0x31
#define SC_0		0x32
#define SC_DASH		0x33
#define SC_EQU		0x34
#define SC_BKSP		0x35
#define SC_BACKSLASH	0x36
#define SC_PGDN		0x37
#define SC_TAB		0x40
#define SC_q		0x41
#define SC_w		0x42
#define SC_e		0x43
#define SC_r		0x44
#define SC_t		0x45
#define SC_y		0x46
#define SC_u		0x47
#define SC_i		0x50
#define SC_o		0x51
#define SC_p		0x52
#define SC_OPENBRKT	0x53
#define SC_CLOSEBRKT	0x54
#define SC_SEMICOL	0x55
#define SC_SQUOTE	0x56
#define SC_ENTER	0x57
#define SC_CAPS		0x60
#define SC_a		0x61
#define SC_s		0x62
#define SC_d		0x63
#define SC_f		0x64
#define SC_g		0x65
#define SC_h		0x66
#define SC_j		0x67
#define SC_k		0x70
#define SC_l		0x71
#define SC_COMMA	0x72
#define SC_PERIOD	0x73
#define SC_FWDSLASH	0x74
#define SC_UARROW	0x75
#define SC_DARROW	0x76
#define SC_RARROW	0x77
#define SC_LSHIFT	0x80
#define SC_z		0x81
#define SC_x		0x82
#define SC_c		0x83
#define SC_v		0x84
#define SC_b		0x85
#define SC_n		0x86
#define SC_m		0x87
#define SC_FN		0x90
#define SC_SPACE	0x93
#define SC_RSHIFT	0x96
#define SC_LARROW	0x97

/* Returns 1 if a valid scancode is available. Sets the scancode data
 * in two bytes passed in argument.
 */
#define msfw_get_scancode(x) ((uint8_t (*)(uint8_t *)) 0x0A9A)(x)

/* XXX: Move this somewhere else later or figure out how to make it not end up
 * inside of native applications since its really not needed!
 */

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

#endif // __KEYBOARD_H__
