
CC = sdcc
CFLAGS = -mz80
LDFLAGS = --no-std-crt0 --code-loc 0x8100 --data-loc 0x0000
AS = sdasz80
ASFLAGS = -lso

# NOTE: sdcc has a gotcha that crt0.rel MUST be first file the command line
# if passing --no-std-crt0 during linking phase
COMMON_OBJS = crt0.rel getchar.rel putchar.rel
LOCAL_OBJS = fyos.rel mailstation.rel


COMMON_DIR = $(CURDIR)/../../common/
COMMON_OBJS := $(addprefix $(COMMON_DIR), $(COMMON_OBJS))

OBJS = $(COMMON_OBJS) $(LOCAL_OBJS)

all: FyOS-v0021.bin

$(COMMON_OBJS):
	@$(MAKE) $(notdir $@) -C $(COMMON_DIR)

%.bin: %.ihx
	objcopy -Iihex -Obinary $< $@

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.ihx: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $@

clean:
	@$(MAKE) clean -C $(COMMON_DIR)
	rm -f *.rel *.ihx *.bin *.lk *.sym *.lst *.noi *.map *.asm *.lib
