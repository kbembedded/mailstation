	;; FyOS crt0.s for Z80
        .module crt0
       	.globl	_main

;------------------------------------------------------------------------------
; Initialization code
;------------------------------------------------------------------------------

	.area	_HEADER (ABS)
	.org 	0x8000

	;; Stack at the top of memory.
	;ld	sp,#0xffff		; let's not change this for now	
	
	; preserve old slot4000 for later
	ld	a, (#06)
	ld	(startup_slot4000device), a
	ld	a, (#05)
	ld	(startup_slot4000page), a		

	; check version for setting shadow vars
	ld	a, #0
	ld	(_firmwareversionsafe), a	; safe for now
	ld	a, (#0x0037)
	cp	a, #02			; check major version for v2
	jr	z, version2checkminor
	cp	a, #03			; check major version for v3
	jr	z, version3checkminor
	jr	use_defaultversion2	; if neither major v2 or v3, who knows!  use v2.53
version2checkminor:
	ld	a, (#0x0036)
	cp	a, #0d53		; check for v2.53
	jr	z, use_version253
	cp	a, #0d54		; check for v2.54
	jr	z, use_version254
	nop				; else use v2.53 anyway for now			
use_defaultversion2:
	ld	a, #02
	ld	(_firmwareversionsafe), a	; not safe firmware in use
use_version253:
	ld	hl, #0xdba1		; set shadow vars 
	ld	(_p2shadow), hl
	ld	hl, #0xdba2
	ld	(_p3shadow), hl
	jr	versioncheckcomplete
use_version254:
	ld	hl, #0xdba2		; set shadow vars 
	ld	(_p2shadow), hl
	ld	hl, #0xdba3
	ld	(_p3shadow), hl
	jr	versioncheckcomplete
	
version3checkminor:
	ld	a, (#0x0036)
	cp	a, #0d3			; check for v3.03
	jr	z, use_version303
	nop				; else use v3.03 anyway for now	
use_defaultversion3:
	ld	a, #0d3
	ld	(_firmwareversionsafe), a	; not safe firmware in use
use_version303:
	ld	hl, #0xdba5		; set shadow vars 
	ld	(_p2shadow), hl
	ld	hl, #0xdba6
	ld	(_p3shadow), hl
	jr	versioncheckcomplete

versioncheckcomplete:	

	call    gsinit		; Initialize global variables	
	call	_main		; Run main C code	
	jp	_exit		; Do exit procedure


;------------------------------------------------------------------------------
; Ordering of segments for the linker.
;------------------------------------------------------------------------------

	.area	_HOME
	.area	_CODE
        .area   _GSINIT
        .area   _GSFINAL
        .area	_EXITPROC
        .area	_EXITPROCFINAL
	.area	_DATA
        .area   _BSS        
        .area   _HEAP
        ;.area	_CABS
        ;.area	_OVERLAY        
        


;------------------------------------------------------------------------------
; Some basic code segments:  __clock and _exit.
;
; No idea what __clock is, so we just return.
;
; _exit is run when your 'main' C function returns.
;------------------------------------------------------------------------------

        .area   _CODE

;------------------------------------------------------------------------------

__clock::
	;ld	a,#2
        ;rst     0x08
	ret

;------------------------------------------------------------------------------


	.area	_EXITPROC
_exit::		

	.area	_EXITPROCFINAL
	; restore slot4000, jump to app
	ld	a, (startup_slot4000device)
	ld	(#06),a
	ld	a, (startup_slot4000page)
	ld	(#05),a
	jp	0x4000

;------------------------------------------------------------------------------




;------------------------------------------------------------------------------
; This area is where code gets inserted automatically to inialize variables.
;------------------------------------------------------------------------------
        
        .area   _GSINIT        
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:
        .area   _GSFINAL
        ret


;------------------------------------------------------------------------------
; Some variables we'll need.
;------------------------------------------------------------------------------
	
	.area	_BSS
	
startup_slot4000device:
	.ds	1
startup_slot4000page:
	.ds	1
_p2shadow::
	.ds	2
_p3shadow::
	.ds	2
_firmwareversionsafe::
	.ds	1

