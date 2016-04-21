# optional CFLAGS include: -O -g -Wall
# -DNO_LARGE_SWITCH	compiler cannot handle really big switch statements
#			so break them into smaller pieces
# -DLITTLE_ENDIAN	machine's byte-sex is like x86 instead of 68k
# -DPOSIX_TTY		use Posix termios instead of older termio (FreeBSD)
# -DMEM_BREAK		support memory-mapped I/O and breakpoints,
#				which will noticably slow down emulation

CC = gcc
CFLAGS = -O2 -pipe -Wall -DPOSIX_TTY -DLITTLE_ENDIAN -DMEM_BREAK
LDFLAGS = 

FILES = README Makefile MacProj.hqx z80.proj A-Hdrive.gz	\
	cpmdisc.h defs.h	\
	cpm.c bios.c disassem.c main.c z80.c	\
	bye.mac getunix.mac putunix.mac	\
	makedisc.c

OBJS =	bios.o \
	disassem.o \
	main.o \
	z80.o

z80: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o z80 $(OBJS)

cpm:
	rm -f cpm
	ln -s z80 cpm

bios.o:		bios.c defs.h cpmdisc.h cpm.c
z80.o:		z80.c defs.h
disassem.o:	disassem.c defs.h
main.o:		main.c defs.h

clean:
	rm -f z80 cpm *.o

tags:	$(FILES)
	cxxtags *.[hc]

tar:
	tar -zcf z80.tgz $(FILES) p2dos zcpr1 zmac

files:
	@echo $(FILES)

difflist:
	@for f in $(FILES); do rcsdiff -q $$f >/dev/null || echo $$f; done
