
#include "stm8l.h"	// stm8l.h found here: https://github.com/eddyem/STM8_samples



typedef unsigned char uint8_t;

void uart_init();
void uart_sendByte(uint8_t inByte);
INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18);
uint8_t uart_getBuffer(void);
//uint8_t uart_getByte(void);


