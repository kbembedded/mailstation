;const unsigned char bsyin = 0x40;
;const unsigned char bsyout = 0x08;
;const unsigned char stbin = 0x80;
;const unsigned char stbout = 0x10;
;const unsigned char tribmask = 0x07;
;const unsigned char dibmask = 0x03;

;sfr at 0x21 port_printerstatus;
;sfr at 0x2d port_printerdata;

	.area	_BSS
_tribble_timer_var:
	.ds 1


	.area	_CODE
;--------------------------------------------------------------------

_tribble_timer:
		ld      hl, (_tribble_timer_var)
		or      a			; also resets Carry flag for SBC later
		jr      z, #tribble_timer2
		ld      de, #0xd6d8
		jr      #tribble_timer3
tribble_timer2:
		ld      de, #0xa7f8
tribble_timer3:
		push    hl
		sbc     hl, de
		pop     hl
		jr      c, #tribble_timer4
		ld      a, #0x01
		ret	
tribble_timer4:
		ld      a, #0x00
		inc     hl
		ld      (_tribble_timer_var),hl
		ret

;--------------------------------------------------------------------


_recv_tribble:
		ld      hl,#0000
		ld      (_tribble_timer_var),hl
recv_tribble_wait_stbin:
		xor     a
		call    _tribble_timer		; tribble_timer()
		or      a
		jr      z,recv_tribble2
recv_tribble_exit:
		ld      l,#0x00
		ld      a,#0x00
		jr	recv_tribble_exitasm

recv_tribble2:
		in      a,(0x21)		; status port
		bit     7,a			; wait for 0x10 from PC data port
		jr      z,recv_tribble_wait_stbin         ;  wait for stbin (busy flag on)
		srl     a
		srl     a
		srl     a
		and     #0x07			; tribmask
		ld      l,a			; hold tribble
		ld      a,#0x08			; 
		out     (0x2d),a		; data port
recv_tribble3:
		push    hl
		xor     a
		call    _tribble_timer		; tribble_timer()
		or      a
		pop     hl
		jr      nz,recv_tribble_exit
		in      a,(0x21)
		bit     7,a
		jr      nz,recv_tribble3	; wait for stbin off (busy flag off)
		xor     a
		out     (0x2d),a		; data port
		ld      a,#0x01

recv_tribble_exitasm:
		ret

;--------------------------------------------------------------------


;int recv_byte(char *charpointer)
;volatile char retvalue = 0;	
_recv_byte::
		push	ix
		ld	ix, #0
		add	ix, sp
		
		push	bc
		push	de
		
		call    _recv_tribble		; recv_tribble()
		or      a
		jr      nz,recv_byte2		; return if error getting tribble
recv_byte_end:
		ld      a,#0x00
		jr	recv_byte_exitasm
recv_byte2:
		push    hl			; save first tribble
		call    _recv_tribble		; recv_tribble()
		or      a
		ld      a,l
		pop     hl			; retrieve first tribble
		jr      z,recv_byte_end         ; return if error getting tribble
		sla     a			; tribble2 << 3
		sla     a
		sla     a				
		add     a,l				
		ld      l,a			; l = tribble1 + tribble2
		push    hl
		call    _recv_tribble		; recv_tribble()
		or      a
		ld      a,l
		pop     hl
		jr      z,recv_byte_end         ; return if error getting tribble
		rrca    			; tribble3 << 6
		rrca    
		and     #0xc0			; upper two bits of tribble3 only
		add     a,l
		ld      l,a
		ld      a,#0x01
recv_byte_exitasm:
		push	af			; preserve return value
		
		ld	b, l			; preserve character	
		ld	l, 4(ix)		; get *charpointer
		ld	h, 5(ix)
		
		ld	a, b			; restore character
		ld	(hl), a			; set *charpointer
		
		pop	af			; restore return value		
		ld	l, a
		
		xor     a			; Disable all signals on data port
		out     (0x2d),a		; 
		ld	h, a			; clear top half of return value
		
		pop	de
		pop	bc
		pop	ix	
		ret


;--------------------------------------------------------------------
;void send_tribble() _naked
_send_tribble:
		ld      hl, #0000
		ld      (_tribble_timer_var), hl
		ld      c, a
send_tribble3:	
		ld      a, #0x01
		call    _tribble_timer			; tribble_timer()
		or      a
		jr      z, send_tribble2
send_tribble_retfail:
		ld      a, #00
		ret     

send_tribble2:
		in      a,(0x21)			; status port
		bit     6,a
		jr      nz, send_tribble3
		ld      a,c
		and     #0x07				; mask just three bits (a tribble)
		or      #0x10				; lowers bit 7 on pc
		set	3, a				; FYBER - raise bit 6 on pc
		out     (0x2d),a			; tribble & tribmask | stbout
send_tribble4:
		ld      a, #0x01
		call    _tribble_timer			; tribble_timer()
		or      a
		jr      nz, send_tribble_retfail
		in      a, (0x21)			
		bit     6,a				; check for bsyout (0x08) from PC
		jr      z, send_tribble4
		ld      a, #0x08
		out     (0x2d),a
		ld      a, #0x01
		ret     


;--------------------------------------------------------------------
;int send_byte() _naked
_send_byte:
		push	bc
		push	de		; used in tribble timer
		ld      b, #0x03
send_byte2:
		ld      a, h
		push    hl
		call    _send_tribble
		or      a
		pop     hl
		jr      z, send_byte_fail
		srl     h
		srl     h
		srl     h
		djnz    send_byte2
		ld      hl, #0001
		jr	send_byte_done		
send_byte_fail:
		ld      hl, #0000
send_byte_done:
		pop	de
		pop	bc
		ret


;--------------------------------------------------------------------
;int send_byte_busy(char sendchar)
_send_byte_busy::
	push	ix
	ld	ix, #0
	add	ix, sp
	
	push	af
	
	;ld	l, 5(ix)		; get sendchar
	ld	h, 4(ix)
	;ld	a, (hl)
	;ld	h, a
		
	ld      a,#0x08			; bsyout
	out     (0x2d),a		; to printer data port
	call    _send_byte		

	xor	a			; clear data port
	out     (0x2d),a
		
	pop	af
	pop	ix	
	ret				; return value gotten by _send_byte



; a = char, hl = response
_send_byte_busy_reg::
	push	af
	
	ld	h, a
			
	ld      a,#0x08			; bsyout
	out     (0x2d),a		; to printer data port
	call    _send_byte		

	xor	a			; clear data port
	out     (0x2d),a
		
	pop	af
	ret				; return value gotten by _send_byte


