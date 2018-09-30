
#ifndef _til305_h
#define _til305_h

	#include "stm8l.h"	// stm8l.h found here: https://github.com/eddyem/STM8_samples
	

	void reDot_displayASCII(char index);
	void reDot_init (void);

	INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11);


#endif
