# src/Makefile - Compiles source files to objects recursively

CC       = gcc
CFLAGS   = -Wall -Wextra
OBJDIR   = ../obj
INCDIR   = ../include

SOURCES  = mystrfunctions.c myfilefunctions.c main.c
OBJECTS  = $(patsubst %.c,$(OBJDIR)/%.o,$(SOURCES))

.PHONY: all clean

all: $(OBJECTS)

$(OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) -I$(INCDIR) -c $< -o $@

clean:
	rm -f $(OBJDIR)/*.o
