
CC = sdcc
CFLAGS = -mz80
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g


OBJS = $(patsubst %.s,%.rel,$(wildcard *.s)) $(patsubst %.c,%.rel,$(wildcard *.c))

all: $(OBJS)

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s 
	$(AS) $(ASFLAGS_CRT0) $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map
