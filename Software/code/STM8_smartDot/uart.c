

#include "uart.h"

static uint8_t uartBuffer=0x0A;


void uart_init(void)
{
	//setup RX pin (PD5) as PP output
	PD_DDR |= GPIO_PIN5; 
    	PD_CR1 |= GPIO_PIN5;

	// set UBRR (f_master=2MHz internal_16MHz_RC div 8 -> UBRR=0xDO)
	UART1_BRR2 = 0;	// write UBRR2 first
	UART1_BRR1 = 0x0D;

	//TX enable + RX enable + RX interrupt
	UART1_CR2 = UART_CR2_TEN | UART_CR2_REN | UART_CR2_RIEN;

}

void uart_sendByte(uint8_t inByte)
{
	while(!(UART1_SR & UART_SR_TXE)); // wait until previous byte transmitted
	UART1_DR = inByte;
}

uint8_t uart_getBuffer(void)
{
	return uartBuffer;
}


INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
{
	uint8_t tempBuf;
	if(UART1_SR & UART_SR_RXNE) 		// if data received
	{ 
		tempBuf = UART1_DR; 		// read received byte & clear RXNE flag
		while(!(UART1_SR & UART_SR_TXE));
		UART1_DR = uartBuffer; 		//push out old buffer
		uartBuffer = tempBuf; 		// put received byte into buffer
	}
}
