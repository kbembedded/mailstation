
	.module getchar

	.include "standardbuild.inc"


	.area _BSS

mycharbuffer::				; Scancode buffer for _getchar
	.ds	2


__getcharbuffer::			; Buffer of ascii characters for getchar to read
	.ds	32
__getcharbuffer_ptr == __getcharbuffer

__getcharbuffer_in::			; Position in buffer to place next char
	.ds	1
__getcharbuffer_out::			; Position in buffer to read next char
	.ds	1

__charbuffer_disable::
	.ds	1


.if	__standard_build

	ms_getkeycodefrombuffer == #0x0A9A	; Mailstation function
	
	__interrupt_table:
		.ds	514
		
	__keyscanstates::
	.ds	152
	
.else	
	; These locations are hard-coded in the BDOS
	.globl ms_getkeycodefrombuffer, __keyscanstates
	; __interrupt_table
.endif

__lastkeypressed:
	.ds	1

__keyrepeattimer1:
	.ds	1
__keyrepeattimer2:
	.ds	1
__keyrepeating:
	.ds	1

_interrupt_counter::
	.ds	2

	
;------------------------------------------------------------------------------
; Initialize getchar buffer positions
;------------------------------------------------------------------------------
	.area   _GSINIT

	xor	a				; Clear ascii char buffer position
	ld	(__getcharbuffer_in), a
	ld	(__getcharbuffer_out), a
	
	ld	(__lastkeypressed), a
	ld	(__keyrepeattimer1), a
	ld	(__keyrepeattimer2), a
	ld	(__keyrepeating), a
	
	ld	(__charbuffer_disable), a
	
	ld	hl, #__keyscanstates		; clear key states
	ld	(hl), a
	ld	de, #__keyscanstates + 1
	ld	bc, #0d151
	ldir	

.if	__standard_build	

	di					; Hook interrupt
	ld	hl, #__interrupt_table
	inc	h
	ld	l, #0
	ld	a, h
	ld	I, a	
	ld	(hl), #0xc1
	push	hl
	pop	de
	inc	de
	ld	bc, #0d256
	ldir
	
	ld	hl, #0xc1c1			; Add redirecting interrupt function at 0xc1c1
	ld	(hl), #0xc3			; JP opcode
	inc	hl
	ld	de, #_interrupt_hook
	ld	(hl), e				; low byte of interrupt hook routine
	inc	hl
	ld	(hl), d				; high byte of interrupt hook routine
	
	im	2
	ei	
	
	
	.area	_EXITPROC

	di		; restore original interrupt method
	im	1
	ei

.endif

;------------------------------------------------------------------------------
; scancode_table holds two tables of ascii characters which '_getchar' uses
; to determine which character to return, depending on the scancode pressed
; and the state of the shift key.
;------------------------------------------------------------------------------

	.area _DATA
scancode_table:
	.include	'scancode_table.inc'
__scancode_table::
	.dw		scancode_table		; pointer to use in C

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------	
	
	.area _CODE

.if	__standard_build

_interrupt_hook:
	; FYBER EDIT 09/13/08 - KILLS INTERRUPT COMPLETELY FOR HARDWARE TESTING
	reti
	
	push	af
	push	bc
	push	de
	push	hl
	
	in 	a,(0x03)
	ld	d, a
	and	#0xf9			; check if mask contains interrupts 7, 5, 6, 4, 3, or 0
	jr	nz, _interrupt_hook_end	; if so, go straight to handling those
	ld	a, #0x02		; check if mask is handling keyboard
	and	d
	jr	z, _interrupt_hook_end	; if not, handle whatever
	
	call	handlekeyrepeat

_interrupt_hook_end:
	pop	hl
	pop	de
	pop	bc
	pop	af
	
	jp	0x0039		; Firmware interrupt procedure



.endif


;------------------------------------------------------------------------------

_disable_charbuffer::
	push	bc
	push	de
	push	hl
	
	xor	a			; Reset timers
	ld	(__keyrepeattimer2), a
	ld	(__keyrepeattimer1), a
	ld	(__keyrepeating), a
	
	ld	a, #1
	ld	(__charbuffer_disable), a
	
	ld	hl, #__keyscanstates
	ld	de, #__keyscanstates + 1
	ld	bc, #0d151
	ldir
	
	pop	hl
	pop	de
	pop	bc
	ret
	
_enable_charbuffer::
	xor	a
	ld	(__charbuffer_disable), a
	ret

;------------------------------------------------------------------------------

handlekeyrepeat::
	ld	a, (__charbuffer_disable)
	or	a
	jr	z, 001$	

	ret
	
001$:	
	ld	hl, (_interrupt_counter)
	inc	hl
	ld	(_interrupt_counter), hl
	
	ld	a, (__keyrepeattimer2)
	inc	a
	ld	(__keyrepeattimer2), a
	
	ld	a, (__keyrepeattimer1)
	inc	a
	ld	(__keyrepeattimer1), a

	;---
	
	call	_fillcharbuffer
	
	;---
	
	ld	a, (__keyrepeating)		; check if key repeat is already happening
	or	a
	jr	nz, key_inrepeating
	
	ld	a, (__keyrepeattimer1)
	and	#0xE0				; if not, check if initial key delay > half a second
	jr	z, handlekeyrepeat_end
	
	ld	a, #1				; if so, enable key repeating
	ld	(__keyrepeating), a	

key_inrepeating:	
	ld	a, (__keyrepeattimer2)		; check if key repeat timer overflowed
	and	#0xFC
	jr	z, handlekeyrepeat_end
	
	xor	a				; reset repeat timer
	ld	(__keyrepeattimer2), a
	
	ld	a, (__lastkeypressed)		; get last keypress state
	ld	b, #0
	ld	c, a
	ld	hl, #__keyscanstates
	add	hl, bc
	ld	a, (hl)
	
	bit	0, a
	jr	z, handlekeyrepeat_end		; if key down, forget it
	
	set	1, a				; our own bit toggle to specify it's a repeat key
	ld	(mycharbuffer+1), a
	ld	a, (__lastkeypressed)
	ld	(mycharbuffer), a	
	
	call 	handlescancode	

handlekeyrepeat_end:
	ret


;------------------------------------------------------------------------------
;------------------------------------------------------------------------------

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
; NOTE: Used in v0.01 and 0.02.  Now replaced to use a buffer.
;
;------------------------------------------------------------------------------
;;_getchar::
;;keyagain:
;;	; wait till a key is available
;;	ld	de, #mycharbuffer
;;	push	de	
;;	call	getkeycodefrombuffer
;;	pop	de	
;;	jp	z, keyagain
;;	
;;	ld	a, (mycharbuffer+1)	; Got a scancode; check its state
;;	bit	0, a
;;	jp	z, keyagain		; if key released, we don't care, get another
;;	ld	a, (mycharbuffer)
;;	and	#0x0F			; save low nibble in b
;;	ld	b, a
;;	ld	a, (mycharbuffer)
;;	srl	a			; save high nibble in c
;;	srl	a
;;	srl	a
;;	srl	a
;;	ld	c, a	
;;	ld	h, #8			; hl = 8 * high nibble
;;	ld	e, c
;;	call multiply
;;	ld	a, b			; low nibble + (8 * high nibble)
;;	add	l
;;	ld	b, #0			; bc = position in scancode_table
;;	ld	c, a
;;	ld	hl, #scancode_table	; hl = scancode_table + offset (starting in lowercase codes)
;;	add	hl, bc	
;;	ld	a, (mycharbuffer+1)	; check if shift/capslock
;;	bit	6, a
;;	jr	nz, do_ascii_caps
;;	;bit	5, a			; actually don't check capslock for now, that only affects letters
;;	;jr	nz, get_ascii_caps
;;	jr	get_ascii_char		; no caps, so just get lowercase
;;do_ascii_caps:
;;	ld	bc, #0d80
;;	add	hl, bc	
;;get_ascii_char:	
;;	ld	a, (hl)
;;	or	a			; check if ascii = 0
;;	jr	z, print_scan_char
;;	cp	a, #0d255		; check if ascii = 255
;;	jr	z, print_scan_char
;;	ld	a, (hl)			; print ascii code
;;	jr	print_ascii_char
;;print_scan_char:
;;	jp	keyagain		; Let's not deal with extended keys for now
;;	;jr	checkbutton
;;	;ld	a, #0
;;	;ld	a, (mycharbuffer)	; otherwise load original scan code
;;	;ld	l, a
;;	;ret
;;print_ascii_char:
;;	ld	l, a			; Return ascii code
;;	ret
	





;------------------------------------------------------------------------------
; _pokecharbuffer
;
; Parameters: A = character to put into buffer
; Returns: L = 1 if successful, 0 if full
;
;------------------------------------------------------------------------------
_pokecharbuffer:
	push	bc
	push	iy
	
	push	af			; preserve incoming char
	
	ld	a, (__getcharbuffer_in)	
	inc	a
	and	#0d31
	ld	b, a
	ld	a, (__getcharbuffer_out)
	cp	a, b	
	jr	z, pokecharbuffer_full	; Buffer is full!  return
	
	ld	iy, #__getcharbuffer
	ld	a, (__getcharbuffer_in)
	ld	b, #0
	ld	c, a
	add	iy, bc			; IY now holds position in __getcharbuffer to poke char
	
	inc	a			; Increment charbuffer 'in' position
	and	#0d31
	ld	(__getcharbuffer_in), a
	
	pop	af			; restore incoming char	
	ld	(iy), a			; load into charbuffer
	
	ld	l, #1			; Return 1 since poked
	jr	pokecharbuffer_end

pokecharbuffer_full:	
	ld	l, #0			; Return 0 since fail
	pop	af	

pokecharbuffer_end:
	or	a
	pop	iy
	pop	bc
	ret


;-----------------------------------------------------------------------------


handlescancode::
	ld	a, (mycharbuffer+1)	; check if our special key repeat bit was toggled
	bit	1, a
	jr	nz, handlescancode_dorepeat
	
	
	xor	a			; Reset timer since key pressed
	ld	(__keyrepeattimer2), a
	ld	(__keyrepeattimer1), a
	ld	(__keyrepeating), a
	
	ld	hl, #__keyscanstates	; Save current keystate
	ld	b, #0
	ld	a, (mycharbuffer)
	ld	c, a
	add	hl, bc
	ld	a, (mycharbuffer+1)
	ld	(hl), a
	
	
handlescancode_dorepeat:
	;ld	a, (mycharbuffer+1)	; Got a scancode; check its state
	bit	0, a
	jp	z, handlescancode_end	; if key released, we don't care, get another
	ld	a, (mycharbuffer)
	
	ld	(__lastkeypressed), a	
	
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
	jr	z, poke_extended_char
	cp	a, #0d255		; check if ascii = 255
	jr	z, handlescancode_end	; don't deal with shifts/capslock/function keys, try again
	jr	poke_ascii_char		; otherwise, we have an ascii code. poke it.
poke_extended_char:
	xor	a
	call	_pokecharbuffer
	
	ld	a, (mycharbuffer)
	call	_pokecharbuffer
	
	ld	a, l
	or	a
	jr	nz, handlescancode_end	; if double character poke complete, get another
	
	ld	a, (__getcharbuffer_in)	; otherwise, forget that last character and exit
	dec	a			; NOTE: extended key gets totally dropped as a result
	and	#0d31
	ld	(__getcharbuffer_in), a
	
	jr	handlescancode_end
	jr	fillcharbuffer_end
	

poke_ascii_char:
	ld	a, (mycharbuffer+1)
	bit	5, a				; check for caps lock
	jr	z, poke_ascii_char_nocapslock

	ld	a, (hl)
	sub	#0d65				; check if key < 65
	jr	c, poke_ascii_char_nocapslock
	sub	#0d25				; check if 65 <= key <= 90 (uppercase)
	jr	c, poke_ascii_char_uppertolower
	sub	#0d7				; check if 91 <= key <= 96
	jr	c, poke_ascii_char_nocapslock
	sub	#0d25				; check if 97 <= key <= 122 (lowercase)
	jr	nc, poke_ascii_char_nocapslock	

	ld	a, (hl)			; make uppercase
	sub	#0d32
	call	_pokecharbuffer
	
	jr	handlescancode_end
	jp	scanagain		; Check for more
	
poke_ascii_char_uppertolower:
	ld	a, (hl)			; make lowercase
	add	#0d32
	call	_pokecharbuffer
	
	jr	handlescancode_end
	jp	scanagain		; Check for more

poke_ascii_char_nocapslock:
	ld	a, (hl)
	call	_pokecharbuffer
	
	jr	handlescancode_end
	jp	scanagain		; Check for more

handlescancode_end:
	ret


;------------------------------------------------------------------------------
; void fillcharbuffer()
;
; Parameters: none
; Returns: nothing
;
; Calls firmware's getkeycodefrombuffer, processes scancode based on key state
; and shift key's state.  If key currently pressed, it's translated into an 
; ascii character and pushed into the buffer.  If it's an extended key, a 0
; is pushed, followed by the key's scancode.  Repeats until getkeycodefrombuffer
; says scancode buffer is empty, or until ascii char buffer is full.
;
; NOTE: Function key is currently not processed.
;
;------------------------------------------------------------------------------
_fillcharbuffer::
	push	af
	push	bc
	push	de
	push	hl
	push	iy	

scanagain:
	ld	a, (__getcharbuffer_in)	
	inc	a
	and	#0d31
	ld	b, a
	ld	a, (__getcharbuffer_out)
	and	#0d31
	cp	a, b	
	
	; We stop doing this check for now since the key repeat runs away sometimes when exiting stuff
	jr	z, fillcharbuffer_end	; Buffer is full!  return
	
scanagain2:	
	ld	de, #mycharbuffer
	push	de	
	call	ms_getkeycodefrombuffer
	pop	de	
	jr	z, fillcharbuffer_end	; no keys left in scancode buffer, return

	call	handlescancode
	jr	scanagain

fillcharbuffer_end:
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret



;------------------------------------------------------------------------------
; char getchar()
;
; Parameters: none
; Returns: ASCII character code in 'l' register 
;
; Calls _fillcharbuffer to processes scancodes, then checks to see if any ascii
; chars are in the buffer.  If not, it loops till there is.
;
;------------------------------------------------------------------------------
_getchar::
	push	af
	push	bc
	push	iy
getchar_again:
	;call _fillcharbuffer
	
	ld	a, (__getcharbuffer_in)		; check if buffer is empty
	ld	b, a
	ld	a, (__getcharbuffer_out)
	cp	a, b
	jr	nz, getchar_gotchar		
	
	
	; REMOVED REPEAT CODE
	jr	getchar_again	
	
getchar_gotchar:
	ld	iy, #__getcharbuffer	
	ld	b, #0
	ld	c, a
	add	iy, bc			; IY now holds position in _getcharbuffer to peek char
	
	ld	a, (iy)			; Get ascii char
	ld	l, a
	
	ld	a, (__getcharbuffer_out)	; increment buffer 'out' position
	inc	a
	and	#0d31
	ld	(__getcharbuffer_out), a
	
	pop	iy
	pop	bc
	pop	af
	ret
	

;------------------------------------------------------------------------------
; int kbhit()
;
; Parameters: none
; Returns: 1 if there's a key waiting, 0 if not
;
; Calls _fillcharbuffer to process scancodes, then compares the ascii charbuffer's
; in and out positions to see if they match.  If so, buffer is empty, return 0.
; Otherwise, return 1.
;
;------------------------------------------------------------------------------
_kbhit::
	push	af
	push	bc
	ld	h, #0
	
	;call	_fillcharbuffer
	ld	a, (__getcharbuffer_in)
	ld	b, a
	ld	a, (__getcharbuffer_out)
	cp	a, b
	jr	z, kbhit_no
	ld	a, #1
	ld	l, a
	jr	kbhit_end	
kbhit_no:
	xor	a
	ld	l, a	
kbhit_end:
	pop	bc
	pop	af
	ret
	
