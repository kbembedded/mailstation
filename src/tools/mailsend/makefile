
INCLUDES = -I$(CURDIR)/../../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
LDFLAGS = --no-std-crt0
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

MSLIB_DIR = $(CURDIR)/../../mslib

all: loader-stage2.bin loader-stage1.bin loader-stage0.bin

$(MSLIB_DIR)/%.lib:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

$(MSLIB_DIR)/%.rel:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

loader-stage2.bin: loader-stage2.ihx
	objcopy -Iihex -Obinary $< $@

loader-stage1.bin: loader-stage2.bin loader-stage1.ihx
	objcopy -Iihex -Obinary loader-stage1.ihx loader-stage1.bin
	cat loader-stage2.bin >> loader-stage1.bin

loader-stage0.bin: loader-stage0.ihx
	objcopy -Iihex -Obinary $< $@
	@echo "\nWrite the following bytes to the Mailstation App location"
	@hexdump -e '8/1 "%02x " "  "  8/1 "%02x " "\n"' loader-stage0.bin
	@echo ""

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

loader-stage2.ihx: $(MSLIB_DIR)/crt0-slot4.rel $(MSLIB_DIR)/mslib.lib loader-stage2.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x401A --data-loc 0xF000 $^ -o $@

loader-stage1.ihx: crt0-loader-stage1.rel loader-stage1.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x8016 --data-loc 0xF000 $^ -o $@

loader-stage0.ihx: loader-stage0.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x4000 --data-loc 0x4000 $< -o $@

# Clean the COMMON_DIR only if there are COMMON_OBJS used here
clean:
	@$(MAKE) clean -C $(MSLIB_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
