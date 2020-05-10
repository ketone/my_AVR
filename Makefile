#Main application file name
MAIN_APP = ledblink
TARGET	= avr
MCU	= atmega328p  
#Main hex file path in windows format
HEX_PATH	=

# Compiler and other Section
CC	= clang
LINKER	= clang
OBJCOPY = llvm-objcopy
PROGRAMMER	= avrdude

#Options for clang
CFLAGS = -Os --target=$(TARGET) -mmcu=$(MCU)

#Linking options for clang
LFLAGS = -Os --target=$(TARGET) -mmcu=$(MCU) -Wl,-Map=$(MAIN_APP).map -o
 
#Options for HEX file generation
HFLAGS = -j .text -j .data -O ihex



# Sources files needed for building the application 
SRC = $(MAIN_APP).c
SRC += 

# The headers files needed for building the application
INCLUDE = -I.
INCLUDE	+= -IC:\avr-gcc\avr\include

# commands Section

Build : $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	
$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS) $@ $(SRC) $(INCLUDE)
 
$(MAIN_APP).o:$(SRC)
	$(CC) $(CFLAGS) $^ $(INCLUDE) -o $@
	
clean:
	rm *.o
	rm *.elf
	rm *.hex