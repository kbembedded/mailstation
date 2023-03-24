; vim:syntax=z8a
;
; SPDX-License-Identifier: BSD-2-Clause
; Copyright (c) 2020 KBEmbedded
;
; A Mailstation app intended to be run from the dataflash app context
; This means it needs an app header and expects to be run from 0x4000

; This loader app is based around the Mailstation app used in spew.s by
; Cyrano Jones.
;
; This code is designed to be as small as possible as it needs to be
; manually entered via the built-in hex editor inside the Mailstation
; diagnostic menu.
;
; The code below receives first a 16-bit value of the total number of
; bytes to follow. The first byte sent is the LSB. After that, this will
; recieve the specified number of bytes which are written directly to
; RAM page 1 which is set in to slot8000. Once the number of bytes is
; transferred, this app will jump to the start of slot8000
;
; Originally written by FyberOptic

	.module Loader
	.area	_CODE
	.area	_DATA
	.globl	_start

	; The following function is called from codeflash page 1, attempts to
	; receive a byte from the parallel port. Upon return, if a = 0, then
	; a timeout or other failure occurred. Otherwise, the received byte is
	; placed in the l register.
	brecvbyte = 0x8027

_start:
	jp	eventhandler		; Jump to the start of our code.

	.dw	(icon)
	.dw	(caption)
	.dw	(unknown_value)

; XXX Might be able to drop unknown value and just put caption there directly?

; Normally, this section would have some values needed for app setup, however
; since we're trying to save bytes and we don't use this information anyway,
; we don't really care.
unknown_value:

caption:
	.dw	#0x0001			; Unknown meaning
	.dw	endcap-caption-6	; Calculate caption length
	.dw	#0x0006			; Offset to first character
	.ascii	"LDR"			; The caption string
endcap:

icon:

;----------------------------------------------------------
; Now for the actual code
;----------------------------------------------------------

getbyte:
	push	de

	xor	a		; Put codeflash page 1 into slot8000.
	out	(#0x08), a
	inc	a
	out	(#0x07), a

getbyte2:
	call	brecvbyte	; Try to fetch a byte.
	or	a		; If we didn't get one, try again.
	jr	z, getbyte2

	pop	de
	ret

; The first two bytes sent are the total number of bytes the loader should recv
; before jumping in to execution. The low order byte is sent first, then the
; high order byte. These are saved in to the BC reg which is used as a counter
; for LDI operations later. DE is loaded with the destination address, 0x8000
eventhandler:
	call	getbyte		; Returns byte of data in L
	ld	c, l

	call	getbyte		; Returns byte of data in L
	ld	b, l

	ld	de, #0x8000

; This function will repeatedly run until we have received all of the expected
; bytes from the host. On each loop:
; A byte is received from the parallel port
; Said byte is pushed to the stack
; HL is given the SP value (see inline comments for the magic of this)
; LDI standard pattern is used to copy byte, inc DE and dec BC.
;   Using LDI is smaller than manaully copying bytes and incrementing locations
; POP our value off the stack to keep the stack balanced.
; Check overflow (POP has no effect), loop until LDI overflows BC
nextcodebyte:
	call	getbyte		; Returns byte of data in L

	push	hl		; Save HL to stack

	; Note to myself for later. It might be slightly more compact to move
	; L in to A, then move A in to (DE), inc DE, dec BC and then check for
	; overflow. Would remove push, pop, xor, sbc, add, ldi, but would then
	; add back ld a with 1, out would stay, ld a, l, ld (DE), a, inc de,
	; dec bc. Might not be a net gain but it could reduce the complexity here?
	; These three opcodes are smaller than clearing HL, loading it with SP,
	; and then later loading A with 0x1 to switch the slot8000 device.
	; PUSH loads high-order byte first. That means after PUSH of HL earlier,
	; SP points to the value of L, which is the byte we read from parallel.
	xor	a		; Clear A reg and the C flag
	sbc	hl, hl		; Subtract HL-HL-C flag == 0
	add	hl, sp		; HL now points to old L on the stack

	; Set RAM page 1 in slot8000. Page 1 already set in P7, reused from
	; CF page 1 set above; so we just need to set RAM to device slot
	inc	a
	out	(#0x08), a

	ldi			; LD (HL) == (SP) to (DE) == dest addr, dec BC
	pop	hl		; Pop HL reg back off the stack, we don't care
				; about it anymore, can be thrown away

	jp	pe, nextcodebyte

	jp	0x8000		; When done, jump to code!
