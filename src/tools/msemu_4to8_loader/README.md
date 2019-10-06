# MSEMU 4to8 loader

A simple stub of a program designed for use with the msemu tool in lieu of parallel port loading. Since msemu doesn't support the "Loader" app that is used to download programs from parallel port to RAM, this tool helps make that a little easier.

It is compiled with an org of 0x4000 and it designed to have a binary appended to it. That binary is blindly loaded to 0x8000, which is set up as RAM page 1, and then executed. This is similar to how Loader works but can all be done from the emulated dataflash.bin that is used by the msemu.

## Use

Note that it requires dataflash.bin set up to run an app from 0x0000, aka dataflash page 0, address 0. See other resources in this git for more info. FIXME: specify the location of said resources.

make
cat /path/to/other.bin >> msemu_4to8_loader.bin
dd if=msemu_4to8_loader.bin of=/path/to/msemu/dataflash.bin conv=notrunc


# Bugs

I doubt its a bug of this application, but in running "checksum" there is some garbage printed with the first line. The checksum values are off. In running FyOS v0.02 it IDs firmware 2.53 as 2.83 for some reason. That is also likely a fault of msemu and has nothing to do with this
