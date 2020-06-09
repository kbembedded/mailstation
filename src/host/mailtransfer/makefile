MINGW_WIN32=i686-w64-mingw32
CC=$(MINGW_WIN32)-gcc
STRIP=$(MINGW_WIN32)-strip

all: mailtransfer.exe

mailtransfer.exe: mailtransfer.c
	$(CC) -o $@ $<
	$(STRIP) $@

clean:
	rm *.exe
