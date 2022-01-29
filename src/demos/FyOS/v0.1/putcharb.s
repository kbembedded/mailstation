
	.module putchar

	.include "bios.inc"

	;.globl	_cursorx, _cursory, _textmodebuffer, _cgafont_addr

	; Shadow vars, defined in CRT0
	;.globl	_p2shadow
	;.globl	_p3shadow


;------------------------------------------------------------------------------
; This code is inserted into C's global variable initialization routine
;------------------------------------------------------------------------------

	.area   _GSINIT
	

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------


	.area   _CODE
	
;.globl UpdateCharLCD_Half, _UpdateCharLCD

;.globl ClearLCD_Half, _ClearLCD

;.globl ScrollCharLCD_Half, _scrollscreen

;.globl printchar

;.globl _LCD_CAS

;------------------------------------------------------------------------------
; putchar(char c);
;
; Prints c to the screen using 'printchar' below.
;
;------------------------------------------------------------------------------
;_putchar::			; This is the function C calls
;_putchar_rr_s::			; Do this if the character is pushed onto stack
;        ld      hl,#2
;        add     hl,sp
;
;        ld      a,(hl)
;	call printchar
;        ret
;
;_putchar_rr_dbs::
;        ld      a,e		; Or do this if character in 'e' register
;	call printchar
;
;        ret


