
	.module getchar

	.area _BSS

	.include "bios.inc"

;.globl mycharbuffer, __getcharbuffer, __getcharbuffer_ptr, __getcharbuffer_in, __getcharbuffer_out


;.globl ms_getkeycodefrombuffer


;.globl __keyscanstates

;.globl __lastkeypressed

;.globl __keyrepeattimer1, __keyrepeattimer2, __keyrepeating

;.globl __interrupt_table
		
;.globl _interrupt_counter


	
;------------------------------------------------------------------------------
; Initialize getchar buffer positions
;------------------------------------------------------------------------------
	.area   _GSINIT


;------------------------------------------------------------------------------
; scancode_table holds two tables of ascii characters which '_getchar' uses
; to determine which character to return, depending on the scancode pressed
; and the state of the shift key.
;------------------------------------------------------------------------------

	.area _DATA
;.globl scancode_table, __scancode_table


;------------------------------------------------------------------------------
;------------------------------------------------------------------------------	
	
	.area _CODE


;------------------------------------------------------------------------------

;.globl handlekeyrepeat, handlescancode, _fillcharbuffer

;.globl _pokecharbuffer, _kbhit


;_getchar::
	;ret
	
