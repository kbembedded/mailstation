; vim:syntax=z8a
;
; SPDX-License-Identifier: BSD-2-Clause
; Copyright (c) 2020 KBEmbedded
;
; Generalized crt0.s for Mailstation Apps running from slot8
;
; Based on SDCC z80 crt0.s and other Mailstation contributions


	.module crt0
	.globl	_main

	.area	_HEADER (ABS)

	; Mailstation loader will put binary data starting at 0x8000, any tools
	; compiled against this crt0 will be set up for that.
	.org	0x8000
init:
	; Set stack pointer directly above top of memory.
	; Observations show this is pretty safe.
	ld	sp,#0x0000

	; preserve old slot4000 for later
	in	a, (#06)
	ld	(startup_slot4000device), a
	in	a, (#05)
	ld	(startup_slot4000page), a

	; Initialise global variables
	call	gsinit
	call	_main
	jp	_exit

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL
	.area	_AFTERCODE

	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG

	.area   _BSS
	; Variables to save the currently mapped slot4 page, restore at exit
	; and re-launch the loader since slot8 Apps should only be called
	; from the loader
	startup_slot4000device:
		.ds	1
	startup_slot4000page:
		.ds	1

	.area   _HEAP

	.area   _CODE

; Unsure what clock does, but leave it in place in case it is called
__clock::
	ret

_exit::
	; Exiting from mailstation app should jump back to the loader. Restore
	; the original page to slot4000 and jump back to that.
        ; restore slot4000, jump to app
	ld	a, (startup_slot4000device)
	out	(#06),a
	ld	a, (startup_slot4000page)
	out	(#05),a
	jp	0x4000

	; XXX: For some reason, sdcc 3.8.0 wants to put _GSINIT in data-loc.
	; I've tried re-arranging sections, setting (CON) to all GSINIT
	; areas, etc. For now, just letting this fall in to _CODE does
	; what we want it to.
	;.area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	;.area   _GSFINAL
	ret

	.area	_AFTERCODE
_end_of_file::
