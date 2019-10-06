	.module	blinkled
	; This functions in an infinite loop, just changing the LED state once
	; every second. A helper function from ROM is used to accomplish this.

	; Once this runs, its basically stuck here. There is a way to return to
	; the Mailstation main OS as seen in other, official apps, but how this
	; is accomplished is not yet known.


	.area	_CODE
	.area	_DATA
	.globl	_main

	; Two functions from Mailstation codeflash ROM are required, a delay
	; and the set LED function. Both of these take an argument that has
	; been pushed on to the stack prior to calling.

	; Delay time is in milliseconds(?), value pushed on to the stack.
	delay = 0x0A5C
	; LED value is 0 or 1, value pushed on to the stack.
	setled = 0x0A77

_main:
	ld	de, #0h0000

loop:

	; Every loop, XOR e against 0x01 and push on to stack
	ld	a, e
	xor	#0x01
	ld	e, a
	push	de
	call	setled
	pop	de

	; Delay for roughly 1 s
	ld	hl, #0d1000
	push	hl
	call	delay
	pop	hl

	jr	loop
