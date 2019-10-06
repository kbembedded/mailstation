	.module	loader
	.area	_DATA
	.area	_CODE

	.globl	_main

_main:
	jp	copyfrom4000to8000

	.dw	(icon)
        .dw 	(caption)
        .dw	(unknown_value)

unknown_value:
	.db	#00

; These values are used to shift the interior screen location in official
; Mailstation app frameworks
xpos:
	.dw	#0000
ypos:
	.dw	#0000

caption:
        .dw 	#0001			; Unknown meaning
        .dw	endcap-caption-6	; Calculate caption length
        .dw	#0006			; Offset to first character
        .ascii	"4to8load"		; The caption string
endcap:

icon:

copyfrom4000to8000:
	; The main loading for this is accomplished with ldir auto-looping
	; de reg is the destination, hl is the source, and bc is the number
	; of bytes to shovel from the source to the destination.
	ld	de, #0x8000	; Destination address
	ld	hl, #binstart	; Source address
	ld	bc, #0x4000 - (binstart - _main)

	ld	a, #1		; Load RAM page 1 in to slot8000
	out	(#08),a
	out	(#07),a

	ldir
	jp	0x8000


binstart:
