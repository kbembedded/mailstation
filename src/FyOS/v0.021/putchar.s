
	.module putchar

	.include "standardbuild.inc"


        .area   _BSS
_cursorx::			; Cursor X position
	.ds	1
_cursory::			; Cursor Y position
	.ds	1
_textmodebuffer::		; Text screen buffer
	.ds	640
_cgafont_addr::			; Pointer to CGA font data (after it's moved at init)
	.ds	2		; You could change this data via C using this
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
	
.if	__standard_build
	
	;; Check if font data is already aligned
	;ld	hl,(_cgafont_addr)
	;xor	a
	;or	l
	;jr	z,cgaaligned
	
	; Move CGA font data to an aligned 256-byte area
	ld	hl, #cgafont_dataarea	; find aligned address
	inc	h	
	ld	l, #0
	
	; Check if font data already aligned
	ld	de,(_cgafont_addr)
	ld	a,h
	cp	d
	jr	nz,docgaalign
	xor	a
	or	e
	jr	z,cgaaligned	
	
docgaalign:
	ld	(_cgafont_addr), hl	
	ex	de, hl			; copy font data
	ld	hl, #cgafont_data	
	ld	bc, #cgafont_data_end - #cgafont_data
	ldir
cgaaligned:


; if not "standard build", then we'll hard-code the font data somewhere
.else

	ld hl, #__cgafont_data
	ld (_cgafont_addr), hl

.endif
	
;------------------------------------------------------------------------------
; cgafont_dataarea holds 256 bytes of padding, followed by 2KB of font data.
; The above code run during inializiation finds where the page aligns to a 
; 256-byte boundary inside the padding, and then shifts the font data to that
; location.  The new pointer to the font data is then set in '_cgafont_addr'.
; Alignment is necessary to optimize drawing characters to the LCD.
;------------------------------------------------------------------------------

.if	__standard_build
	
	.area	_DATA	
	cgafont_dataarea::
	.ds	256			; padding bytes
	cgafont_data::
	.include "cgafont.inc"
	cgafont_data_end::
.else
	.area	_CGAFONTDATA

	__cgafont_data::
	.include "cgafont.inc"
	
	
.endif

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
	ld	hl, (_cgafont_addr) ; load font base address	
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
	ld	b, #0x14		; do 20 columns total
ScrollCharLCD_2:
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
	
	ld	hl, #0x4040		; move all rows up one except last
	ld	de, #0x4038
	ld	bc, #0d120
	ldir
	
	ld	hl, #0x40B0		; clear last char row
	ld	(hl), #0
	ld	de, #0x40B1
	ld	bc, #0d7
	ldir
	
	pop	bc			; restore column counter
	
	djnz	ScrollCharLCD_2		; column--, if not zero keep going
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

_scrollscreen_next:	
	ld	hl, #_textmodebuffer + #0d40	; copy all lines up by one
	ld	de, #_textmodebuffer
	ld	bc, #0d600			; only 600 chars, since skipping top row
	ldir
	xor	a				; clear bottom row
	ld	(_textmodebuffer + 0d600), a
	ld	hl, #_textmodebuffer + #0d600
	ld	de, #_textmodebuffer + #0d601
	ld	bc, #0d39
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
	
	push	af
	push	bc
	push	de
	push	hl
	push	iy
	
	ld	a, 4(ix)
	;ld	a, (_cursorx)
	sub	a, #0d20
	jr	nc, #printchar_rightlcd
	ld	b, a
	in	a, (#06)		; save slot4000 device
	ld	d, a
	ld	a, #02
	out	(#06), a		; set left half of lcd
	jr	printchar_out
printchar_rightlcd:
	sub	a, #0d20		; subtract again since right half
	ld	b, a
	in	a, (#06)		; save slot4000 device
	ld	d, a
	ld	a, #04
	out	(#06), a		; set right half of	lcd

printchar_out:
	ld	a, #0d255
	sub	a, b		
	ld	b, a			; b is now the	reversed lcd column number
	
	ld	iy, #0x4038		; lcd viewable start address
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; start CAS, toggle bit from shadow P2 byte
	and	#0xf7
	ld	(hl),a
	out	(#02),a
	
	ld	a,b			; write column	to LCD	
	ld	(iy),a
	
	ld	hl, (_p2shadow)
	ld	a,(hl)			; end CAS, toggle bit from shadow P2 byte
	or	#08
	ld	(hl),a
	out	(#02),a
	
	ld	a, 5(ix)		; 8, 9
	;ld	a, (_cursory)
	sla	a			; a * 8
	sla	a
	sla	a			
	ld	b, #0
	ld	c, a
	add	iy, bc			; iy = #4038 + (cursory * 8) = lcd address to put character
	
	ld	a, 6(ix)		; 4, 5
	;ld	a, (ix)			; retrieve character again
	ld	hl, (_cgafont_addr) ; load font base address	
	ld	l, a	
	
	ld	b, #8
printchar_charout:
	ld	a, 7(ix)		; load ordata var
	or	a
	jr	z, printchar_charout_noor
	
	ld	a, (iy)			; get old screen data
	ld	e, a	
	ld	a, (hl)			; get font data	
	or	e			; mix both together
	jr	printchar_charout_last

printchar_charout_noor:
	ld	a, (hl)			; get font data

printchar_charout_last:	
	ld	(iy), a			; put character onto screen
	inc	h
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
	ld	a, #0d39
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
	ld	e, #0d40		
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
	sub	a, #0d40
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
	sub	a, #0d16
	jr	nc, #printchar_firstline
	ld	a, b
	ld	(_cursory), a
	jr	printchar_done
	
printchar_firstline:
	;ld	a, #0
	;ld	(_cursory), a
	ld	a, #0d15
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
		
	ld	hl, #2 + #6	; get casbit parameter into a
	add	hl, sp
	ld	a, (hl)
		
	and	#1		; casbit = (casbit & 1) << 3
	sla	a
	sla	a
	sla	a
	ld	b, a
	ld	hl, (_p2shadow)	; Get p2shadow pointer
	ld	a, (hl)		
	and	#0xf7		; *p2shadow = (*p2shadow & 0xF7) | casbit
	or	b
	ld	(hl), a		
	out	(#02), a	; port2 = *p2shadow
		
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
	ld	h, #0d40		; 40 * cursory
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
	
