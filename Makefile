#Main application file name
MAIN_APP = ledblink
TARGET	= avr

# The microcontroller
MCU = atmega32
CLK = 16000000UL

# The name of the toolchain
CC	= clang
LINKER	= clang
OBJDUMP	= llvm-objdump
OBJCOPY	= llvm-objcopy
SIZE = llvm-size

# optimisation
OPTI = -O

# parameters
CFLAGS = $(OPTI) --target=$(TARGET) -mmcu=$(MCU) -DF_CPU=$(CLK)

LFLAGS = $(CFLAGS) -Wl,-Map,$(MAIN_APP).map

HFLAGS = -j .text -j .data -O ihex

# Source files needed for building the application 
SRC = $(MAIN_APP).c


build: $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	$(OBJDUMP) -h -S $< > $(MAIN_APP).lst
	$(SIZE) $<

$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS)  -o $@ $<

$(MAIN_APP).o: $(SRC)
	$(CC) $(CFLAGS)  -c $< -o $@
		
rebuild: clean build

clean:
	del *.o
	del *.map
	del *.elf	
	del *.hex
	del *.lst
