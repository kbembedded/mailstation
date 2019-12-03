
.globl	_p2shadow

;/////////////////////////////////////////////////
;//  This is essentially the same function as in
;//  the Mailstation firmware, just removed so
;//  that it can be accessed regardless of which
;//  firmware version is used (since the address
;//  changes).  It draws the buffer at 0xc010 to
;//  the LCD.
;//
;//  If you never plan to use it, comment it out
;//  to save some space.
;//
;/////////////////////////////////////////////////

_UpdateGraphicsLCD::
		push	af
		push	bc
		push	de
		push	hl

		in	a, (#06)
		ld	e, a
		push	de
		ld	a, #0x02
		out	(#06), a
		ld	hl, #0xc010
		call	update_half
		ld	a, #0x04
		out	(#06), a
		ld	hl, #0xca10
		call	update_half
		pop	de
		ld	a, e
		out	(#06), a

		pop	hl
		pop	de
		pop	bc
		pop	af
		ret

	update_half:
		ld	b, #0x14
	update_half2:
		ld 	de, #0x4038

		push	hl
		ld	hl, (_p2shadow)
		ld 	a, (hl)
		and 	#0xF7
		ld 	(hl),a
		out 	(#02),a

		ld 	a, b
		dec 	a
		ld 	(de), a

		ld	a, (hl)
		or	#0x08
		ld	(hl),a
		out	(#02),a
		pop	hl

		ld	a, b
		ld	b, #0x00
		ld	c, #0x80
		ldir
		ld	b,a
		djnz	update_half2
		ret


