
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


	; Shadow vars, defined in CRT0
	.globl	_p2shadow
	.globl	_p3shadow


;------------------------------------------------------------------------------
; This code is inserted into C's global variable initialization routine
;------------------------------------------------------------------------------

	.area   _GSINIT
	xor	a			; Reset cursor position
	ld	(_cursorx), a
	ld	(_cursory), a
	
	
	; Move CGA font data to an aligned 256-byte area
	ld	hl, #cgafont_dataarea	; find aligned address
	inc	h	
	ld	l, #0
	ld	(_cgafont_addr), hl	
	ex	de, hl			; copy font data
	ld	hl, #cgafont_data	
	ld	bc, #cgafont_data_end - #cgafont_data
	ldir
	

;------------------------------------------------------------------------------
; cgafont_dataarea holds 256 bytes of padding, followed by 2KB of font data.
; The above code run during inializiation finds where the page aligns to a 
; 256-byte boundary inside the padding, and then shifts the font data to that
; location.  The new pointer to the font data is then set in '_cgafont_addr'.
;------------------------------------------------------------------------------
	
	.area	_DATA	
	cgafont_dataarea:
	.ds	256			; padding bytes
	cgafont_data:
	.include "cgafont.inc"
	cgafont_data_end:


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
; UpdateCharLCD
;
; Parameters: none
;
; Updates both halves of the LCD from the text buffer at _textmodebuffer.
;
;------------------------------------------------------------------------------
UpdateCharLCD::
	push	af
	push	bc
	push	ix	
	
	in	a, (#06)	; Save current	slot4000 device
	ld	b, a
	
	ld	a,#02		; select left half of LCD	
	out	(#06),a
	ld	ix, #_textmodebuffer	; set left half of characters
	call UpdateCharLCD_Half
	ld	a,#04		; select left half of LCD
	out	(#06),a
	ld	ix, #_textmodebuffer + #0d20	; set left half of characters
	call UpdateCharLCD_Half
	
	ld	a, b		; Restore slot4000 device
	out	(#06), a
	
	pop	ix
	pop	bc
	pop	af
	ret


;------------------------------------------------------------------------------
; scrollscreen 
;
; Parameters: none
;
; Shifts text buffer (_textmodebuffer) up by one line, then clears the bottom
; line to ascii 0.  Calls UpdateCharLCD to apply changes.
;
;------------------------------------------------------------------------------
scrollscreen::
	push	af
	push	bc
	push	de
	push	hl
	
	ld	hl, #_textmodebuffer + #0d40	; copy all lines up by one
	ld	de, #_textmodebuffer
	ld	bc, #0d600			; only 600 chars, since skipping top row
	ldir
	ld	a, #0				; clear bottom row
	ld	(_textmodebuffer + 0d600), a
	ld	hl, #_textmodebuffer + #0d600
	ld	de, #_textmodebuffer + #0d601
	ld	bc, #0d39
	ldir
	
	call UpdateCharLCD			; update!
	
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
printchar:

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
	
	ld	a, (_cursorx)
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
	ld	a, #0
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
	
	; subtract 20 from x. if carry, x is left side of lcd. subtract result from 255 for real column number
	; if right side, subtract 20 again, then subtract result from 255 for column
	ld	a, (_cursorx)
	sub	a, #0d20
	jr	nc, #printchar_rightlcd
	ld	b, a
	in	a, (#06)		; save slot4000 device
	ld	d, a
	ld	a, #02
	out	(#06), a		; set left half of lcd
	jr	printchar_out
printchar_rightlcd:
	sub	a, #0d20			; subtract again since right half
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
	ld	a,(hl)		; start CAS, toggle bit from shadow P2 byte
	and	#0xf7
	ld	(hl),a
	out	(#02),a
	
	ld	a,b			; write column	to LCD	
	ld	(iy),a
	
	ld	hl, (_p2shadow)
	ld	a,(hl)		; end CAS, toggle bit from shadow P2 byte
	or	#08
	ld	(hl),a
	out	(#02),a
	
	ld	a, (_cursory)
	sla	a			; a * 8
	sla	a
	sla	a			
	ld	b, #0
	ld	c, a
	add	iy, bc			; iy = #4038 + (cursory * 8) = lcd address to put character
	
	ld	a, (ix)			; retrieve character again
	;ld	hl, #cgafont
	ld	hl, (_cgafont_addr) ; load font base address	
	ld	l, a	
	
	ld	b, #8
printchar_charout:
	ld	a, (hl)
	ld	(iy), a			; put character onto screen
	inc	h
	inc	iy
	djnz	printchar_charout
	
	
	ld	a, d
	out	(#06), a		; restore slot4000 device
	
	ld	a, (_cursorx)		; inc cursorx, check boundaries
	inc	a
	ld	b, a
	sub	a, #0d40
	jr	nc, printchar_nextline
	ld	a, b
	ld	(_cursorx), a		; set new cursor position	
	jr	printchar_done
	
printchar_nextline:	
	ld	a, #0
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
	call	scrollscreen	
		
printchar_done:
	pop	iy
	pop	ix
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret
	
	
