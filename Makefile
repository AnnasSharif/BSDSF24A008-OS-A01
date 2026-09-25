# Root Makefile - BSDSF24A008-OS-A01
# Feature 3: Static Library Build

CC       = gcc
CFLAGS   = -Wall -Wextra
AR       = ar
ARFLAGS  = rcs
RANLIB   = ranlib

BINDIR   = bin
OBJDIR   = obj
SRCDIR   = src
LIBDIR   = lib

STATIC_LIB = $(LIBDIR)/libmyutils.a
TARGET     = $(BINDIR)/client_static

LIB_OBJS   = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
MAIN_OBJ   = $(OBJDIR)/main.o

.PHONY: all compile_src clean

all: compile_src $(STATIC_LIB) $(TARGET)

compile_src:
	$(MAKE) -C $(SRCDIR)

# Rule to build static library using ar and ranlib
$(STATIC_LIB): $(LIB_OBJS)
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

# Rule to link client_static executable against static library (-Llib -lmyutils)
$(TARGET): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET) $(STATIC_LIB)
