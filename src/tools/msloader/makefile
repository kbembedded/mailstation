
INCLUDES = -I$(CURDIR)/../../include/
CC = sdcc
CFLAGS = $(INCLUDES) -mz80
LDFLAGS = --no-std-crt0
AS = sdasz80
ASFLAGS = -lso
ASFLAGS_CRT0 := $(ASFLAGS) -g

MSLIB_DIR = $(CURDIR)/../../mslib

all: msloader.bin msloader-LDR.bin LDR.bin

$(MSLIB_DIR)/%.lib:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

$(MSLIB_DIR)/%.rel:
	@$(MAKE) $(notdir $@) -C $(MSLIB_DIR)

msloader.bin: msloader.ihx
	objcopy -Iihex -Obinary $< $@

msloader-LDR.bin: msloader.bin msloader-LDR.ihx
	objcopy -Iihex -Obinary msloader-LDR.ihx msloader-LDR.bin
	cat msloader.bin >> msloader-LDR.bin

LDR.bin: LDR.ihx
	objcopy -Iihex -Obinary $< $@
	@echo "\nWrite the following bytes to the Mailstation App location"
	@hexdump -e '8/1 "%02x " "  "  8/1 "%02x " "\n"' LDR.bin
	@echo ""

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

# crt0 sources need to be assembled with -g
crt0%rel: crt0%s
	$(AS) $(ASFLAGS_CRT0) $<

msloader.ihx: $(MSLIB_DIR)/crt0-slot4.rel $(MSLIB_DIR)/mslib.lib msloader.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x401A --data-loc 0xF000 $^ -o $@

msloader-LDR.ihx: crt0-msloader-LDR.rel msloader-LDR.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x8016 --data-loc 0xF000 $^ -o $@

LDR.ihx: LDR.rel
	$(CC) $(CFLAGS) $(LDFLAGS) --code-loc 0x4000 --data-loc 0x4000 $< -o $@

clean:
	@$(MAKE) clean -C $(MSLIB_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
