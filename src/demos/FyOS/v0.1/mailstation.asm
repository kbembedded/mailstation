;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module mailstation
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ClearLCD
	.globl _strlen
	.globl _strtok
	.globl _putchar
	.globl _getchar
	.globl _vsprintf
	.globl _vprintf
	.globl _printf
	.globl _mem4000
	.globl _powerdownmode
	.globl _clrscr
	.globl _getscancode
	.globl _printfXY
	.globl _printfcenter
	.globl _hex_nibble
	.globl _hextoint
	.globl _hextobyte
	.globl _gets
	.globl _isupper
	.globl _tolower
	.globl _strtolower
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_port2	=	0x0002
_slot4000page	=	0x0005
_slot4000device	=	0x0006
_slot8000page	=	0x0007
_slot8000device	=	0x0008
_port_printerstatus	=	0x0021
_port_printerdata	=	0x002d
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_mem4000	=	0x4000
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;mailstation.c:10: void powerdownmode()
;	---------------------------------
; Function powerdownmode
; ---------------------------------
_powerdownmode::
;mailstation.c:14: __endasm;
	call	#0x0A6B ; Mailstation firmware powerdownmode function
;mailstation.c:15: }
	ret
;mailstation.c:43: void clrscr()
;	---------------------------------
; Function clrscr
; ---------------------------------
_clrscr::
;mailstation.c:49: cursorx = 0;
	ld	hl,#_cursorx + 0
	ld	(hl), #0x00
;mailstation.c:50: cursory = 0;
	ld	hl,#_cursory + 0
	ld	(hl), #0x00
;mailstation.c:51: memset(textmodebuffer, 0, 640);	
	ld	hl, #_textmodebuffer
	ld	(hl), #0x00
	ld	e, l
	ld	d, h
	inc	de
	ld	bc, #0x027f
	ldir
;mailstation.c:53: ClearLCD();
;mailstation.c:70: }
	jp  _ClearLCD
;mailstation.c:89: int getscancode(unsigned char *charbuffer)
;	---------------------------------
; Function getscancode
; ---------------------------------
_getscancode::
;mailstation.c:119: __endasm;
	push	af
	push	ix
	ld	ix, #2 + #6 + #2 ; C-pushed ix + pushed regs + ret address
	add	ix, sp
	ld	l, 0x0(ix)
	ld	h, 0x1(ix)
;ld	a, h
;ld	(#0xc010), a
;ld	a, l
;ld	(#0xc011), a
	push	hl
	call	ms_getkeycodefrombuffer ;#0x0A9A MS firmware getkeycodefrombuffer
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
;mailstation.c:122: return charbuffer[1];	
	pop	bc
	pop	hl
	push	hl
	push	bc
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
;mailstation.c:123: }
	ret
;mailstation.c:149: void printfXY(unsigned char x, unsigned char y, char *xystring, ...)
;	---------------------------------
; Function printfXY
; ---------------------------------
_printfXY::
	push	ix
	ld	ix,#0
	add	ix,sp
;mailstation.c:154: oldx = cursorx;
	ld	hl,#_cursorx + 0
	ld	b, (hl)
;mailstation.c:155: oldy = cursory;     
	ld	hl,#_cursory + 0
	ld	c, (hl)
;mailstation.c:156: cursorx = x;
	ld	a, 4 (ix)
	ld	(#_cursorx + 0),a
;mailstation.c:157: cursory = y;
	ld	a, 5 (ix)
	ld	(#_cursory + 0),a
;mailstation.c:159: va_start( args, xystring );	
	ld	hl,#0x0006+1+1
	add	hl,sp
	ld	e, l
;mailstation.c:160: vprintf( xystring, args );
	push	bc
	ld	l, e
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	call	_vprintf
	pop	af
	pop	af
	pop	bc
;mailstation.c:163: cursorx = oldx;
	ld	hl,#_cursorx + 0
	ld	(hl), b
;mailstation.c:164: cursory = oldy;	
	ld	hl,#_cursory + 0
	ld	(hl), c
;mailstation.c:165: }
	pop	ix
	ret
;mailstation.c:174: void printfcenter(char *centerstring, ...)
;	---------------------------------
; Function printfcenter
; ---------------------------------
_printfcenter::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-255
	add	hl, sp
	ld	sp, hl
;mailstation.c:180: va_start( args, centerstring );	
	ld	hl, #0x0103+1+1
	add	hl, sp
	ex	de, hl
;mailstation.c:181: vsprintf(tempstring, centerstring, args);
	ld	hl, #0x0000
	add	hl, sp
	push	hl
	push	de
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	push	de
	push	hl
	call	_vsprintf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;mailstation.c:184: result = strtok(tempstring, "\n");
	ld	de, #___str_0
	push	de
	push	bc
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
;mailstation.c:185: while (result != NULL) 
00101$:
	ld	a, d
	or	a, e
	jr	Z,00104$
;mailstation.c:187: cursorx = (40 - strlen(result)) / 2;
	push	de
	call	_strlen
	pop	af
	ld	c, l
	ld	b, h
	ld	a, #0x28
	sub	a, c
	ld	c, a
	ld	a, #0x00
	sbc	a, b
	ld	b, a
	srl	b
	rr	c
	ld	hl,#_cursorx + 0
	ld	(hl), c
;mailstation.c:188: printf("%s\n", result);				
	push	de
	ld	hl, #___str_1
	push	hl
	call	_printf
	pop	af
;mailstation.c:189: result = strtok( NULL, "\n" );
	ld	hl, #___str_0
	ex	(sp),hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	jr	00101$
00104$:
;mailstation.c:191: }
	ld	sp, ix
	pop	ix
	ret
___str_0:
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "%s"
	.db 0x0a
	.db 0x00
;mailstation.c:200: int hex_nibble (char x) 
;	---------------------------------
; Function hex_nibble
; ---------------------------------
_hex_nibble::
	push	ix
	ld	ix,#0
	add	ix,sp
;mailstation.c:202: if (x >= '0' && x <= '9') return x - '0'; 
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	a, 4 (ix)
	sub	a, #0x30
	jr	C,00102$
	ld	a, #0x39
	sub	a, 4 (ix)
	jr	C,00102$
	ld	a, c
	add	a, #0xd0
	ld	l, a
	ld	a, b
	adc	a, #0xff
	ld	h, a
	jr	00110$
00102$:
;mailstation.c:203: if (x >= 'a' && x <= 'f') return x - 'a' + 10; 
	ld	a, 4 (ix)
	sub	a, #0x61
	jr	C,00105$
	ld	a, #0x66
	sub	a, 4 (ix)
	jr	C,00105$
	ld	hl, #0xffa9
	add	hl, bc
	jr	00110$
00105$:
;mailstation.c:204: if (x >= 'A' && x <= 'F') return x - 'A' + 10; 
	ld	a, 4 (ix)
	sub	a, #0x41
	jr	C,00108$
	ld	a, #0x46
	sub	a, 4 (ix)
	jr	C,00108$
	ld	hl, #0xffc9
	add	hl, bc
	jr	00110$
00108$:
;mailstation.c:205: return -1;
	ld	hl, #0xffff
00110$:
;mailstation.c:206: }
	pop	ix
	ret
;mailstation.c:215: char hextoint(char *hexstring, unsigned int *hexint)
;	---------------------------------
; Function hextoint
; ---------------------------------
_hextoint::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;mailstation.c:217: unsigned int tempint = 0;
	ld	bc, #0x0000
;mailstation.c:221: for (n = 0; n < strlen(hexstring); n++)
	ld	de, #0x0000
00105$:
	push	bc
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strlen
	pop	af
	pop	bc
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC,00103$
;mailstation.c:223: tempnibble = hex_nibble(hexstring[n]);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, de
	ld	h, (hl)
	push	bc
	push	de
	push	hl
	inc	sp
	call	_hex_nibble
	inc	sp
	pop	de
	pop	bc
	ld	-1 (ix), l
;mailstation.c:225: tempint <<= 4;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
;mailstation.c:226: tempint |= tempnibble;
	ld	a, -1 (ix)
	ld	b, #0x00
	or	a, l
	ld	c, a
	ld	a, b
	or	a, h
	ld	b, a
;mailstation.c:221: for (n = 0; n < strlen(hexstring); n++)
	inc	de
	jr	00105$
00103$:
;mailstation.c:228: *hexint = tempint;
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;mailstation.c:229: return 1;
	ld	l, #0x01
;mailstation.c:230: }
	inc	sp
	pop	ix
	ret
;mailstation.c:239: char hextobyte(char *hexstring, unsigned char *hexbyte)
;	---------------------------------
; Function hextobyte
; ---------------------------------
_hextobyte::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;mailstation.c:241: unsigned int tempbyte = 0;
	ld	bc, #0x0000
;mailstation.c:245: for (n = 0; n < strlen(hexstring); n++)
	ld	de, #0x0000
00105$:
	push	bc
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strlen
	pop	af
	pop	bc
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC,00103$
;mailstation.c:247: tempnibble = hex_nibble(hexstring[n]);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, de
	ld	h, (hl)
	push	bc
	push	de
	push	hl
	inc	sp
	call	_hex_nibble
	inc	sp
	pop	de
	pop	bc
	ld	-1 (ix), l
;mailstation.c:249: tempbyte = tempbyte << 4;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
;mailstation.c:250: tempbyte |= tempnibble;
	ld	a, -1 (ix)
	ld	b, #0x00
	or	a, l
	ld	c, a
	ld	a, b
	or	a, h
	ld	b, a
;mailstation.c:245: for (n = 0; n < strlen(hexstring); n++)
	inc	de
	jr	00105$
00103$:
;mailstation.c:252: *hexbyte = tempbyte;
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	(hl), c
;mailstation.c:253: return 1;
	ld	l, #0x01
;mailstation.c:254: }
	inc	sp
	pop	ix
	ret
;mailstation.c:265: char *gets(char *s)
;	---------------------------------
; Function gets
; ---------------------------------
_gets::
	dec	sp
;mailstation.c:268: unsigned int count=0;
	ld	bc, #0x0000
;mailstation.c:270: while (1)
00112$:
;mailstation.c:272: c=getchar();
	push	bc
	call	_getchar
	pop	bc
	ld	iy, #0
	add	iy, sp
	ld	0 (iy), l
;mailstation.c:273: switch(c)
	ld	a, 0 (iy)
	or	a, a
	jr	Z,00101$
	ld	a, 0 (iy)
	sub	a, #0x08
	jr	Z,00102$
;mailstation.c:292: *s=0;
	ld	hl, #3
	add	hl, sp
	ld	d, (hl)
	inc	hl
	ld	e, (hl)
;mailstation.c:273: switch(c)
	ld	iy, #0
	add	iy, sp
	ld	a, 0 (iy)
	sub	a, #0x0a
	jr	Z,00106$
	ld	a, 0 (iy)
	sub	a, #0x0d
	jr	Z,00106$
	jr	00107$
;mailstation.c:275: case 0:	// Filter extended keys
00101$:
;mailstation.c:276: getchar(); break;
	push	bc
	call	_getchar
	pop	bc
	jr	00112$
;mailstation.c:278: case '\b': // backspace
00102$:
;mailstation.c:279: if (count)
	ld	a, b
	or	a, c
	jr	Z,00112$
;mailstation.c:281: putchar ('\b');
	push	bc
	ld	hl, #0x0008
	push	hl
	call	_putchar
	ld	hl, #0x0020
	ex	(sp),hl
	call	_putchar
	ld	hl, #0x0008
	ex	(sp),hl
	call	_putchar
	pop	af
	pop	bc
;mailstation.c:284: s--;
	ld	hl, #3
	add	hl, sp
	ld	a, (hl)
	add	a, #0xff
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
;mailstation.c:285: count--;
	dec	bc
;mailstation.c:287: break;
	jr	00112$
;mailstation.c:289: case '\r': // CR or LF
00106$:
;mailstation.c:290: putchar('\r');
	push	de
	ld	hl, #0x000d
	push	hl
	call	_putchar
	ld	hl, #0x000a
	ex	(sp),hl
	call	_putchar
	pop	af
	pop	de
;mailstation.c:292: *s=0;
	ld	l, d
	ld	h, e
	ld	(hl), #0x00
;mailstation.c:293: return s;
	ld	l, d
	ld	h, e
	jr	00114$
;mailstation.c:294: default:
00107$:
;mailstation.c:295: if (count < 255)	// limit string to 255 chars
	ld	a, c
	sub	a, #0xff
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00112$
;mailstation.c:297: *s++=c;
	ld	l, d
	ld	h, e
	ld	iy, #0
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
	ld	a, d
	ld	hl, #3
	add	hl, sp
	add	a, #0x01
	ld	(hl), a
	ld	a, e
	adc	a, #0x00
	inc	hl
	ld	(hl), a
;mailstation.c:298: count++;
	inc	bc
;mailstation.c:299: putchar(c);
	ld	e, 0 (iy)
	ld	d, #0x00
	push	bc
	push	de
	call	_putchar
	pop	af
	pop	bc
;mailstation.c:302: }
	jp	00112$
00114$:
;mailstation.c:304: }
	inc	sp
	ret
;mailstation.c:310: char isupper(char upperchar)
;	---------------------------------
; Function isupper
; ---------------------------------
_isupper::
;mailstation.c:312: if (upperchar >= 65 && upperchar <= 90) return 1;
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	sub	a, #0x41
	jr	C,00102$
	ld	a, #0x5a
	sub	a, 0 (iy)
	jr	C,00102$
	ld	l, #0x01
	ret
00102$:
;mailstation.c:313: return 0;
	ld	l, #0x00
;mailstation.c:314: }
	ret
;mailstation.c:321: char tolower(char upperchar)
;	---------------------------------
; Function tolower
; ---------------------------------
_tolower::
;mailstation.c:323: if (isupper(upperchar)) return upperchar + 32;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_isupper
	inc	sp
	ld	a, l
	or	a, a
	jr	Z,00102$
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	add	a, #0x20
	ld	l, a
	ret
00102$:
;mailstation.c:324: return upperchar;
	ld	iy, #2
	add	iy, sp
	ld	l, 0 (iy)
;mailstation.c:325: }
	ret
;mailstation.c:331: void strtolower(char *upperstring)
;	---------------------------------
; Function strtolower
; ---------------------------------
_strtolower::
;mailstation.c:333: char *stringpointer = upperstring;
	pop	de
	pop	bc
	push	bc
	push	de
;mailstation.c:335: while (*stringpointer != 0)
00101$:
	ld	a, (bc)
	or	a, a
	ret	Z
;mailstation.c:337: *stringpointer = tolower(*stringpointer);
	push	bc
	push	af
	inc	sp
	call	_tolower
	inc	sp
	ld	a, l
	pop	bc
	ld	(bc), a
;mailstation.c:338: stringpointer++;		
	inc	bc
;mailstation.c:340: }
	jr	00101$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
