#Main application file name
MAIN_APP = ledblink
TARGET	= avr

# The microcontroller
MCU = atmega328p

# The location of the AVR-LIBC headers
AVR_LIBC_HEADERS = C:\avr-gcc\avr\include\

# The name of the toolchain
CC	= clang
LLC = llc
MC  = llvm-mc
LINKER	= clang
OBJDUMP	= llvm-objdump
OBJCOPY	= llvm-objcopy

# parameters
CFLAGS = -g -O --target=$(TARGET) -mmcu=$(MCU) -isystem $(AVR_LIBC_HEADERS) -c -S -emit-llvm

LLCFLAGS = -filetype=asm -march=$(TARGET) -mcpu=$(MCU)

MCFLAGS = -filetype=obj -arch=$(TARGET) -mcpu=$(MCU)

LFLAGS = -g -O -mmcu=$(MCU) -isystem $(AVR_LIBC_HEADERS) -Wl,-Map=$(MAIN_APP).map -o

HFLAGS = -j .text -j .data -O ihex

# Sources files needed for building the application 
SRC = $(MAIN_APP).c


build: $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	$(OBJDUMP) -h -S $< > $(MAIN_APP).lst

$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS) $@ $(SRC)

$(MAIN_APP).o: $(MAIN_APP).s
	$(MC) $(MCFLAGS) $< -o $@
	
$(MAIN_APP).s: $(MAIN_APP).ll
	$(LLC) $(LLCFLAGS) $< -o $@

$(MAIN_APP).ll:$(SRC)
	$(CC) $(CFLAGS) $< -o $@
	
rebuild: clean build

clean:
	del *.ll
	del *.s
	del *.o
	del *.map
	del *.elf	
	del *.hex
	del *.lst
