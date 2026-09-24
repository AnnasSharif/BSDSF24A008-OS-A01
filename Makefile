# Root Makefile - BSDSF24A008-OS-A01
# Recursive build approach

CC       = gcc
CFLAGS   = -Wall -Wextra
BINDIR   = bin
OBJDIR   = obj
SRCDIR   = src

TARGET   = $(BINDIR)/client
OBJECTS  = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o $(OBJDIR)/main.o

.PHONY: all compile_src clean

all: compile_src $(TARGET)

compile_src:
	$(MAKE) -C $(SRCDIR)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET)
