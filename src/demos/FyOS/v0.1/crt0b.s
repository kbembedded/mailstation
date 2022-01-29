	;; FyOS crt0b.s for Z80
        ;; Dependent on bios in memory

	.include "bios.inc"
        
        
        .module crt0b
       	.globl	_main

;------------------------------------------------------------------------------
; Initialization code
;------------------------------------------------------------------------------

	.area	_HEADER (ABS)
	.org 	0xc000

	call    gsinit		; Initialize global variables	
	ei
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
        .area	_FILLER (ABS)
        .org 0xe3ff
        .db	0      
        


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


;------------------------------------------------------------------------------




;------------------------------------------------------------------------------
; This area is where code gets inserted automatically to inialize variables.
;------------------------------------------------------------------------------
        
        .area   _GSINIT        
gsinit::
        .area   _GSFINAL
        ret


;------------------------------------------------------------------------------
; Some variables we'll need.
;------------------------------------------------------------------------------
	
	.area	_BSS
	
