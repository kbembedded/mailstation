; no$gmb format .sym file
; Generated automagically by ASxxxx linker V01.75 + NoICE + SDCC Feb 1999 (SDK 3.0.0)
; Area: .  .ABS.
	__interrupt_jump == #0xFDFD
	__interrupt_table == #0xFE00
; Area: _CODE
	__codestart == #0xE400
	_bios_start == #0xE403
	_interrupt_hook == #0xE455
	_UpdateCharLCD == #0xE5E7
	_ClearLCD == #0xE638
	_scrollscreen == #0xE68E
	_putchar == #0xE6E2
	_putchar_rr_s == #0xE6E2
	_putchar_rr_dbs == #0xE6EB
	_putcharXY == #0xE6F0
	printchar == #0xE771
	_LCD_CAS == #0xE815
	_updatecursor == #0xE834
	_disable_charbuffer == #0xE88F
	_enable_charbuffer == #0xE8B0
	handlekeyrepeat == #0xE8B5
	handlescancode == #0xE954
	_fillcharbuffer == #0xEA06
	_getchar == #0xEA31
	_kbhit == #0xEA5C
	ms_keyscan == #0xEA74
	ms_scan_keymatrix == #0xEB60
	ms_putkeyintobuffer == #0xECBE
	ms_getkeycodefrombuffer == #0xECE3
	ms_clearkeytables == #0xED1C
	ms_initkeybuffer == #0xED49
	ms_init_keyboard == #0xED57
	ms_fullkeyboardinit == #0xEDB2
	_recv_byte == #0xEE2D
	_send_byte_busy == #0xEEC9
; Area: _GSINIT
; Area: _GSFINAL
; Area: _DATA
	_p2shadow == #0xEF13
	_p3shadow == #0xEF15
	__scancode_table == #0xEFB7
; Area: _DATA_END
; Area: _BSS
	__p2shadow == #0xEFBB
	__p3shadow == #0xEFBC
	_firmwareversionsafe == #0xEFBD
	_cursorx == #0xEFBF
	_cursory == #0xEFC0
	_textmodebuffer == #0xEFC1
	_cgafont_addr == #0xF241
	mycharbuffer == #0xF246
	__getcharbuffer == #0xF248
	__getcharbuffer_ptr == #0xF248
	__getcharbuffer_in == #0xF268
	__getcharbuffer_out == #0xF269
	__charbuffer_disable == #0xF26A
	__keyscanstates == #0xF26B
	_interrupt_counter == #0xF307
; Area: _BSS_END
; Area: _CGAFONTDATA
	__cgafont_data == #0xF500