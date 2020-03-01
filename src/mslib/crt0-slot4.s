; vim:syntax=z8a
;
; SPDX-License-Identifier: BSD-2-Clause
; Copyright (c) 2020 KBEmbedded
;
; Generalized crt0.s for Mailstation Apps running from slot4
;
; Based on SDCC z80 crt0.s and other Mailstation contributions


	.module crt0
	.globl	_main

	.area	_HEADER (ABS)

	; Mailstation loader will put binary data starting at 0x4000, any tools
	; compiled against this crt0 will be set up for that.
	.org	0x4000

	jp init

	; When running an App/Channel from dataflash, there is a known header
	; that supports having an icon, name, and some other data. Looks for
	; global values in C that end up being the location of a struct with
	; the necessary data.
	;
	; Its not the cleanest, and compiles fail if these globals arn't
	; exported by something. But it works well enough and really only
	; needs to be done once per tool.
	.dw	(_app_icon)	; Start of the icon header
	.dw	(_app_name)	; Start of the App name header
	.dw	#0x0000		; Start of data header with unknown function
	.db	#0x00		; Byte of unknown meaning
	.dw	#0x0000		; X position adjustment of Channel/icon1
	.dw	#0x0000		; Y position adjustment of Channel/icon1

init:
	; Set stack pointer directly above top of memory.
	; Observations show this is pretty safe.
	ld	sp, #0x0000

	; Initialise global variables
	call	gsinit
	call	_main
	jp	_exit

	; Ordering of segments for the linker.

	; Note that _HOME will likely end up falling in slotC, in there are
	; a few areas of RAM we do not want to touch.
	;
	; Right now these are hacks to leave some specific RAM in place. e.g.
	; the P2/P3 shadow vars and some other things that are important to
	; not clobber
	.area	_HOME (ABS)
	.org	0xC000
	.blkb	0x10	; Unknown?
	.blkb	0x1400	; LCD Buffer

	.org	0xDB90
	.blkb	0x40

	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL

	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG

	.area   _BSS

	.area   _HEAP

	.area   _CODE

; Unsure what clock does, but leave it in place in case it is called
__clock::
	ret

; Upon exit of the app, just reboot the whole Mailstation
_exit::
	jp	0x0000

	; XXX: For some reason, sdcc 3.8.0 wants to put _GSINIT in data-loc.
	; I've tried re-arranging sections, setting (CON) to all GSINIT
	; areas, etc. For now, just letting this fall in to _CODE does
	; what we want it to.
	; .area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	; .area   _GSFINAL
	ret

