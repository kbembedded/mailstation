
CC = sdcc
CFLAGS = -mz80
LDFLAGS = --no-std-crt0 --code-loc 0x8100 --data-loc 0x0000
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

# NOTE: sdcc has a gotcha that crt0.rel MUST be first file the command line
# if passing --no-std-crt0 during linking phase
LOCAL_OBJS = crt0.rel getchar.rel putchar.rel fyos.rel mailstation.rel


OBJS = $(LOCAL_OBJS)

all: FyOS-v001.bin $(OBJS)

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

%.ihx: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
