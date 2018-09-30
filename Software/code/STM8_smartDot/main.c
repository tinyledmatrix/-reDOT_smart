

#include "stm8l.h"	// stm8l.h found here: https://github.com/eddyem/STM8_samples
#include "uart.h"
#include "til305.h"


void main(void)
{
	unsigned char displayBuffer='A';
	unsigned char newChar='A';

	uart_init();
	reDot_init ();

	enableInterrupts();

	while(1)
	{
		//newChar=uart_getBuffer();

		if (newChar== displayBuffer)
			;
		else
		{
			displayBuffer = newChar;
			reDot_displayASCII(displayBuffer);
		}

		nop();
		nop();
		nop();
		nop();
	}
}



