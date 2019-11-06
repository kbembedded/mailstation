	; SPDX-License-Identifier: BSD-2-Clause

	; Quick demo demonstrating drawing to the screen using a raw binary as
	; well as a custom RLE encoding scheme. Uses a graphics drawing routine
	; that was pulled from Mailstation codeflash and copied here
	; Comment the line called out below in order to display the RLE image,
	; otherwise defaults to drawing a cityscape image.

	; Originally written by FyberOptic

	.globl	_p2shadow
	.globl	_UpdateGraphicsLCD

	.area	_CODE

_main::

	di
	
	ld	hl, #cityscape
	ld	de, #0xc010
	ld	bc, #0d5120	; #002$ - #001$
	ldir
	call _UpdateGraphicsLCD
	
	; Comment the following line to draw RLE Fybertech logo
	jp	.
	
	;----

	ld	ix, #logodata	; ix = rle data
	ld	hl, #0xc010	; hl = destination for decompression
	
decodenext:	
	ld	b, #0		; load # of repeating bytes into bc counter
	ld	c, (ix)
	
	inc	ix
			
	ld	a, (ix)		; a = byte to repeat
	ld	d, a		; preserve a
		
	or	c
	jr	z, decode_done	; check if a | c = 0.  if so, rle_done
	
	ld	a, d		; restore a
	;ld	a, #0d255
	ld	(hl), a		; load byte value into mem location
	
	dec	bc		; count minus one
	
	xor	a		; if count was just 1, skip ldir sequence, since we already put one byte
	or	c
	jr	z, singlebytedecode
	
	ld	d, h		; de = hl
	ld	e, l
	inc	de		; + 1
	
	ldir			; repeat character into memory

singlebytedecode:	
	inc	hl		; increment memory location	
	inc	ix		; put ix at next data byte	
	
	jr	decodenext	; decode more
	
	
decode_done:

	call _UpdateGraphicsLCD
	
	;ld	hl, #_p2shadow
	;ld	a, (hl)
	;set	4, a
	;ld	(hl), a
	;out	(#02), a
	
	jr	.



	.area	_DATA
logodata:
	.include "fybertechlogo_rle.inc"
cityscape:
	.include "cityscape.inc"		
