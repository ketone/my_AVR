#Main application file name
MAIN_APP = ledblink
TARGET	= avr

# The microcontroller
TYPE = __AVR_ATmega328P__
MCU = atmega328p
CLK = 16000000

# The location of the AVR-LIBC headers
AVR_LIBC_HEADERS = C:\avr-gcc\avr\include\

# The location of the AVR root
AVR_ROOT = C:\avr-gcc\

# The name of the toolchain
CC	= clang
LINKER	= clang
OBJDUMP	= llvm-objdump
OBJCOPY	= llvm-objcopy
SIZE = llvm-size

# optimisation
OPTI = O

# parameters
CFLAGS = -$(OPTI) --target=$(TARGET) -mmcu=$(MCU) -D$(TYPE) -DF_CPU=$(CLK)

LFLAGS = $(CFLAGS) -Wl,-Map,$(MAIN_APP).map

HFLAGS = -j .text -j .data -O ihex

# Source files needed for building the application 
SRC = $(MAIN_APP).c


build: $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	$(OBJDUMP) -h -S $< > $(MAIN_APP).lst
	$(SIZE) $<

$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS) --sysroot=$(AVR_ROOT) -o $@ $<

$(MAIN_APP).o: $(SRC)
	$(CC) $(CFLAGS) -isystem $(AVR_LIBC_HEADERS) -c $< -o $@
		
rebuild: clean build

clean:
	del *.o
	del *.map
	del *.elf	
	del *.hex
	del *.lst
