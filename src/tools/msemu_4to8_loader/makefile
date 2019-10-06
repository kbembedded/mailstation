
CC = sdcc
CFLAGS = -mz80 --no-std-crt0 --code-loc 0x4000 --data-loc 0x4000
AS = sdasz80
ASFLAGS = -lso

all: clean msemu_4to8_loader.bin

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.ihx: %.rel
	$(CC) $(CFLAGS) $< -o $@

%.rel: %.s
	$(AS) $(ASFLAGS) $<

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map
