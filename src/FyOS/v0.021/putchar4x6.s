
	.module putchar

	.include "standardbuild.inc"



textmodewidth = 0d80
textmodeheight = 0d21

        .area   _BSS
_cursorx::			; Cursor X position
	.ds	1
_cursory::			; Cursor Y position
	.ds	1
_textmodebuffer::		; Text screen buffer
	.ds	textmodewidth * textmodeheight 	; (1680)
;_cgafont_addr::			; Pointer to CGA font data (after it's moved at init)
	;.ds	2		; You could change this data via C using this
				; pointer for a dynamic font or graphics tiles.

__cursorblink_on:
	.ds	1
__cursorlastx:
	.ds	1
__cursorlasty:
	.ds	1	


	; Shadow vars, defined in CRT0
	.globl	_p2shadow
	.globl	_p3shadow


;------------------------------------------------------------------------------
; This code is inserted into C's global variable initialization routine
;------------------------------------------------------------------------------

	.area   _GSINIT
	
	; Reset cursor position
	xor	a
	ld	(_cursorx), a
	ld	(_cursory), a
	ld	(__cursorlastx), a
	ld	(__cursorlasty), a
	


;------------------------------------------------------------------------------
;------------------------------------------------------------------------------


	.area   _CODE
	
;------------------------------------------------------------------------------
; UpdateCharLCD_Half
;
; Parameters: ix = start address of text buffer
;
; Expects LCD to already be paged into slot4000.  Takes ascii characters from 
; text buffer and draws them to the screen, using the font at _cgafont_addr.
;
;------------------------------------------------------------------------------
UpdateCharLCD_Half:
	push	af
	push	bc
	push	de
	push	hl
	ld	b,#0x14
UpdateCharLCD_2:
	ld	de,#0x4038
	
	ld	hl, (_p2shadow)
	ld	a,(hl)	; start CAS, toggle bit from shadow P2 byte
	and	#0xf7
	ld	(hl),a
	out	(#0x02),a
	
	ld	a,b		; write column-1 to LCD
	dec	a
	ld	(de),a
	
	ld	hl, (_p2shadow)
	ld	a,(hl)	; end CAS, toggle bit from shadow P2 byte
	or	#0x08
	ld	(hl),a
	out	(#0x02),a
	
	;ld	a,b		; save column for a moment
	push	bc
	
	;ld	hl, #0000	; save sp
	;add	hl, sp
	
	;push	hl		; decrement sp
	
	ld	c, #0		; start character row 0
nextcharrow:
	ld	b, #0		; start character scanline 0
nextcharscan:	
	;ld	hl, #cgafont	; load font base address	
	ld	hl, #_font_data ; load font base address	
	ld	l, (ix)
	ld	a, h
	add	a, b
	ld	h, a
	ld	a, (hl)
	ld	(de), a		; write character row to lcd
	
	inc	de
	inc	b
	ld	a, b	
	cp	a, #0x8		; 8 rows per character
	jr	nz, nextcharscan
		
	;ld	hl, bc		; save bc (AS80 ONLY)
	push	bc
	ld	bc, #0x0028	; add 40 to current charxy memory position
	add	ix, bc
	;ld	bc, hl		; restore bc (AS80 ONLY)
	pop	bc
	
	ld	a, c
	inc	a
	ld	c, a
	cp	a, #0d16	; 16 characters per row
	jr	nz, nextcharrow
	

	push	ix
	pop	hl
	ld	bc, #0d639
	scf
	ccf
	sbc	hl, bc	
	;ld	bc, hl	(AS80 ONLY)
	push	hl
	pop	bc	
	ld	ix, #0000
	add	ix, bc
	
		
	pop	bc
	djnz	UpdateCharLCD_2		; column--, if not zero keep going
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret


;------------------------------------------------------------------------------
; UpdateCharLCD()
;
; Parameters: none
;
; Updates both halves of the LCD from the text buffer at _textmodebuffer.
;
;------------------------------------------------------------------------------
_UpdateCharLCD::
	push	af
	push	bc
	push	ix	
	
	in	a, (#06)		; Save current	slot4000 device
	ld	b, a
	
	ld	a,#02			; select left half of LCD	
	out	(#06),a
	ld	ix, #_textmodebuffer	; set left half of characters
	call UpdateCharLCD_Half
	ld	a,#04			; select left half of LCD
	out	(#06),a
	ld	ix, #_textmodebuffer + #0d20	; set right half of characters
	call UpdateCharLCD_Half
	
	ld	a, b			; Restore slot4000 device
	out	(#06), a
	
	pop	ix
	pop	bc
	pop	af
	ret


;-----------------------------------------------------------------------------
; ClearLCD_Half
;
; Parameters: none
; Destroys: af, bc, de, hl
;
; Clears the LCD half currently in slot4000
;
;-----------------------------------------------------------------------------
ClearLCD_Half:
	ld	b,#0x14
ClearLCD_2:
	ld	de,#0x4038
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; start CAS, toggle bit from shadow P2 byte
	and	#0xf7
	ld	(hl),a
	out	(#0x02),a
	
	ld	a,b			; write column-1 to LCD
	dec	a
	ld	(de),a
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; end CAS, toggle bit from shadow P2 byte
	or	#0x08
	ld	(hl),a
	out	(#0x02),a
	
	push	bc			; preserve our column counter	
	ld	hl, #0x4038
	ld	(hl), #0
	ld	de, #0x4039
	ld	bc, #0d127
	ldir	
	pop	bc			; restore column counter
	
	djnz	ClearLCD_2		; column--, if not zero keep going

	ret


;-----------------------------------------------------------------------------
; ClearLCD()
;
; Parameters: none
;
; Clears the LCD with 0's.
;
;-----------------------------------------------------------------------------
_ClearLCD::
	push	af
	push	bc
	push	de
	push	hl
	
	di
	
	in	a, (#06)		; Save current	slot4000 device
	push	af
	
	ld	a,#02			; select left half of LCD	
	out	(#06),a
	call	ClearLCD_Half
	ld	a,#04			; select left half of LCD
	out	(#06),a
	call	ClearLCD_Half
	
	pop	af			; Restore slot4000 device
	out	(#06), a
	
	ei
	
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret


;-----------------------------------------------------------------------------
; ScrollCharLCD_Half
;
; Parameters: none
; Destroys: af, bc, de, hl
;
; Scrolls LCD half in slot4000 up by 8 pixel rows (aka one char row).
;
;-----------------------------------------------------------------------------
ScrollCharLCD_Half:	
	ld	b, #0x14			; do 20 columns total
ScrollCharLCD_2:
	ld	de,#0x4038
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; start CAS, toggle bit from shadow P2 byte
	and	#0xf7
	ld	(hl),a
	out	(#0x02),a
	
	ld	a,b				; write column-1 to LCD
	dec	a
	ld	(de),a
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; end CAS, toggle bit from shadow P2 byte
	or	#0x08
	ld	(hl),a
	out	(#0x02),a
	
	push	bc				; preserve our column counter
	
	ld	hl, #0x403E		; move all rows up one except last
	ld	de, #0x4038
	ld	bc, #0d120		
	ldir
	
	ld	hl, #0x40B0		; clear last char row
	ld	(hl), #0
	ld	de, #0x40B1
	ld	bc, #0d7
	ldir
	
	pop	bc				; restore column counter
	
	djnz	ScrollCharLCD_2	; column--, if not zero keep going
	ret



;------------------------------------------------------------------------------
; scrollscreen()
;
; Parameters: none
;
; Shifts text buffer '_textmodebuffer' up by one line, then clears the bottom
; line to ascii 0.  It then scrolls the actual LCD, one half at a time, using 
; the ScrollCharLCD_Half function above.
;
;------------------------------------------------------------------------------
_scrollscreen::
	push	af
	push	bc
	push	de
	push	hl
	
	di
	
	ld	a, (__cursorblink_on)
	or	a
	jr	z, _scrollscreen_next
	call	_updatecursor

totalchars_minusrow = (#textmodewidth * #textmodeheight) - #textmodewidth

_scrollscreen_next:	
	; copy all lines up by one
	ld	hl, #_textmodebuffer + #textmodewidth	
	ld	de, #_textmodebuffer
	ld	bc, #totalchars_minusrow
	ldir
	; clear bottom row
	xor	a				
	ld	(#_textmodebuffer + #totalchars_minusrow), a
	ld	hl, #_textmodebuffer + #totalchars_minusrow
	ld	de, #_textmodebuffer + #(totalchars_minusrow + #1)
	ld	bc, #textmodewidth - 1
	ldir
	
	;call _UpdateCharLCD			; This is slow, so we don't do it anymore
	;jr	_scrollscreen_end
	
	in	a, (#06)			; Save current slot4000 device
	push	af
	
	ld	a,#02				; select left half of LCD	
	out	(#06),a
	call	ScrollCharLCD_Half
	ld	a,#04				; select right half of LCD
	out	(#06),a
	call	ScrollCharLCD_Half
	
	pop	af				; Restore slot4000 device
	out	(#06), a

_scrollscreen_end:	
	
	ei
	
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret

;------------------------------------------------------------------------------
	
multiply:
; multiply h by e and return 16 bit result in hl. The b and d
; register will be zeroed on exit. Requires between 301 and 349
; clock cycles.
; 
; This is only used by 'printchar' below.
;
	push	bc
	push	de
	push	af
	ld	d, #0
	ld	l, d
	ld	b, #8
multiply_NEXT:
	add	hl, hl
	jr	nc, multiply_NOADD
	add	hl, de
multiply_NOADD:
	djnz	multiply_NEXT	
	pop 	af
	pop 	de
	pop 	bc	
	ret


;------------------------------------------------------------------------------
; putchar(char c);
;
; Prints c to the screen using 'printchar' below.
;
;------------------------------------------------------------------------------
_putchar::			; This is the function C calls
_putchar_rr_s::			; Do this if the character is pushed onto stack
        ld      hl,#2
        add     hl,sp

        ld      a,(hl)
	call printchar
        ret

_putchar_rr_dbs::
        ld      a,e		; Or do this if character in 'e' register
	call printchar

        ret


;------------------------------------------------------------------------------
; putcharXY(unsigned char x, unsigned char y, unsigned char c, unsigned char ordata)
_putcharXY::
	; subtract 20 from x. if carry, x is left side of lcd. subtract result from 255 for real column number
	; if right side, subtract 20 again, then subtract result from 255 for column
				; 0, 1 = ret address
	push	ix		; 2, 3
	ld	ix, #0
	add	ix, sp
	
	; 0,1(ix) = old IX
	; 2,3(ix) = return address
	; 4(ix) = x
	; 5(ix) = y
	; 6(ix) = c
	; 7(ix) = ordata
	
	
	push	af
	push	bc
	push	de
	push	hl
	push	iy
	
	; subtract X position by textmodewidth/2, check if left or right LCD halve
	ld	a, 4(ix)
	;ld	a, (_cursorx)
	sub	a, #textmodewidth / 2
	jr	nc, #printchar_rightlcd	
	
	ld	b, a
	
	; save slot4000 device
	in	a, (#06)		
	ld	d, a
	
	; set left half of lcd
	ld	a, #02
	out	(#06), a		
	
	jr	printchar_out
printchar_rightlcd:
	sub	a, #textmodewidth / 2	; subtract again since right half
	ld	b, a
	
	; save slot4000 device
	in	a, (#06)		
	ld	d, a
	
	; set right half of	lcd
	ld	a, #04
	out	(#06), a		

printchar_out:
	ld	a, #0d255
	sub	a, b		
	srl	a			; shift right (divide by 2), carry determines high or low nibble of LCD data (we'll find it later)
	ld	b, a			; b is now the	reversed lcd column number	
	
	
	ld	iy, #0x4038	; lcd viewable start address
	
	; start CAS, toggle bit from shadow P2 byte
	ld	hl, (_p2shadow)
	ld	a,(hl)			
	and	#0xf7
	ld	(hl),a
	out	(#02),a
	
	; write column	to LCD
	ld	a,b			
	ld	(iy),a
	
	; end CAS, toggle bit from shadow P2 byte
	ld	hl, (_p2shadow)
	ld	a,(hl)			
	or	#08
	ld	(hl),a
	out	(#02),a
	
	
	; a = Y * 6 (font is six characters high)
	ld	a, 5(ix)
	add	a, 5(ix)
	add	a, 5(ix)
	add	a, 5(ix)
	add	a, 5(ix)
	add	a, 5(ix)
	
	ld	b, #0
	ld	c, a
	add	iy, bc			; iy = #4038 + (cursory * 8) = lcd address to put character
	
	
	; hl = _font_addr + (char * 6)
	ld	hl, #_font_data
	ld	b, #0
	ld	c, 6(ix)
	add	hl, bc
	add	hl, bc
	add	hl, bc
	add	hl, bc
	add	hl, bc
	add	hl, bc
	
	
	ld	b, #6			; font height
printchar_charout:
	
	; check if X position is even or odd
	ld	a, 4(ix)
	and	#1
	jr	z, printchar_charout_even
	
	; X is odd, so use high nibble
	
	ld	a, (hl)	; get font data	 
	and	#0xF0	; mask high nibble
	ld	e, a		; save for now	
	
	ld	a, (iy)	; get lcd data
	and	#0x0F	; preserve low nibble
	
	or	e		; merge both
	
	jr 	printchar_charout_last	

printchar_charout_even:

	; X is even, so use low nibble

	ld	a, (hl)	; get font data	 
	and	#0x0F	; mask high nibble
	ld	e, a		; save for now	
	
	ld	a, (iy)	; get lcd data
	and	#0xF0	; preserve low nibble
	
	or	e		; merge both

printchar_charout_last:	
	ld	(iy), a			; put character row onto screen
	
	inc	hl
	inc	iy
	djnz	printchar_charout
	
	
	
	ld	a, d
	out	(#06), a		; restore slot4000 device
		
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	pop	ix
	
	ret




;------------------------------------------------------------------------------
; printchar
;
; Parameters: a = character to print
;
; Prints a character to the screen at the cursorx/cursory position, and increm-
; ents them appropriately.  Interprets carriage returns, line feeds, and back-
; spaces.  Backspace will backtrack to the previous line until it reaches row 
; 0.  Line feeds or wrapping that occur on row 15 trigger the 'scrollscreen'
; function.
;
; Called via C's 'putchar' function, above.
;
;------------------------------------------------------------------------------
printchar::

	push	af
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
	
	cp	a, #0d10		; new line
	jp	z, printchar_nextline	
	cp	a, #0d13		; carriage return
	jr	z, printchar_carriagereturn
	cp	a, #0d08		; backspace
	jr	nz, printchar_endspecialcharchecks
	
	ld	a, (_cursorx)		; handle backspace
	or	a
	jp	z, printchar_backspace_upline
	dec	a
	ld	(_cursorx), a
	jp	printchar_done
	
printchar_backspace_upline:
	ld	(_cursorx), a
	ld	a, (_cursory)
	cp	a, #0d0
	jp	z, printchar_done
	dec	a
	ld	(_cursory), a
	ld	a, #textmodewidth - 1
	ld	(_cursorx), a
	jp	printchar_done
	
	
printchar_carriagereturn:
	xor	a
	ld	(_cursorx), a
	jp	printchar_done

printchar_endspecialcharchecks:
	push	af			; save character
	
	ld	a, (_cursory)
	ld	h, a
	ld	e, #textmodewidth		
	call multiply
	ld	b, #0
	ld	a, (_cursorx)
	ld	c, a
	add	hl,bc			; (y * 40) + x
	ld	bc, #_textmodebuffer
	add	hl,bc			; result added	to memory address c010 for buffer
	
	push	hl			; ix = hl
	pop	ix			
	pop	af			; restore character
	
	ld	(ix), a			; put character in ram location
	
	
	ld	h, #0
	ld	l, (ix)
	push	hl

	ld	a, (_cursory)
	ld	h, a
	ld	a, (_cursorx)
	ld	l, a
	push	hl
	call	_putcharXY
	pop	af
	pop	af
	;inc	sp
	
	
	ld	a, (_cursorx)		; inc cursorx, check boundaries
	inc	a
	ld	b, a
	sub	a, #textmodewidth
	jr	nc, printchar_nextline
	ld	a, b
	ld	(_cursorx), a		; set new cursor position	
	jr	printchar_done
	
printchar_nextline:	
	xor	a
	ld	(_cursorx), a
	ld	a, (_cursory)
	inc	a
	ld	b, a
	sub	a, #textmodeheight
	jr	nc, #printchar_firstline
	ld	a, b
	ld	(_cursory), a
	jr	printchar_done
	
printchar_firstline:
	;ld	a, #0
	;ld	(_cursory), a
	ld	a, #textmodeheight - 1
	call	_scrollscreen
		
printchar_done:
	call	_updatecursor
	pop	iy
	pop	ix
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret
	
	

;-----------------------------------------------------------------------------
; LCD_CAS(unsigned char casbit);
;
; Sets the LCD column address select bit.  CAS has to be enabled in order for
; you to write the column number to the LCD, then disabled before you can
; write graphics data to it.
; 
; 0 = CAS enabled
; 1 = CAS disabled
;-----------------------------------------------------------------------------
_LCD_CAS::
	push	af
	push	bc
	push	hl
		
	ld	hl, #2 + #6		; get casbit parameter into a
	add	hl, sp
	ld	a, (hl)
		
	and	#1				; casbit = (casbit & 1) << 3
	sla	a
	sla	a
	sla	a
	ld	b, a
	ld	hl, (_p2shadow)	; Get p2shadow pointer
	ld	a, (hl)		
	and	#0xf7			; *p2shadow = (*p2shadow & 0xF7) | casbit
	or	b
	ld	(hl), a		
	out	(#02), a			; port2 = *p2shadow
		
	pop	hl
	pop	bc
	pop	af
	ret
		



;------------------------------------------------------------------------------
_updatecursor::
	push	af
	push	bc
	push	de
	push	hl
	
	ld	a, (__cursorblink_on)	; check if cursor already on
	or	a
	jr	z, cursorblink_go_on

cursorblink_go_off:
	
	; get x/y coordinates in textmodebuffer
	ld	h, #textmodewidth		; 40 * cursory
	ld	a, (__cursorlasty)
	ld	e, a
	call	multiply		
	ld	a, (__cursorlastx)	; (40 * cursory) + cursorx
	ld	c, a
	ld	b, #0
	add	hl, bc	
	ld	bc, #_textmodebuffer	; textmodebuffer + (cursorx + (40 * cursory))
	add	hl, bc	
	ld	a, (hl)			; hl = character in buffer at x/y
	ld	b, a

	; put original character back
	ld	h, #0			
	ld	l, b
	push	hl
	ld	a, (__cursorlasty)
	ld	h, a
	ld	a, (__cursorlastx)
	ld	l, a
	push	hl
	call	_putcharXY
	pop	hl
	pop	hl
	
	xor	a
	ld	(__cursorblink_on), a
	jr	cursorblink_end
	
cursorblink_go_on:
	; draw cursor character (ascii 95 '_')
	ld	h, #1
	ld	l, #0d95
	push	hl
	ld	a, (_cursory)
	ld	h, a
	ld	(__cursorlasty), a	
	ld	a, (_cursorx)
	ld	(__cursorlastx), a
	ld	l, a
	push	hl
	call	_putcharXY
	pop	hl
	pop	hl
	
	ld	a, #1
	ld	(__cursorblink_on), a

cursorblink_end:
	pop	hl
	pop	de
	pop	bc
	pop	af	
	ret
	


	.area _DATA
	
_font_data:

	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.db	0x22, 0x22, 0x22, 0x00, 0x22, 0x00
	.db	0x55, 0x55, 0x00, 0x00, 0x00, 0x00
	.db	0x55, 0xFF, 0x55, 0xFF, 0x55, 0x00
	.db	0x22, 0x77, 0x33, 0x44, 0x77, 0x22
	.db	0x11, 0x44, 0x22, 0x11, 0x44, 0x00
	.db	0x22, 0x55, 0x22, 0x55, 0xAA, 0x00
	.db	0x22, 0x22, 0x00, 0x00, 0x00, 0x00
	.db	0x44, 0x22, 0x22, 0x22, 0x22, 0x44
	.db	0x11, 0x22, 0x22, 0x22, 0x22, 0x11
	.db	0x55, 0x22, 0x77, 0x22, 0x55, 0x00
	.db	0x22, 0x22, 0x77, 0x22, 0x22, 0x00
	.db	0x00, 0x00, 0x00, 0x00, 0x22, 0x11
	.db	0x00, 0x00, 0x77, 0x00, 0x00, 0x00
	.db	0x00, 0x00, 0x00, 0x00, 0x22, 0x00
	.db	0x44, 0x44, 0x22, 0x11, 0x11, 0x00
	.db	0x22, 0x55, 0x77, 0x55, 0x22, 0x00
	.db	0x22, 0x33, 0x22, 0x22, 0x77, 0x00
	.db	0x22, 0x55, 0x44, 0x22, 0x77, 0x00
	.db	0x77, 0x44, 0x22, 0x44, 0x33, 0x00
	.db	0x55, 0x55, 0x77, 0x44, 0x44, 0x00
	.db	0x77, 0x11, 0x33, 0x44, 0x33, 0x00
	.db	0x66, 0x11, 0x33, 0x55, 0x22, 0x00
	.db	0x77, 0x44, 0x22, 0x11, 0x11, 0x00
	.db	0x66, 0x55, 0x22, 0x55, 0x33, 0x00
	.db	0x22, 0x55, 0x66, 0x44, 0x33, 0x00
	.db	0x00, 0x22, 0x00, 0x00, 0x22, 0x00
	.db	0x00, 0x22, 0x00, 0x00, 0x22, 0x11
	.db	0x44, 0x22, 0x11, 0x22, 0x44, 0x00
	.db	0x00, 0x77, 0x00, 0x77, 0x00, 0x00
	.db	0x11, 0x22, 0x44, 0x22, 0x11, 0x00
	.db	0x33, 0x44, 0x22, 0x00, 0x22, 0x00
	.db	0x66, 0x55, 0x55, 0x11, 0x66, 0x00
	.db	0x22, 0x55, 0x77, 0x55, 0x55, 0x00
	.db	0x33, 0x55, 0x33, 0x55, 0x33, 0x00
	.db	0x22, 0x55, 0x11, 0x55, 0x22, 0x00
	.db	0x33, 0x55, 0x55, 0x55, 0x33, 0x00
	.db	0x77, 0x11, 0x33, 0x11, 0x77, 0x00
	.db	0x77, 0x11, 0x33, 0x11, 0x11, 0x00
	.db	0x66, 0x11, 0x55, 0x55, 0x66, 0x00
	.db	0x55, 0x55, 0x77, 0x55, 0x55, 0x00
	.db	0x77, 0x22, 0x22, 0x22, 0x77, 0x00
	.db	0x44, 0x44, 0x44, 0x55, 0x22, 0x00
	.db	0x55, 0x55, 0x33, 0x55, 0x55, 0x00
	.db	0x11, 0x11, 0x11, 0x11, 0x77, 0x00
	.db	0x55, 0x77, 0x77, 0x55, 0x55, 0x00
	.db	0x44, 0x55, 0x77, 0x55, 0x11, 0x00
	.db	0x22, 0x55, 0x55, 0x55, 0x22, 0x00
	.db	0x33, 0x55, 0x33, 0x11, 0x11, 0x00
	.db	0x22, 0x55, 0x55, 0x55, 0x22, 0x44
	.db	0x33, 0x55, 0x33, 0x55, 0x55, 0x00
	.db	0x66, 0x11, 0x22, 0x44, 0x33, 0x00
	.db	0x77, 0x22, 0x22, 0x22, 0x22, 0x00
	.db	0x55, 0x55, 0x55, 0x55, 0x77, 0x00
	.db	0x55, 0x55, 0x55, 0x77, 0x22, 0x00
	.db	0x55, 0x55, 0x77, 0x77, 0x55, 0x00
	.db	0x55, 0x55, 0x22, 0x55, 0x55, 0x00
	.db	0x55, 0x55, 0x22, 0x22, 0x22, 0x00
	.db	0x77, 0x44, 0x22, 0x11, 0x77, 0x00
	.db	0x66, 0x22, 0x22, 0x22, 0x66, 0x00
	.db	0x11, 0x11, 0x22, 0x44, 0x44, 0x00
	.db	0x33, 0x22, 0x22, 0x22, 0x33, 0x00
	.db	0x22, 0x55, 0x00, 0x00, 0x00, 0x00
	.db	0x00, 0x00, 0x00, 0x00, 0x00, 0x77
	.db	0x22, 0x44, 0x00, 0x00, 0x00, 0x00
	.db	0x00, 0x66, 0x55, 0x55, 0x66, 0x00
	.db	0x11, 0x33, 0x55, 0x55, 0x33, 0x00
	.db	0x00, 0x66, 0x11, 0x11, 0x66, 0x00
	.db	0x44, 0x66, 0x55, 0x55, 0x66, 0x00
	.db	0x00, 0x22, 0x55, 0x33, 0x66, 0x00
	.db	0x44, 0x22, 0x77, 0x22, 0x22, 0x00
	.db	0x00, 0x66, 0x55, 0x66, 0x44, 0x33
	.db	0x11, 0x33, 0x55, 0x55, 0x55, 0x00
	.db	0x22, 0x00, 0x33, 0x22, 0x77, 0x00
	.db	0x44, 0x00, 0x44, 0x44, 0x44, 0x33
	.db	0x11, 0x55, 0x33, 0x55, 0x55, 0x00
	.db	0x33, 0x22, 0x22, 0x22, 0x77, 0x00
	.db	0x00, 0x55, 0x77, 0x55, 0x55, 0x00
	.db	0x00, 0x33, 0x55, 0x55, 0x55, 0x00
	.db	0x00, 0x22, 0x55, 0x55, 0x22, 0x00
	.db	0x00, 0x33, 0x55, 0x33, 0x11, 0x11
	.db	0x00, 0x66, 0x55, 0x55, 0x66, 0x44
	.db	0x00, 0x55, 0x33, 0x11, 0x11, 0x00
	.db	0x00, 0x66, 0x33, 0x44, 0x33, 0x00
	.db	0x22, 0x77, 0x22, 0x22, 0x44, 0x00
	.db	0x00, 0x55, 0x55, 0x55, 0x66, 0x00
	.db	0x00, 0x55, 0x55, 0x55, 0x22, 0x00
	.db	0x00, 0x55, 0x55, 0x77, 0x55, 0x00
	.db	0x00, 0x55, 0x22, 0x22, 0x55, 0x00
	.db	0x00, 0x55, 0x55, 0x66, 0x44, 0x33
	.db	0x00, 0x77, 0x44, 0x22, 0x77, 0x00
	.db	0x44, 0x22, 0x33, 0x22, 0x22, 0x44
	.db	0x22, 0x22, 0x22, 0x22, 0x22, 0x00
	.db	0x11, 0x22, 0x66, 0x22, 0x22, 0x11
	.db	0xAA, 0x55, 0x00, 0x00, 0x00, 0x00
	.db	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	
	