
	.area _BSS

mycharbuffer:				; Scancode buffer for _getchar
	.ds	2


getkeycodefrombuffer = #0x0A9A		; Mailstation function


;------------------------------------------------------------------------------
; scancode_table holds two tables of ascii characters which '_getchar' uses
; to determine which character to return, depending on the scancode pressed
; and the state of the shift key.
;------------------------------------------------------------------------------

	.area _DATA
scancode_table:
	.include	'scancode_table.inc'


;------------------------------------------------------------------------------
;------------------------------------------------------------------------------	
	
	.area _CODE


multiply:
; multiply h by e and return 16 bit result in hl. The b and d
; register will be zeroed on exit. Requires between 301 and 349
; clock cycles.
;
; Needed by '_getchar', below.
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
; _getchar
;
; Parameters: none
; Returns: ASCII character code in 'l' register 
;
; Waits for a scancode using the Mailstation firmware's getkeycodefrombuffer 
; function (0x0A9A), then uses the two conversion tables at 'scancode_table' 
; to determine the ascii character depending on the state of the shift key.
; Currently does not handle extended keys or caps lock.
;
;------------------------------------------------------------------------------
_getchar::
keyagain:
	; wait till a key is available
	ld	de, #mycharbuffer
	push	de	
	call	getkeycodefrombuffer
	pop	de	
	jp	z, keyagain
	
	ld	a, (mycharbuffer+1)	; Got a scancode; check its state
	bit	0, a
	jp	z, keyagain		; if key released, we don't care, get another
	ld	a, (mycharbuffer)
	and	#0x0F			; save low nibble in b
	ld	b, a
	ld	a, (mycharbuffer)
	srl	a			; save high nibble in c
	srl	a
	srl	a
	srl	a
	ld	c, a	
	ld	h, #8			; hl = 8 * high nibble
	ld	e, c
	call multiply
	ld	a, b			; low nibble + (8 * high nibble)
	add	l
	ld	b, #0			; bc = position in scancode_table
	ld	c, a
	ld	hl, #scancode_table	; hl = scancode_table + offset (starting in lowercase codes)
	add	hl, bc	
	ld	a, (mycharbuffer+1)	; check if shift/capslock
	bit	6, a
	jr	nz, do_ascii_caps
	;bit	5, a			; actually don't check capslock for now, that only affects letters
	;jr	nz, get_ascii_caps
	jr	get_ascii_char		; no caps, so just get lowercase
do_ascii_caps:
	ld	bc, #0d80
	add	hl, bc	
get_ascii_char:	
	ld	a, (hl)
	or	a			; check if ascii = 0
	jr	z, print_scan_char
	cp	a, #0d255		; check if ascii = 255
	jr	z, print_scan_char
	ld	a, (hl)			; print ascii code
	jr	print_ascii_char
print_scan_char:
	jp	keyagain		; Let's not deal with extended keys for now
	;jr	checkbutton
	;ld	a, #0
	;ld	a, (mycharbuffer)	; otherwise load original scan code
	;ld	l, a
	;ret
print_ascii_char:
	ld	l, a			; Return ascii code
	ret
	
	
