#Main application file name
MAIN_APP = ledblink
TARGET	= avr

# The microcontroller
MCU = atmega328p
CLK = 16000000

# The location of the AVR-LIBC headers
AVR_LIBC_HEADERS = C:\avr-gcc\avr\include\

# The name of the toolchain
CC	= clang
LLC = llc
MC  = llvm-mc
LINKER	= avr-gcc
OBJDUMP	= llvm-objdump
OBJCOPY	= llvm-objcopy
SIZE = avr-size

# optimisation
OPTI = O

# parameters
CFLAGS = -$(OPTI) --target=$(TARGET) -mmcu=$(MCU) -DF_CPU=$(CLK)


LFLAGS = -$(OPTI) -mmcu=$(MCU) -DF_CPU=$(CLK) -Wl,-Map=$(MAIN_APP).map

HFLAGS = -j .text -j .data -O ihex

# Sources files needed for building the application 
SRC = $(MAIN_APP).c


build: $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	$(OBJDUMP) -h -S $< > $(MAIN_APP).lst
	$(SIZE) $<

$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS) -o $@ $<

$(MAIN_APP).o: $(SRC)
	$(CC) $(CFLAGS) -isystem $(AVR_LIBC_HEADERS) -c $< -o $@
		
rebuild: clean build

clean:
	del *.o
	del *.map
	del *.elf	
	del *.hex
	del *.lst
