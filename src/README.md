# Sources
Mixed sources for both Mailstation and host utilities

Running `make` from this directory will build all buildable files in subdirectories.


## Structure
* `common/` - Contains common ASM and C sources useful in other areas
* `demos/` - Contains misc demos, samples, and other standalone things
* `FyOS/` - Contains separate folders for different versions of FyOS, a custom command interpreter for the Mailstation
* `tools/` - Contains tools useful for development/testing/bootstrapping a Mailstation
* `makefile.tmpl` - A template of a fairly generic makefile that can be used readily for new projects added here
