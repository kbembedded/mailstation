
CC = sdcc
CFLAGS = -mz80 --no-std-crt0 --code-loc 0x4000 --data-loc 0x4000
AS = sdasz80
ASFLAGS = -lso

all: clean msemu_4to8_loader.bin append_bin write_df

append_bin: msemu_4to8_loader.bin
ifdef bin
	cat $< $(bin)  > msemu_4to8_loader-app.bin
endif

write_df: append_bin
ifdef df_out
	@echo Writing application to start of dataflash
	dd if=msemu_4to8_loader-app.bin of=$(df_out) conv=notrunc
endif

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.ihx: %.rel
	$(CC) $(CFLAGS) $< -o $@

%.rel: %.s
	$(AS) $(ASFLAGS) $<

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map
