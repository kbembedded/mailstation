sdasz80 -glso crt0.s
sdasz80 -lso putchar.s
sdasz80 -lso getchar.s
sdasz80 -lso graphicslcd.s
sdasz80 -lso ms_plink.s
sdcc -mz80 -c mailstation.c

sdcclib mslib.lib putchar.rel
sdcclib mslib.lib getchar.rel
sdcclib mslib.lib graphicslcd.rel
sdcclib mslib.lib ms_plink.rel
sdcclib mslib.lib mailstation.rel

sdcc -mz80 --no-std-crt0 -o FyOS-v021.ihx --code-loc 0x8100 --data-loc 0x0000 -l mslib.lib ./crt0.rel ./fyos_c.c

objcopy -Iihex -Obinary FyOS-v021.ihx FyOS-v021.bin
