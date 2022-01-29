	
        .module bloader
        
        .area	_DATA
        .area	_CODE
         
	di
	
	;ld	hl, #endoffile
	;ld	de, #0xc000
	;ld	bc, #0x4000
	;ldir
	;jp	0xe400

	ld	hl, #endoffile
	ld	de, #0xe000
	ld	bc, #0x2000
	ldir
	
	jp	0xe000
	
        
        
endoffile:
