
CC = sdcc
CFLAGS = -mz80
LDFLAGS = --no-std-crt0 --code-loc 0x4000 --data-loc 0x4000
AS = sdasz80
ASFLAGS = -lso

# NOTE: sdcc has a gotcha that crt0.rel MUST be first file the command line
# if passing --no-std-crt0 during linking phase, if crt0.rel is used, be sure
# it is the first COMMON_OBJS. If that is not possible, then this makefile
# needs to be modified to adjust OBJS creation
COMMON_OBJS =
LOCAL_OBJS = loaderapp.rel


COMMON_DIR = $(CURDIR)/../../common/
COMMON_OBJS := $(addprefix $(COMMON_DIR), $(COMMON_OBJS))

OBJS = $(COMMON_OBJS) $(LOCAL_OBJS)

all: loaderapp.bin

$(COMMON_OBJS):
	@$(MAKE) $(notdir $@) -C $(COMMON_DIR)

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@
	@echo "\nWrite the following bytes to the Mailstation App location\n"
	@hexdump -e '8/1 "%02x " "  "  8/1 "%02x " "\n"' loaderapp.bin
	@echo ""

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.s
	$(AS) $(ASFLAGS) $<

%.ihx: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

# Clean the COMMON_DIR only if there are COMMON_OBJS used here
clean:
	@$(if $(strip $(COMMON_OBJS)), @$(MAKE) clean -C $(COMMON_DIR),)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm
