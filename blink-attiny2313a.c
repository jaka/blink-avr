#include <avr/io.h>
#include <util/delay.h>

int main(void) {

  DDRD = _BV(PD4);
  PORTD = 0;

  for (;;) {
    _delay_ms(10);
    PORTD ^= _BV(PD4);
  }

  return(0);
}
