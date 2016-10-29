#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>

volatile uint8_t count;

ISR (TIMER0_OVF_vect) {

  count++;
  if ( count == 4 ) {
    PORTD ^= _BV(PD4);
    count = 0;
  }

}

void setup(void) {

    TCCR0B = _BV(CS02);
    TCNT0 = 0;
    TIMSK = _BV(TOIE0);

    PORTD = 0;
    DDRD = _BV(PD4);

    sei();
}

int main(void) {

  count = 0;
  setup();

  for (;;) {
    set_sleep_mode(SLEEP_MODE_IDLE);
    sleep_enable();
    sleep_mode();
    sleep_disable();
  }

  return(0);
}
