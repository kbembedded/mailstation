# Loading data on the Mailstation
There are two parts to sending and receiving data, the Mailstation side and a host PC side. This folder contains the Mailstation side while the host PC side can be found in `src/host/mailtransfer/`.

The `mailtransfer` tools is used to send data (including larger applications) from a host PC to the Mailstation through the parallel port. A `Laplink` compatible cable is required for this operation. See the [wiki documentation](https://github.com/kbembedded/mailstation/wiki/Loading-Data-on-to-the-Mailstation) for more detailed information.

## Loader
The mailstation side uses `MS Loader` as provided by the `msloader` binary. This is intended to supersede the original `Loader` application made by the community a long time ago.

The loader is set up in three stages, stage 0, is the `LDR` app which is similar to the original `Loader` but has been reduced in size to ease manual entry. Stage 1, `msloader-LDR` is an intermediate loader, its sole purpose is to relocate the stage 2 loader to a different address and jump to it. Since stage 0 always loads and runs to 0x8000 and stage 2 is meant to run from 0x4000, stage 1 has stage 2 appended to it and is designed to relocate stage 2 elsewhere in RAM, map that page to slot4, and then jump to it. Stage 2 is the actual `MS Loader`, is interactive and is currently able to load and run other binaries from the parallel port that built with an org of 0x4000 or 0x8000. It is itself built with an org of 0x4000 so it can be written as-is to dataflash and run as a normal application. See the aforementioned wiki documentation for detailed installation instructions.

Communication between a PC and the Mailstation is a full-duplex link with handshaking. This results in 3-bit wide data between the two devices, dubbed "tribbles" of data.

The `MS Loader` application can perform a number of tasks. It can load to RAM and execute a binary with an org of 0x4000 or 0x8000. Reboot the Mailstation (this currently works but has an odd side effect of the Mailstation thinking it crashed and running a checkdisk basically). Power off the mailstation. Enter a free-type mode to demo text input. And finally it can dump either the Codeflash or Dataflash in its entirety to a host PC. See the `src/host/mailtransfer` utility for more information on sending data from the Mailstation to a PC.

### Build
Run `make` from this directory.

`LDR.bin` is the stage 0 binary that when written to dataflash will make an application named `LDR`. See the wiki for information on this. Building this will also output the necessary bytes to write to the terminal for ease of use.

`msloader-LDR.bin` is the stage 1 binary with the stage 2 binary directly appended to it. Load and run this if the Mailstation has only the stage 0 loader, `LDR`; or if the Mailstation is using the orignal `Loader` application.

`msloader.bin` is the stage 2 binary. Uploading and running this from 0x4000 will give the option to self-update the current stage 2 loader in dataflash. Generally, you won't use this binary directly unless you want to update the stage 2 `MS Loader` already in dataflash.

Note that at this time, this loader is hard-coded to self-write to the dataflash App 0 location. This will be expanded in the future.

