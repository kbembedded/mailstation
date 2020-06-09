# Tools
Tools for development/testing/bootstrapping a Mailstation

Running `make` from this directory will build all buildable files in subdirectories.


## Structure
* `msloader/` - Contains Mailstation tools for loading applications to Mailstation via parallel port. See the `src/host/` directory for the PC side of the transfer process
* `msemu_4to8_loader/` - Handy tool for emulating stage 0 parallel port loading with [msemu](https://github.com/kbembedded/msemu) (see README in folder for more information)
