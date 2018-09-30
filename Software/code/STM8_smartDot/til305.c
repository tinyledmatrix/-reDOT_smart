/* 
small code to controll one TIL305 with STM8S103F3

Pinmapping:

 COL:	2/	1/	3/	4/	5/
	PD3	PD2	PD4	PA3	PD1
ROW:
1 / PB4	X	X	X	X	X
2 / PB5	X	X	X	X	X
3 / PC3 X	X	X	X	X
4 / PC4	X	X	X	X	X
5 / PC5	X	X	X	X	X
6 / PC6	X	X	X	X	X
7 / PC7	X	X	X	X	X
	
*/


#include "til305.h"
#include "font5x7.h"

#define COLS_PORTD_MASK 0x1E 	// mask for cols on port D D1:D4
#define COLS_PORTA_MASK 0x08	// mask for cols on port A A3
#define ROWS_PORTB_MASK 0x30	// mask for rows on port B B4:B5
#define ROWS_PORTC_MASK 0xF8	// mask for rows on port C C3:C7

const unsigned char colBitMask[5] = {(1<<2), (1<<3), (1<<4), (1<<3), (1<<1)};

volatile unsigned char colCounter;//=0;
volatile unsigned char displayBuffer[5];//={0, 0xff, 0xff,0,0} ;

char myChar='H';

void reDot_displayASCII(char index)
{
	index-=32;
	if (index>95) // if ascii>127
        	return;
     	displayBuffer[0]=Font5x7[index][0];
     	displayBuffer[1]=Font5x7[index][1];
     	displayBuffer[2]=Font5x7[index][2];
     	displayBuffer[3]=Font5x7[index][3];
     	displayBuffer[4]=Font5x7[index][4];  
}  

// Timer1 Update/Overflow/Trigger/Break Interrupt
INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11){
	if(TIM1_SR1 & TIM_SR1_UIF)
	{ 
		colCounter++;
		if (colCounter>4) colCounter=0;
		
		PB_ODR |= ROWS_PORTB_MASK;    // set all rows to high = off 
		PC_ODR |= ROWS_PORTC_MASK;

		PD_ODR &= ~COLS_PORTD_MASK;	// cols off
		//PA_ODR &= ~COLS_PORTA_MASK;
		PA_ODR = 0;

		//PB_ODR &= ~( (displayBuffer[colCounter] & 0x03)<<4);
		//PC_ODR &= ~( (displayBuffer[colCounter] & 0x7C)<<1); 
		PB_ODR = ~( (displayBuffer[colCounter] )<<4);
		PC_ODR = ~( (displayBuffer[colCounter] )<<1);
		

		if (colCounter==3)
		{	
			PA_ODR |= colBitMask[colCounter];
		}
		else
		{
			PD_ODR |= colBitMask[colCounter];
		}
	}
	TIM1_SR1 = 0; // clear all interrupt flags
}


void reDot_init (void)
{
	PD_DDR = COLS_PORTD_MASK;	//set all cols to push-pull output 
	PA_DDR = COLS_PORTA_MASK;
	PD_CR1 = COLS_PORTD_MASK;
	PA_CR1 = COLS_PORTA_MASK;

	PB_DDR = ROWS_PORTB_MASK;    	// set all row to (true) open drain outputs 
	PC_DDR = ROWS_PORTC_MASK;
	PB_ODR = ROWS_PORTB_MASK;    	// set all rows to high = off 
	PC_ODR = ROWS_PORTC_MASK;

	TIM1_ARRH = 0x01;
	TIM1_ARRL = 0xD0;

	TIM1_IER = TIM_IER_UIE; 	// interrupts: update
	TIM1_CR1 = TIM_CR1_APRE | TIM_CR1_URS | TIM_CR1_CEN; // auto-reload + interrupt on overflow + enable

}
