# Mailsend utility
The `mailsend` tool is two parts, the Mailstation side and a host PC side. This folder contains both parts, but what is here still needs some cleanup.

The `mailsend` tools is used to send data (including larger applications) from a host PC to the Mailstation through the parallel port. A `Laplink` compatible cable is required for this operation. See the [wiki documentation](https://github.com/kbembedded/mailstation/wiki/Loading-Data-on-to-the-Mailstation) for more detailed information.

## Loader
The mailstation side uses `MS Loader` as provided by the `loader-stage2` binary. This is intended to supersede the original `Loader` application made by the community a long time ago.

The loader is set up in three stages, stage 0, is the `LDR` app which is similar to the original `Loader` but has been reduced in size to ease manual entry. Stage 1 is an intermediate loader, its sole purpose is to relocate the stage 2 loader to a different address and jump to it. Since stage 0 always loads and runs to 0x8000 and stage 2 is meant to run from 0x4000, stage 1 has stage 2 appended to it and is designed to relocate stage 2 elsewhere in RAM, map that page to slot4, and then jump to it. Stage 2 is the actual `MS Loader`, is interactive and is currently able to load and run other binaries from the parallel port that built with an org of 0x4000 or 0x8000. It is itself built with an org of 0x4000 so it can be written as-is to dataflash and run as a normal application. See the aforementioned wiki documentation for detailed installation instructions.

Communication between a PC and the Mailstation is a full-duplex link with handshaking. This results in 3-bit wide data between the two devices, dubbed "tribbles" of data.

### Build
Run `make` from this directory.

`loader-stage0.bin` is the stage 0 binary that when written to dataflash will make an application named `LDR`. See the wiki for information on this. Building this will also output the necessary bytes to write to the terminal for ease of use.

`loader-stage1.bin` is the stage 1 binary with the stage 2 binary directly appended to it. Load and run this if the Mailstation has only the stage 0 loader, `LDR`; or if the Mailstation is using the orignal `Loader` application. 

`loader-stage2.bin` is the stage 2 binary. Uploading and running this from 0x4000 will give the option to self-update the current stage 2 loader in dataflash. Generally, you won't use this binary directly unless you want to update the stage 2 `MS Loader` already in dataflash.

Note that at this time, this loader is hard-coded to self-write to the dataflash App 0 location. This will be expanded in the future.

## Mailsend
The `mailsend` tool is the PC side to send data directly to any of the existing Mailstation loaders, `Loader`, `LDR`, or `MS Loader`.

Currently, the sources have not been compiled in a very long time. In this folder is a Windows executable, what is probably the source code to it, and a Windows DLL (it is a 64-bit DLL) for parallel port communication. The executable has been tested and confirmed on a 64-bit Windows 7 machine.
