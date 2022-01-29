
CC = sdcc
CFLAGS = -mz80
LDFLAGS = --no-std-crt0 --code-loc 0x8000 --data-loc 0x0000
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

.PHONY: all clean

all: bloader.bin FyOS-v01.bin

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

bloader.ihx: bloader.rel
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

FyOS-v01.ihx: crt0b.rel mailstation.rel fyos_c.rel
	$(CC) $(CFLAGS) --no-std-crt0 --code-loc 0xc010 --data-loc 0x0000 $^ -o $@

%.ihx: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
