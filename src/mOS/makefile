
INCLUDES = -I$(CURDIR)/../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
LDFLAGS = --no-std-crt0
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

MSLIB_DIR = $(CURDIR)/../mslib

.PHONY: all clean

all: mOS.bin

$(MSLIB_DIR)/%.lib:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

$(MSLIB_DIR)/%.rel:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

mOS.ihx: $(MSLIB_DIR)/crt0-baremetal.rel $(MSLIB_DIR)/mslib.lib mOS.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --data-loc 0xd410 $^ -o $@

clean:
	@$(MAKE) clean -C $(MSLIB_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm *.bin.h
