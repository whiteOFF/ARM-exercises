#include "LPC17xx.h"
#include "led.h"


void led4and11_on(void) {
	LPC_GPIO2 -> FIOSET |= 0x81;
}

void led4_off(void) {
	LPC_GPIO2 -> FIOCLR |= 0x80;
}

void ledevenon_oddoff(void) {
	LPC_GPIO2 -> FIOSET |= 0x55;
	LPC_GPIO2 -> FIOSET &= 0x55;	
	LPC_GPIO2 -> FIOCLR &= 0xAA;
}

void led_on(unsigned int n) {
	unsigned int pos = 1 << (11-n);
	LPC_GPIO2 -> FIOSET |= pos;
}

void led_off(unsigned int n) {
	unsigned int pos = 1 << (11-n);
	LPC_GPIO2 -> FIOCLR |= pos;
}