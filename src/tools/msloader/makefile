
INCLUDES = -I$(CURDIR)/../../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
LDFLAGS = --no-std-crt0
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

MSLIB_DIR = $(CURDIR)/../../mslib

.PHONY: all LDR.out clean

all: msloader.bin msloader-LDR.bin LDR.out

$(MSLIB_DIR)/%.lib:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

$(MSLIB_DIR)/%.rel:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

trampoline.bin LDR.bin: %.bin: %.ihx
	objcopy -Iihex -Obinary $< $@
	xxd -i $@ | sed -e 's/unsigned char/const uint8_t/' -e 's/unsigned int/const uint16_t/' > $@.h

msloader-LDR.bin: msloader.bin trampoline.bin
	cat trampoline.bin msloader.bin > msloader-LDR.bin

LDR.out: | LDR.bin
	@echo "\nWrite the following bytes to the Mailstation App location"
	@hexdump -e '8/1 "%02x " "  "  8/1 "%02x " "\n"' LDR.bin
	@echo ""

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.c
	$(CC) $(CFLAGS) -c $<


dump.rel: dump.c | trampoline.bin LDR.bin
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

msloader.ihx: $(MSLIB_DIR)/crt0-slot4.rel $(MSLIB_DIR)/mslib.lib msloader.rel save.rel dump.rel loadrun.rel parport_method.rel interface.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x401A --data-loc 0xF000 $^ -o $@

trampoline.ihx: crt0-msloader-LDR.rel trampoline.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x8016 --data-loc 0xF000 $^ -o $@

LDR.ihx: LDR.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x4000 --data-loc 0x4000 $< -o $@

clean:
	@$(MAKE) clean -C $(MSLIB_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm *.bin.h
