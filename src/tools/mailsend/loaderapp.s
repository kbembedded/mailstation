	; SPDX-License-Identifier: BSD-2-Clause

	.module Loader
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

unknown_value:
	.db	#0x00

; These values are used to shift the interior screen location in official
; Mailstation app frameworks
xpos:
	.dw	#0x0000
ypos:
	.dw	#0x0000

caption:
	.dw	#0x0001			; Unknown meaning
	.dw	endcap-caption-6	; Calculate caption length
	.dw	#0x0006			; Offset to first character
	.ascii	"Loader"		; The caption string
endcap:

icon:

;----------------------------------------------------------
; Now for the actual code
;----------------------------------------------------------

getbyte:
	push	bc		; Preserve BC, HL
	push	hl

	xor	a		; Put codeflash page 1 into slot8000.
	out	(#0x08), a
	inc	a
	out	(#0x07), a

getbyte2:
	call	brecvbyte	; Try to fetch a byte.
	or	a		; If we didn't get one, try again.
	jp	z, getbyte2

	ld	a, l		; Load received byte into A register

	pop	hl		; Restore BC, HL
	pop	bc
	ret

eventhandler:

	call	getbyte		; Get low byte of total bytes to download
	ld	l, a

	call	getbyte		; Get high byte of total bytes to download
	ld	h, a

	ld	bc, #0x8000	; Destination address

nextcodebyte:
	call	getbyte		; Fetch a byte of data

	ld	d, a		; Preserve A

	ld	a, #1		; Put ram page 1 into slot8000
	out	(#0x08), a
	out	(#0x07), a

	ld	a, d		; Restore A

	ld	(bc), a		; Load incoming byte to ram.
	inc	bc		; Inc ram location.

	dec	hl		; Dec bytes to be received.

	xor	a		; Check if hl = 0; get another byte if not
	or	h
	jp	nz, nextcodebyte
	xor	a
	or	l
	jp	nz, nextcodebyte

	jp	0x8000		; When done, jump to code!
