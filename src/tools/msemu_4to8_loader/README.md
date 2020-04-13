# MSEMU 4to8 loader

A simple stub of a program designed for use with the msemu tool in lieu of parallel port loading. Since msemu doesn't support parallel port at this time, this tool is a bit of a workaround to add emulated support of the stage 0 loader.

`meemu_4to8_loader` is assembled with an org of 0x4000 and is meant to have another binary appended to it. `msemu_4to8_loader` is then run as a dataflash application, the appended binary is loaded in to RAM page 1, set in to slot8, and then is blindly executed. This is similar to the behavior of the stage 0 loader, but can all be done from the emulated dataflash.bin in msemu.

## Use

Note that this requires dataflash.bin set up to run an app from 0x0000, aka dataflash page 0, address 0. See the [Mailstation wiki](https://github.com/kbembedded/mailstation/wiki/Loading-Data-on-to-the-Mailstation) for information on how to set this up. Note that its possible to run `msemu_4to8_loader` from any app location, but the easiest way is to have it be the first application. Otherwise, the resulting binary will need to be placed somewhere in the middle of the dataflash.bin which results in a more complex dd command.

```
make
cat /path/to/other.bin >> msemu_4to8_loader.bin
dd if=msemu_4to8_loader.bin of=/path/to/msemu/dataflash.bin conv=notrunc
```

This can all be accomplished in a single line:

`make bin=/path/to/other.bin df_out=/path/to/msemu/dataflash.bin`

This will clean, rebuild, append the desired binary, and write it to the dataflash.bin file specified.
Note that this will always write to offset 0 of the dataflash. This might not be what you want, but in most cases it will be.

It is also possible to build the loader with the binary appended to it, this is useful if the resulting binary needs to be written to a custom location in dataflash.

`make bin=/path/to/other.bin`

This will output `msemu_4to8_loader-app.bin` with the loader and the binary appended together.


# Bugs

I doubt its a bug of this application, but in running "checksum" there is some garbage printed with the first line. The checksum values are off. In running FyOS v0.02 it IDs firmware 2.53 as 2.83 for some reason. That is also likely a fault of msemu and has nothing to do with this
