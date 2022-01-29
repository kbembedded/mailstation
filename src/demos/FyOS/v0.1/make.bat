copy ..\bios\bios.inc

as-z80 -ls -o crt0b.o crt0b.s
@if ERRORLEVEL 1 goto end

@rem as-z80 -ls -o putcharb.o putcharb.s
@if ERRORLEVEL 1 goto end

@rem as-z80 -ls -o getcharb.o getcharb.s
@if ERRORLEVEL 1 goto end

sdcc -mz80 -c fyos_c.c
@if ERRORLEVEL 1 goto end

sdcc -mz80  --no-std-crt0  --code-loc 0xc010 --data-loc 0x0000 crt0b.o ..\mailstation.o fyos_c.o -o fyosb_bin
@if ERRORLEVEL 1 goto end

@rem link-z80 -f fyos_bin.lnk

..\hex2bin fyosb_bin.ihx

..\dz80 /m=49152 FYOSB_~1.BIN > fyosb_bin.lst

copy /b fyosb_bin.bin + ..\bios\bios_bin.bin fyos_final.bin

:end
