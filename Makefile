# Root Makefile - BSDSF24A008-OS-A01
# Feature 4: Static and Dynamic Library Build

CC          = gcc
CFLAGS      = -Wall -Wextra -fPIC
AR          = ar
ARFLAGS     = rcs
RANLIB      = ranlib

BINDIR      = bin
OBJDIR      = obj
SRCDIR      = src
LIBDIR      = lib

STATIC_LIB  = $(LIBDIR)/libmyutils.a
DYNAMIC_LIB = $(LIBDIR)/libmyutils.so

TARGET_STATIC  = $(BINDIR)/client_static
TARGET_DYNAMIC = $(BINDIR)/client_dynamic

LIB_OBJS    = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
MAIN_OBJ    = $(OBJDIR)/main.o

.PHONY: all compile_src clean

all: compile_src $(STATIC_LIB) $(DYNAMIC_LIB) $(TARGET_STATIC) $(TARGET_DYNAMIC)

compile_src:
	$(MAKE) -C $(SRCDIR)

# Static Library Rule (.a)
$(STATIC_LIB): $(LIB_OBJS)
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

# Dynamic Library Rule (.so) using -shared
$(DYNAMIC_LIB): $(LIB_OBJS)
	$(CC) -shared -o $@ $^

# Static Executable Rule
$(TARGET_STATIC): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils

# Dynamic Executable Rule
$(TARGET_DYNAMIC): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET_STATIC) $(TARGET_DYNAMIC) $(STATIC_LIB) $(DYNAMIC_LIB)
