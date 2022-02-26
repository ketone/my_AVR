//
#ifndef __AVR_ATmega328P__
#define __AVR_ATmega328P__
#endif

#ifndef F_CPU
# define F_CPU 16000000UL
#endif

#define __DELAY_BACKWARD_COMPATIBLE__

#include <avr/io.h>
#include <util/delay.h>



int main(void)
{
   

    DDRD |= 1 << PIND7; //define the pin as output
    while (1)
    {
        _delay_ms(1000);     //execute delay 1s
 
        PORTD ^= 1 << PIND7; // toggle the outout pin

    }
    return 0;
}
