as-z80 -ls -o crt0.o crt0.s
@if ERRORLEVEL 1 goto end

as-z80 -ls -o putchar.o putchar.s
@if ERRORLEVEL 1 goto end

as-z80 -ls -o getchar.o getchar.s
@if ERRORLEVEL 1 goto end

as-z80 -ls -o graphicslcd.o graphicslcd.s
@if ERRORLEVEL 1 goto end

as-z80 -ls -o ms_plink.o ms_plink.s
@if ERRORLEVEL 1 goto end

sdcc -mz80 -c mailstation.c
@if ERRORLEVEL 1 goto end


@rem NOTE: SDCC uses ar and asranlib for libraries now.
@rem We'll use older sdcclib tool.

sdcclib mslib.lib putchar.o
sdcclib mslib.lib getchar.o
sdcclib mslib.lib graphicslcd.o
sdcclib mslib.lib ms_plink.o
sdcclib mslib.lib mailstation.o


sdcc -mz80 -c fyos_c.c
@if ERRORLEVEL 1 goto end

@rem sdcc -mz80 -c testapp.c
@rem @if ERRORLEVEL 1 goto end

@rem --nostdlib
@rem ./putchar.o ./getchar.o ./mailstation.o
sdcc -mz80  --no-std-crt0  --code-loc 0x8100 --data-loc 0x0000 -l mslib.lib ./crt0.o ./fyos_c.o -o fyos_bin
@if ERRORLEVEL 1 goto end

@rem link-z80 -f fyos_bin.lnk

hex2bin fyos_bin.ihx

dz80 /m=32768 fyos_bin.bin > fyos_bin.lst

:end
