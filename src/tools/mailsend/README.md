# Mailsend utility
The `mailsend` tool is two parts, the Mailstation side and a host PC side. This folder contains both parts, but what is here still needs some cleanup.

The `mailsend` and `Loader` pair are used to send data (including larger applications) from a host PC to the Mailstation through the parallel port. A `Laplink` compatible cable is required for this operation. See the [wiki documentation](https://github.com/kbembedded/mailstation/wiki/Loading-Data-on-to-the-Mailstation) for more detailed information.

Communication between a PC and the Mailstation is a full-duplex link with handshaking. This results in 3-bit wide data between the two devices, dubbed "tribbles" of data.


## Loader
The `Loader` app is the mailstation side. See the [wiki documentation](https://github.com/kbembedded/mailstation/wiki/Loading-Data-on-to-the-Mailstation) for a more thorough explanation of how to install and use this tool.

The `Loader` app is a Mailstation OS app. It always runs from `0x4000` no matter which dataflash page the app is located on. It sets RAM page 1 to slot8000, loads in the data to there, and then jumps to `0x8000`. Because of this, any apps loaded with this method need to be compiled to run with an origin of `0x8000`.


## Mailsend
The `mailsend` tool is the PC side to send data directly to the `Loader` app.

Currently, the sources have not been compiled in a very long time. In this folder is a Windows executable, what is probably the source code to it, and a Windows DLL (it is a 64-bit DLL) for parallel port communication. The executable has been tested and confirmed on a 64-bit Windows 7 machine.


## TODOs
* Create a "stage 2" loader app. This would be more full featured, better integrated in to the Mailstation OS, etc. This would overwrite the smaller app. Once this is done, the original loader app can be shrunk down even further
* Clean up and ensure mailsend can be compiled/run under modern OSs
* Re-create the `mailsend` app for Mailstation, this would allow one Mailstation to bootstrap another without the use of a PC in the middle (and would be a testbed for direct p2p communication).
