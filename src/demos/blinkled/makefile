
CC = sdcc
CFLAGS = -mz80
LDFLAGS = --no-std-crt0 --code-loc 0x8000 --data-loc 0x8000
AS = sdasz80
ASFLAGS = -lso

all: blinkled.bin

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.s
	$(AS) $(ASFLAGS) $<

%.ihx: %.rel
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
