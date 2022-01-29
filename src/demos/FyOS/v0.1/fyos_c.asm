;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module fyos_c
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _printSP
	.globl _cmd_help
	.globl _cmd_scancodes
	.globl _cmd_hextoint
	.globl _cmd_port_out
	.globl _cmd_port_in
	.globl _cmd_poke
	.globl _cmd_peek
	.globl _enable_charbuffer
	.globl _disable_charbuffer
	.globl _kbhit
	.globl _strtolower
	.globl _gets
	.globl _hextobyte
	.globl _hextoint
	.globl _printfcenter
	.globl _getscancode
	.globl _clrscr
	.globl _powerdownmode
	.globl _strtok
	.globl _strcmp
	.globl _putchar
	.globl _getchar
	.globl _puts
	.globl _printf
	.globl _versionpointer
	.globl _myglobal
	.globl _inputstring
	.globl _mem4000
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
_inputstring::
	.ds 256
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_myglobal::
	.ds 1
_versionpointer::
	.ds 2
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
;fyos_c.c:16: void cmd_peek(char *inputstring)
;	---------------------------------
; Function cmd_peek
; ---------------------------------
_cmd_peek::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;fyos_c.c:23: result = strtok(inputstring, " ");
	ld	hl, #___str_0
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strtok
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;fyos_c.c:24: while (result != NULL) 
	ld	de, #0x0000
00104$:
	ld	a, b
	or	a, c
	jr	Z,00106$
;fyos_c.c:26: parmnum++;
	inc	de
;fyos_c.c:27: hexint = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;fyos_c.c:28: if (hextoint(result, &hexint) == 1) printf("%04x -> %02x\n", hexint, mempointer[hexint]);
	ld	hl, #0x0000
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	bc
	call	_hextoint
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00102$
	pop	hl
	push	hl
	ld	c, (hl)
	ld	b, #0x00
	push	de
	push	bc
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	hl
	ld	hl, #___str_1
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	de
	jr	00103$
00102$:
;fyos_c.c:29: else printf("Invalid hex: %s\n", result);
	push	de
	push	bc
	ld	hl, #___str_2
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	de
00103$:
;fyos_c.c:30: result = strtok( NULL, " " );
	push	de
	ld	hl, #___str_0
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	pop	de
	jr	00104$
00106$:
;fyos_c.c:33: if (parmnum == 0) { printf("Usage: peek FFFF D42 F03B...\n"); }
	ld	a, d
	or	a, e
	jr	NZ,00108$
	ld	hl, #___str_4
	push	hl
	call	_puts
	pop	af
00108$:
;fyos_c.c:34: printf("\n");
	ld	hl, #___str_6
	push	hl
	call	_puts
;fyos_c.c:35: }
	ld	sp,ix
	pop	ix
	ret
___str_0:
	.ascii " "
	.db 0x00
___str_1:
	.ascii "%04x -> %02x"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "Invalid hex: %s"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Usage: peek FFFF D42 F03B..."
	.db 0x00
___str_6:
	.db 0x00
;fyos_c.c:37: void cmd_poke(char *inputstring)
;	---------------------------------
; Function cmd_poke
; ---------------------------------
_cmd_poke::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-7
	add	hl, sp
	ld	sp, hl
;fyos_c.c:40: unsigned char *mempointer = 0;
	ld	-4 (ix), #0x00
	ld	-3 (ix), #0x00
;fyos_c.c:41: unsigned int hexint = 0;
	ld	-6 (ix), #0x00
	ld	-5 (ix), #0x00
;fyos_c.c:42: unsigned char hexbyte = 0;
	ld	-7 (ix), #0x00
;fyos_c.c:43: int parmnum = 0;
	ld	bc, #0x0000
;fyos_c.c:45: result = strtok(inputstring, " ");
	push	bc
	ld	hl, #___str_7
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
;fyos_c.c:46: while (result != NULL) 
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
00111$:
	ld	a, d
	or	a, e
	jp	Z, 00113$
;fyos_c.c:48: parmnum++;
	inc	-2 (ix)
	jr	NZ,00154$
	inc	-1 (ix)
00154$:
	ld	c, -2 (ix)
	ld	b, -1 (ix)
;fyos_c.c:49: if (parmnum == 1)
	ld	a, -2 (ix)
	dec	a
	or	a, -1 (ix)
	jr	NZ,00105$
;fyos_c.c:51: hexint = 0;
	ld	-6 (ix), #0x00
	ld	-5 (ix), #0x00
;fyos_c.c:52: if (hextoint(result, &hexint) == 1) mempointer = (unsigned char *)hexint;
	ld	hl, #0x0001
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	de
	call	_hextoint
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00102$
	ld	a, -6 (ix)
	ld	-4 (ix), a
	ld	a, -5 (ix)
	ld	-3 (ix), a
	jr	00105$
00102$:
;fyos_c.c:53: else { printf("Invalid address: %s\n\n", result); return; }
	push	de
	ld	hl, #___str_8
	push	hl
	call	_printf
	pop	af
	pop	af
	jp	00117$
00105$:
;fyos_c.c:55: if (parmnum == 2)
	ld	a, -2 (ix)
	sub	a, #0x02
	or	a, -1 (ix)
	jr	NZ,00110$
;fyos_c.c:57: hexbyte = 0;
	ld	-7 (ix), #0x00
;fyos_c.c:58: if (hextobyte(result, &hexbyte) == 1) *mempointer = hexbyte;
	ld	hl, #0x0000
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	de
	call	_hextobyte
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00107$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, -7 (ix)
	ld	(hl), a
	jr	00110$
00107$:
;fyos_c.c:59: else { printf("Invalid data byte: %s\n\n", result); return; }
	push	de
	ld	hl, #___str_9
	push	hl
	call	_printf
	pop	af
	pop	af
	jr	00117$
00110$:
;fyos_c.c:61: result = strtok( NULL, " " );
	push	bc
	ld	hl, #___str_7
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	jp	00111$
00113$:
;fyos_c.c:64: if (parmnum == 0) { printf("Usage: poke ABCD E1\n"); }
	ld	a, b
	or	a, c
	jr	NZ,00115$
	ld	hl, #___str_11
	push	hl
	call	_puts
	pop	af
	jr	00116$
00115$:
;fyos_c.c:65: else printf("%04x -> %02x\n", hexint, hexbyte);
	ld	c, -7 (ix)
	ld	b, #0x00
	push	bc
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	push	hl
	ld	hl, #___str_12
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
00116$:
;fyos_c.c:66: printf("\n");
	ld	hl, #___str_14
	push	hl
	call	_puts
	pop	af
00117$:
;fyos_c.c:67: }
	ld	sp, ix
	pop	ix
	ret
___str_7:
	.ascii " "
	.db 0x00
___str_8:
	.ascii "Invalid address: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "Invalid data byte: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_11:
	.ascii "Usage: poke ABCD E1"
	.db 0x00
___str_12:
	.ascii "%04x -> %02x"
	.db 0x0a
	.db 0x00
___str_14:
	.db 0x00
;fyos_c.c:71: void cmd_port_in(char *inputstring)
;	---------------------------------
; Function cmd_port_in
; ---------------------------------
_cmd_port_in::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;fyos_c.c:75: unsigned int hexint = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;fyos_c.c:76: volatile unsigned char hexbyte = 0;
	ld	-3 (ix), #0x00
;fyos_c.c:77: int parmnum = 0;
	ld	bc, #0x0000
;fyos_c.c:79: result = strtok(inputstring, " ");
	push	bc
	ld	hl, #___str_15
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
;fyos_c.c:80: while (result != NULL) 
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
00104$:
	ld	a, d
	or	a, e
	jr	Z,00106$
;fyos_c.c:82: parmnum++;
	inc	-2 (ix)
	jr	NZ,00131$
	inc	-1 (ix)
00131$:
	ld	c, -2 (ix)
	ld	b, -1 (ix)
;fyos_c.c:83: hexint = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;fyos_c.c:84: hexbyte = 0;
	ld	-3 (ix), #0x00
;fyos_c.c:85: if (hextoint(result, &hexint) == 1)
	ld	hl, #0x0000
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	de
	call	_hextoint
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00102$
;fyos_c.c:96: __endasm;
	push	af
	push	bc
	ld	c, -4(ix) ; low byte hexint
	ld	b, -3(ix) ; high byte hexint
	in	a, (C)
	ld	-5(ix), a ; hexbyte
	pop	bc
	pop	af
;fyos_c.c:97: printf("%04x -> %02x\n", hexint, hexbyte);
	ld	e, -3 (ix)
	ld	d, #0x00
	push	bc
	push	de
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	hl, #___str_16
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
	jr	00103$
00102$:
;fyos_c.c:99: else { printf("Invalid address: %s\n\n", result); return; }       		
	push	de
	ld	hl, #___str_17
	push	hl
	call	_printf
	pop	af
	pop	af
	jr	00109$
00103$:
;fyos_c.c:100: result = strtok( NULL, " " );
	push	bc
	ld	hl, #___str_15
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	jr	00104$
00106$:
;fyos_c.c:103: if (parmnum == 0) { printf("Usage: PORT_IN AB E1...\n"); }   	
	ld	a, b
	or	a, c
	jr	NZ,00108$
	ld	hl, #___str_19
	push	hl
	call	_puts
	pop	af
00108$:
;fyos_c.c:104: printf("\n");
	ld	hl, #___str_21
	push	hl
	call	_puts
	pop	af
00109$:
;fyos_c.c:105: }
	ld	sp, ix
	pop	ix
	ret
___str_15:
	.ascii " "
	.db 0x00
___str_16:
	.ascii "%04x -> %02x"
	.db 0x0a
	.db 0x00
___str_17:
	.ascii "Invalid address: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_19:
	.ascii "Usage: PORT_IN AB E1..."
	.db 0x00
___str_21:
	.db 0x00
;fyos_c.c:109: void cmd_port_out(char *inputstring)
;	---------------------------------
; Function cmd_port_out
; ---------------------------------
_cmd_port_out::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;fyos_c.c:113: unsigned int hexint = 0;
	ld	-4 (ix), #0x00
	ld	-3 (ix), #0x00
;fyos_c.c:114: unsigned char hexbyte = 0;
	ld	-5 (ix), #0x00
;fyos_c.c:115: int parmnum = 0;
	ld	bc, #0x0000
;fyos_c.c:117: result = strtok(inputstring, " ");
	push	bc
	ld	hl, #___str_22
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
;fyos_c.c:118: while (result != NULL) 
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
00110$:
	ld	a, d
	or	a, e
	jp	Z, 00112$
;fyos_c.c:120: parmnum++;
	inc	-2 (ix)
	jr	NZ,00153$
	inc	-1 (ix)
00153$:
	ld	c, -2 (ix)
	ld	b, -1 (ix)
;fyos_c.c:121: if (parmnum == 1)
	ld	a, -2 (ix)
	dec	a
	or	a, -1 (ix)
	jr	NZ,00104$
;fyos_c.c:123: hexint = 0;
	ld	-4 (ix), #0x00
	ld	-3 (ix), #0x00
;fyos_c.c:124: if (hextoint(result, &hexint) != 1) { printf("Invalid address: %s\n\n", result); return; }
	ld	hl, #0x0001
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	de
	call	_hextoint
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	Z,00104$
	push	de
	ld	hl, #___str_23
	push	hl
	call	_printf
	pop	af
	pop	af
	jp	00116$
00104$:
;fyos_c.c:126: if (parmnum == 2)
	ld	a, -2 (ix)
	sub	a, #0x02
	or	a, -1 (ix)
	jr	NZ,00109$
;fyos_c.c:128: hexbyte = 0;
	ld	-5 (ix), #0x00
;fyos_c.c:129: if (hextobyte(result, &hexbyte) == 1)
	ld	hl, #0x0000
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	de
	call	_hextobyte
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00106$
;fyos_c.c:140: __endasm;
	push	af
	push	bc
	ld	c, -4(ix) ; low byte hexint
	ld	b, -3(ix) ; high byte hexint
	ld	a, -5(ix) ; hexbyte
	out	(C), a
	pop	bc
	pop	af
	jr	00109$
00106$:
;fyos_c.c:142: else { printf("Invalid data byte: %s\n\n", result); return; }
	push	de
	ld	hl, #___str_24
	push	hl
	call	_printf
	pop	af
	pop	af
	jr	00116$
00109$:
;fyos_c.c:144: result = strtok( NULL, " " );
	push	bc
	ld	hl, #___str_22
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	jp	00110$
00112$:
;fyos_c.c:147: if (parmnum == 0) { printf("Usage: PORT_OUT AB E1\n"); }
	ld	a, b
	or	a, c
	jr	NZ,00114$
	ld	hl, #___str_26
	push	hl
	call	_puts
	pop	af
	jr	00115$
00114$:
;fyos_c.c:148: else printf("%04x -> %02x\n", hexint, hexbyte);
	ld	c, -5 (ix)
	ld	b, #0x00
	push	bc
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	push	hl
	ld	hl, #___str_27
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
00115$:
;fyos_c.c:149: printf("\n");
	ld	hl, #___str_29
	push	hl
	call	_puts
	pop	af
00116$:
;fyos_c.c:150: }
	ld	sp, ix
	pop	ix
	ret
___str_22:
	.ascii " "
	.db 0x00
___str_23:
	.ascii "Invalid address: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_24:
	.ascii "Invalid data byte: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_26:
	.ascii "Usage: PORT_OUT AB E1"
	.db 0x00
___str_27:
	.ascii "%04x -> %02x"
	.db 0x0a
	.db 0x00
___str_29:
	.db 0x00
;fyos_c.c:154: void cmd_hextoint(char *inputstring)
;	---------------------------------
; Function cmd_hextoint
; ---------------------------------
_cmd_hextoint::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;fyos_c.c:160: result = strtok(inputstring, " ");
	ld	hl, #___str_30
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strtok
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;fyos_c.c:161: while (result != NULL) 
	ld	de, #0x0000
00104$:
	ld	a, b
	or	a, c
	jr	Z,00106$
;fyos_c.c:163: parmnum++;
	inc	de
;fyos_c.c:164: hexint = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;fyos_c.c:165: if (hextoint(result, &hexint) == 1) printf("%4s -> %u\n", result, hexint);
	ld	hl, #0x0000
	add	hl, sp
	push	bc
	push	de
	push	hl
	push	bc
	call	_hextoint
	pop	af
	pop	af
	pop	de
	pop	bc
	dec	l
	jr	NZ,00102$
	push	de
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	hl
	push	bc
	ld	hl, #___str_31
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	de
	jr	00103$
00102$:
;fyos_c.c:166: else printf("Invalid hex: %s\n", result);
	push	de
	push	bc
	ld	hl, #___str_32
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	de
00103$:
;fyos_c.c:167: result = strtok( NULL, " " );
	push	de
	ld	hl, #___str_30
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	pop	de
	jr	00104$
00106$:
;fyos_c.c:170: if (parmnum == 0) { printf("Usage: hextoint FFC 422A 3B...\n"); }
	ld	a, d
	or	a, e
	jr	NZ,00108$
	ld	hl, #___str_34
	push	hl
	call	_puts
	pop	af
00108$:
;fyos_c.c:171: printf("\n");
	ld	hl, #___str_36
	push	hl
	call	_puts
;fyos_c.c:172: }
	ld	sp,ix
	pop	ix
	ret
___str_30:
	.ascii " "
	.db 0x00
___str_31:
	.ascii "%4s -> %u"
	.db 0x0a
	.db 0x00
___str_32:
	.ascii "Invalid hex: %s"
	.db 0x0a
	.db 0x00
___str_34:
	.ascii "Usage: hextoint FFC 422A 3B..."
	.db 0x00
___str_36:
	.db 0x00
;fyos_c.c:176: void cmd_scancodes()
;	---------------------------------
; Function cmd_scancodes
; ---------------------------------
_cmd_scancodes::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;fyos_c.c:178: unsigned char lastkey = 0;
	ld	c, #0x00
;fyos_c.c:181: disable_charbuffer();
	push	bc
	call	_disable_charbuffer
	pop	bc
;fyos_c.c:187: while (getscancode(mycharbuffer) == 255) {} // get last scancodes just to clear it out
	ld	hl, #0x0000
	add	hl, sp
	ex	de, hl
00101$:
	ld	l, e
	ld	h, d
	push	bc
	push	de
	push	hl
	call	_getscancode
	pop	af
	pop	de
	pop	bc
	ld	a, l
	inc	a
	or	a, h
	jr	Z,00101$
;fyos_c.c:189: printf("Press any key to show scancode, or Back to return to command prompt.\n\n");
	push	bc
	push	de
	ld	hl, #___str_38
	push	hl
	call	_puts
	pop	af
	pop	de
	pop	bc
;fyos_c.c:191: while (lastkey != 1)
	ld	-2 (ix), e
	ld	-1 (ix), d
	ld	-4 (ix), e
	ld	-3 (ix), d
00106$:
	ld	a, c
	dec	a
	jr	Z,00108$
;fyos_c.c:193: if (getscancode(mycharbuffer) != 255)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	bc
	push	de
	push	hl
	call	_getscancode
	pop	af
	pop	de
	pop	bc
	ld	a, l
	inc	a
	or	a, h
	jr	Z,00106$
;fyos_c.c:195: printfcenter("Scancode: %03d   Key state: %03d\n", mycharbuffer[0], mycharbuffer[1]);
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	push	de
	push	bc
	push	hl
	ld	hl, #___str_39
	push	hl
	call	_printfcenter
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	de
;fyos_c.c:196: lastkey = mycharbuffer[0];
	ld	a, (de)
	ld	c, a
	jr	00106$
00108$:
;fyos_c.c:199: printf("\n");
	ld	hl, #___str_41
	push	hl
	call	_puts
	pop	af
;fyos_c.c:201: enable_charbuffer();
	call	_enable_charbuffer
;fyos_c.c:203: while (kbhit()) getchar();
00109$:
	call	_kbhit
	ld	a, h
	or	a, l
	jr	Z,00112$
	call	_getchar
	jr	00109$
00112$:
;fyos_c.c:205: }
	ld	sp, ix
	pop	ix
	ret
___str_38:
	.ascii "Press any key to show scancode, or Back to return to command"
	.ascii " prompt."
	.db 0x0a
	.db 0x00
___str_39:
	.ascii "Scancode: %03d   Key state: %03d"
	.db 0x0a
	.db 0x00
___str_41:
	.db 0x00
;fyos_c.c:208: void cmd_help(char *helpcommand)
;	---------------------------------
; Function cmd_help
; ---------------------------------
_cmd_help::
	push	ix
	ld	ix,#0
	add	ix,sp
;fyos_c.c:212: if (helpcommand[0] == 0)
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	a, (bc)
	or	a, a
	jr	NZ,00102$
;fyos_c.c:217: puts("Use HELP <COMMAND> for more info.\n\n");
	ld	hl, #___str_74
	push	hl
	call	_puts
	pop	af
;fyos_c.c:218: return;
	jp	00130$
00102$:
;fyos_c.c:220: strtolower(helpcommand);
	push	bc
	push	bc
	call	_strtolower
	ld	hl, #___str_45
	ex	(sp),hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00128$
	ld	hl, #___str_47
	push	hl
	call	_puts
	pop	af
	jp	00130$
00128$:
;fyos_c.c:226: else if (strcmp(helpcommand, "peek") == 0) printf("PEEK displays memory locations in hex.\n\n");
	push	bc
	ld	hl, #___str_48
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00125$
	ld	hl, #___str_50
	push	hl
	call	_puts
	pop	af
	jp	00130$
00125$:
;fyos_c.c:227: else if (strcmp(helpcommand, "poke") == 0) printf("POKE writes a byte to a memory location.\n\n");
	push	bc
	ld	hl, #___str_51
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00122$
	ld	hl, #___str_53
	push	hl
	call	_puts
	pop	af
	jp	00130$
00122$:
;fyos_c.c:228: else if (strcmp(helpcommand, "port_out") == 0) printf("PORT_OUT writes a byte to a port.\n\n");
	push	bc
	ld	hl, #___str_54
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00119$
	ld	hl, #___str_56
	push	hl
	call	_puts
	pop	af
	jp	00130$
00119$:
;fyos_c.c:229: else if (strcmp(helpcommand, "port_in") == 0) printf("PORT_IN reads a byte from port(s).\n\n");
	push	bc
	ld	hl, #___str_57
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00116$
	ld	hl, #___str_59
	push	hl
	call	_puts
	pop	af
	jr	00130$
00116$:
;fyos_c.c:230: else if (strcmp(helpcommand, "reset") == 0) printf("RESET resets FyOS to initial screen.\n\n");
	push	bc
	ld	hl, #___str_60
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00113$
	ld	hl, #___str_62
	push	hl
	call	_puts
	pop	af
	jr	00130$
00113$:
;fyos_c.c:232: else if (strcmp(helpcommand, "reboot") == 0) printf("REBOOT resets the Mailstation to 0x0000.\n\n");
	push	bc
	ld	hl, #___str_63
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00110$
	ld	hl, #___str_65
	push	hl
	call	_puts
	pop	af
	jr	00130$
00110$:
;fyos_c.c:233: else if (strcmp(helpcommand, "scancodes") == 0) printf("SCANCODES is an interactive key viewer.\n\n");
	push	bc
	ld	hl, #___str_66
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00107$
	ld	hl, #___str_68
	push	hl
	call	_puts
	pop	af
	jr	00130$
00107$:
;fyos_c.c:234: else if (strcmp(helpcommand, "powerdown") == 0) printf("POWERDOWN turns off the Mailstation\n  via firmware function 0x0A6B.\n\n");
	push	bc
	ld	hl, #___str_69
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00104$
	ld	hl, #___str_71
	push	hl
	call	_puts
	pop	af
	jr	00130$
00104$:
;fyos_c.c:235: else printf("Unknown command: %s\n\n", helpcommand);	
	push	bc
	ld	hl, #___str_72
	push	hl
	call	_printf
	pop	af
	pop	af
00130$:
;fyos_c.c:236: }
	pop	ix
	ret
___str_45:
	.ascii "hextoint"
	.db 0x00
___str_47:
	.ascii "HEXTOINT displays hex strings as"
	.db 0x0a
	.ascii "  integers."
	.db 0x0a
	.db 0x00
___str_48:
	.ascii "peek"
	.db 0x00
___str_50:
	.ascii "PEEK displays memory locations in hex."
	.db 0x0a
	.db 0x00
___str_51:
	.ascii "poke"
	.db 0x00
___str_53:
	.ascii "POKE writes a byte to a memory location."
	.db 0x0a
	.db 0x00
___str_54:
	.ascii "port_out"
	.db 0x00
___str_56:
	.ascii "PORT_OUT writes a byte to a port."
	.db 0x0a
	.db 0x00
___str_57:
	.ascii "port_in"
	.db 0x00
___str_59:
	.ascii "PORT_IN reads a byte from port(s)."
	.db 0x0a
	.db 0x00
___str_60:
	.ascii "reset"
	.db 0x00
___str_62:
	.ascii "RESET resets FyOS to initial screen."
	.db 0x0a
	.db 0x00
___str_63:
	.ascii "reboot"
	.db 0x00
___str_65:
	.ascii "REBOOT resets the Mailstation to 0x0000."
	.db 0x0a
	.db 0x00
___str_66:
	.ascii "scancodes"
	.db 0x00
___str_68:
	.ascii "SCANCODES is an interactive key viewer."
	.db 0x0a
	.db 0x00
___str_69:
	.ascii "powerdown"
	.db 0x00
___str_71:
	.ascii "POWERDOWN turns off the Mailstation"
	.db 0x0a
	.ascii "  via firmware function 0x0A6B."
	.db 0x0a
	.db 0x00
___str_72:
	.ascii "Unknown command: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_74:
	.ascii "Available commands:"
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii " CLS, HELP, HEXTOINT, PEEK, POKE,"
	.db 0x0a
	.ascii " PORT_IN, PORT_OUT, POWERDOWN, REBOOT,"
	.db 0x0a
	.ascii " RESET, SCANCODES"
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "Use HELP <COMMAND> for more info."
	.db 0x0a
	.db 0x0a
	.db 0x00
;fyos_c.c:239: void printSP()
;	---------------------------------
; Function printSP
; ---------------------------------
_printSP::
	push	af
;fyos_c.c:241: volatile unsigned int SPval = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;fyos_c.c:248: __endasm;
	ld	hl, #0
	add	hl, sp
	ld	-1(ix), h
	ld	-2(ix), l
;fyos_c.c:250: printf("SP: %x\n", SPval);
	pop	hl
	push	hl
	push	hl
	ld	hl, #___str_75
	push	hl
	call	_printf
	pop	af
	pop	af
;fyos_c.c:251: }
	pop	af
	ret
___str_75:
	.ascii "SP: %x"
	.db 0x0a
	.db 0x00
;fyos_c.c:254: int main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;fyos_c.c:261: cursorx = 0;
	ld	hl,#_cursorx + 0
	ld	(hl), #0x00
;fyos_c.c:262: cursory = 0;	
	ld	hl,#_cursory + 0
	ld	(hl), #0x00
;fyos_c.c:271: resetprogram:
00101$:
;fyos_c.c:272: clrscr();	
	call	_clrscr
;fyos_c.c:273: printfcenter("FyOS v0.1\nby FyberOptic\n \n");
	ld	hl, #___str_76
	push	hl
	call	_printfcenter
	pop	af
;fyos_c.c:274: printf("Mailstation firmware: v%d.%d\n", versionpointer[1], versionpointer[0]);		
	ld	hl, (_versionpointer)
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, (_versionpointer)
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	push	de
	push	bc
	ld	hl, #___str_77
	push	hl
	call	_printf
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;fyos_c.c:285: printf("\nGlobal var init test: ");
	ld	hl, #___str_78
	push	hl
	call	_printf
	pop	af
;fyos_c.c:286: if (myglobal == 100) puts("Pass"); else puts("Fail");
	ld	a,(#_myglobal + 0)
	sub	a, #0x64
	jr	NZ,00103$
	ld	hl, #___str_79
	push	hl
	call	_puts
	pop	af
	jr	00104$
00103$:
	ld	hl, #___str_80
	push	hl
	call	_puts
	pop	af
00104$:
;fyos_c.c:288: printf("\nP2shadow: %x\nP3shadow: %x\ncgafont_addr: %x\n", p2shadow, p3shadow, cgafont_addr);	
	ld	hl, (_cgafont_addr)
	push	hl
	ld	hl, (_p3shadow)
	push	hl
	ld	hl, (_p2shadow)
	push	hl
	ld	hl, #___str_81
	push	hl
	call	_printf
	ld	hl, #8
	add	hl, sp
	ld	sp, hl
;fyos_c.c:290: printSP();
	call	_printSP
;fyos_c.c:291: putchar('\n');
	ld	hl, #0x000a
	push	hl
	call	_putchar
	pop	af
;fyos_c.c:297: commandloop:
00105$:
;fyos_c.c:298: putchar('>'); gets(inputstring);
	ld	hl, #0x003e
	push	hl
	call	_putchar
	pop	af
	ld	bc, #_inputstring
	push	bc
	call	_gets
	pop	af
;fyos_c.c:302: if (inputstring[0] == 0) goto commandloop;
	ld	a, (#_inputstring + 0)
	or	a, a
	jr	Z,00105$
;fyos_c.c:305: stringpointer = strtok(inputstring, " ");		// separate command
	ld	hl, #___str_82
	push	hl
	ld	hl, #_inputstring
	push	hl
	call	_strtok
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;fyos_c.c:306: if (stringpointer == NULL) stringpointer = inputstring;
	ld	a, b
	or	a, c
	jr	NZ,00109$
	ld	bc, #_inputstring
00109$:
;fyos_c.c:308: stringparms = strtok(NULL, "\0");
	push	bc
	ld	hl, #___str_83
	push	hl
	ld	hl, #0x0000
	push	hl
	call	_strtok
	pop	af
	pop	af
	pop	bc
;fyos_c.c:310: if (strcmp(stringpointer, "reset") == 0) goto resetprogram;
	push	hl
	push	bc
	ld	de, #___str_84
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jp	Z, 00101$
;fyos_c.c:312: else if (strcmp(stringpointer, "hextoint") == 0) cmd_hextoint(stringparms);
	push	hl
	push	bc
	ld	de, #___str_85
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00138$
	push	hl
	call	_cmd_hextoint
	pop	af
	jr	00105$
00138$:
;fyos_c.c:314: else if (strcmp(stringpointer, "cls") == 0) clrscr();
	push	hl
	push	bc
	ld	de, #___str_86
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00135$
	call	_clrscr
	jp	00105$
00135$:
;fyos_c.c:315: else if (strcmp(stringpointer, "peek") == 0) cmd_peek(stringparms);
	push	hl
	push	bc
	ld	de, #___str_87
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00132$
	push	hl
	call	_cmd_peek
	pop	af
	jp	00105$
00132$:
;fyos_c.c:316: else if (strcmp(stringpointer, "poke") == 0) cmd_poke(stringparms);
	push	hl
	push	bc
	ld	de, #___str_88
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00129$
	push	hl
	call	_cmd_poke
	pop	af
	jp	00105$
00129$:
;fyos_c.c:317: else if (strcmp(stringpointer, "port_in") == 0) cmd_port_in(stringparms);
	push	hl
	push	bc
	ld	de, #___str_89
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00126$
	push	hl
	call	_cmd_port_in
	pop	af
	jp	00105$
00126$:
;fyos_c.c:318: else if (strcmp(stringpointer, "port_out") == 0) cmd_port_out(stringparms);
	push	hl
	push	bc
	ld	de, #___str_90
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00123$
	push	hl
	call	_cmd_port_out
	pop	af
	jp	00105$
00123$:
;fyos_c.c:319: else if (strcmp(stringpointer, "help") == 0) cmd_help(stringparms);
	push	hl
	push	bc
	ld	de, #___str_91
	push	de
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	pop	hl
	ld	a, d
	or	a, e
	jr	NZ,00120$
	push	hl
	call	_cmd_help
	pop	af
	jp	00105$
00120$:
;fyos_c.c:320: else if (strcmp(stringpointer, "scancodes") == 0) cmd_scancodes();
	push	bc
	ld	hl, #___str_92
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00117$
	call	_cmd_scancodes
	jp	00105$
00117$:
;fyos_c.c:321: else if (strcmp(stringpointer, "powerdown") == 0) powerdownmode();
	push	bc
	ld	hl, #___str_93
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00114$
	call	_powerdownmode
	jp	00105$
00114$:
;fyos_c.c:328: else if (strcmp(stringpointer, "reboot") == 0)
	ld	hl, #___str_94
	push	hl
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ld	a, h
	or	a, l
	jr	NZ,00111$
;fyos_c.c:332: __endasm;
	jp	0x0000
	jp	00105$
00111$:
;fyos_c.c:336: printf("Unknown command: %s\n\n", inputstring);
	ld	hl, #_inputstring
	push	hl
	ld	hl, #___str_95
	push	hl
	call	_printf
	pop	af
	pop	af
;fyos_c.c:339: goto commandloop;
;fyos_c.c:344: return 0;
;fyos_c.c:346: }
	jp	00105$
___str_76:
	.ascii "FyOS v0.1"
	.db 0x0a
	.ascii "by FyberOptic"
	.db 0x0a
	.ascii " "
	.db 0x0a
	.db 0x00
___str_77:
	.ascii "Mailstation firmware: v%d.%d"
	.db 0x0a
	.db 0x00
___str_78:
	.db 0x0a
	.ascii "Global var init test: "
	.db 0x00
___str_79:
	.ascii "Pass"
	.db 0x00
___str_80:
	.ascii "Fail"
	.db 0x00
___str_81:
	.db 0x0a
	.ascii "P2shadow: %x"
	.db 0x0a
	.ascii "P3shadow: %x"
	.db 0x0a
	.ascii "cgafont_addr: %x"
	.db 0x0a
	.db 0x00
___str_82:
	.ascii " "
	.db 0x00
___str_83:
	.db 0x00
	.db 0x00
___str_84:
	.ascii "reset"
	.db 0x00
___str_85:
	.ascii "hextoint"
	.db 0x00
___str_86:
	.ascii "cls"
	.db 0x00
___str_87:
	.ascii "peek"
	.db 0x00
___str_88:
	.ascii "poke"
	.db 0x00
___str_89:
	.ascii "port_in"
	.db 0x00
___str_90:
	.ascii "port_out"
	.db 0x00
___str_91:
	.ascii "help"
	.db 0x00
___str_92:
	.ascii "scancodes"
	.db 0x00
___str_93:
	.ascii "powerdown"
	.db 0x00
___str_94:
	.ascii "reboot"
	.db 0x00
___str_95:
	.ascii "Unknown command: %s"
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_96:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "        Waiting for transfer..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__myglobal:
	.db #0x64	; 100	'd'
__xinit__versionpointer:
	.dw #0x0036
	.area _CABS (ABS)
