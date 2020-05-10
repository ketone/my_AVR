//
#ifndef __AVR_ATmega328P__
#define __AVR_ATmega328P__
#endif

#ifndef F_CPU
# define F_CPU 16000000UL
#endif

#include <avr/io.h>
#include <util/delay.h>
int main(void)
{
    DDRC |= 1 << PINC5; //define the pin as output
    while (1)
    {
        _delay_ms(1000);     //execute delay 1s
 // __builtin_avr_delay_cycles (100);
        PORTC ^= 1 << PINC5; // toggle the outout pin
    }
    return 0;
}