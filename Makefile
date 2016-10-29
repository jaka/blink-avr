#!/usr/bin/make -f

NAME	= attiny-blink
SRC	= blink-attiny2313a-int.c

MCU_FREQ	= 8000000UL
MCU_TARGET	= attiny2313a
PROGRAMMER_MCU	= t2313
PROGRAMMER	= usbasp

CC	= avr-gcc
OBJCOPY	= avr-objcopy

CFLAGS	+= -mmcu=$(MCU_TARGET) -Os -Wall -DF_CPU=$(MCU_FREQ)
LDFLAGS	+= -mmcu=$(MCU_TARGET)
LIBS	+=
OBJ	:= $(patsubst %.c,%.o,$(SRC))

all: $(NAME).hex

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(NAME).elf: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

clean:
	rm -f $(OBJ)
	rm -f $(NAME).elf
	rm -f $(NAME).hex

flash: $(NAME).hex
	avrdude -c $(PROGRAMMER) -p $(PROGRAMMER_MCU) -B 5 -U flash:w:$(NAME).hex
