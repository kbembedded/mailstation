
INCLUDES = -I$(CURDIR)/../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
AS = sdasz80
AR = sdar
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g


OBJS = dflash_write.rel graphics-textmode.rel lcd.rel parport.rel

all: mslib.lib crt0-slot4.rel crt0-app.rel

mslib.lib: $(OBJS)
	$(AR) -rc $@ $^

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s 
	$(AS) $(ASFLAGS_CRT0) $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm *.lib
