# Root Makefile - BSDSF24A008-OS-A01
# Feature 5: Man Pages & Installation

CC          = gcc
CFLAGS      = -Wall -Wextra -fPIC
AR          = ar
ARFLAGS     = rcs
RANLIB      = ranlib

BINDIR      = bin
OBJDIR      = obj
SRCDIR      = src
LIBDIR      = lib
MANDIR      = man/man3

PREFIX      = /usr/local
BIN_INSTALL = $(PREFIX)/bin
LIB_INSTALL = $(PREFIX)/lib
MAN_INSTALL = $(PREFIX)/share/man/man3

STATIC_LIB  = $(LIBDIR)/libmyutils.a
DYNAMIC_LIB = $(LIBDIR)/libmyutils.so

TARGET_STATIC  = $(BINDIR)/client_static
TARGET_DYNAMIC = $(BINDIR)/client_dynamic
TARGET_CLIENT  = $(BINDIR)/client

LIB_OBJS    = $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
MAIN_OBJ    = $(OBJDIR)/main.o

.PHONY: all compile_src clean install uninstall

all: compile_src $(STATIC_LIB) $(DYNAMIC_LIB) $(TARGET_STATIC) $(TARGET_DYNAMIC) $(TARGET_CLIENT)

compile_src:
	$(MAKE) -C $(SRCDIR)

# Static Library Rule (.a)
$(STATIC_LIB): $(LIB_OBJS)
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

# Dynamic Library Rule (.so)
$(DYNAMIC_LIB): $(LIB_OBJS)
	$(CC) -shared -o $@ $^

# Direct client rule
$(TARGET_CLIENT): $(MAIN_OBJ) $(LIB_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Static Executable Rule
$(TARGET_STATIC): $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils

# Dynamic Executable Rule
$(TARGET_DYNAMIC): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) -L$(LIBDIR) -lmyutils

# Install target (Task 3 & 4 of Feature 5)
install: all
	@echo "Installing client binary to $(BIN_INSTALL)..."
	mkdir -p $(BIN_INSTALL)
	cp -f $(TARGET_STATIC) $(BIN_INSTALL)/client
	chmod 755 $(BIN_INSTALL)/client
	@echo "Installing man pages to $(MAN_INSTALL)..."
	mkdir -p $(MAN_INSTALL)
	cp -f $(MANDIR)/*.3 $(MAN_INSTALL)/
	chmod 644 $(MAN_INSTALL)/*.3
	@echo "===== Installation Complete! ====="
	@echo "You can now run 'client' from anywhere and access man pages with 'man mystrlen'."

# Uninstall target
uninstall:
	rm -f $(BIN_INSTALL)/client
	rm -f $(MAN_INSTALL)/mystrlen.3 $(MAN_INSTALL)/mystrcpy.3 $(MAN_INSTALL)/mystrncpy.3 $(MAN_INSTALL)/mystrcat.3 $(MAN_INSTALL)/wordCount.3 $(MAN_INSTALL)/mygrep.3
	@echo "===== Uninstalled successfully! ====="

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET_STATIC) $(TARGET_DYNAMIC) $(TARGET_CLIENT) $(STATIC_LIB) $(DYNAMIC_LIB)
