
INCLUDES = -I$(CURDIR)/../../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
LDFLAGS = --no-std-crt0
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

MSLIB_DIR = $(CURDIR)/../../mslib

all: hello_world.bin test.bin

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

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

# It seems like dataflash apps always are called with the context of RAMp02
# always being in Slot8000
%.ihx: $(MSLIB_DIR)/crt0-app.rel $(MSLIB_DIR)/mslib.lib %.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x401A --data-loc 0x8000 $^ -o $@

clean:
	@$(MAKE) clean -C $(MSLIB_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
