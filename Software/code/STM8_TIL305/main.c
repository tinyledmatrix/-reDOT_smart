/* 
small code to controll one TIL305 with STM8S103F3

Pinmapping:

 COL:	1/	2/	3/	4/	5/
	PD2	PD3	PD4	PA3	PD1
ROW:
1 / PC3	X	X	X	X	X
2 / PB5	X	X	X	X	X
3 / PB4 X	X	X	X	X
4 / PC4	X	X	X	X	X
5 / PC5	X	X	X	X	X
6 / PC6	X	X	X	X	X
7 / PC7	X	X	X	X	X
	
*/


#include "stm8l.h"	// stm8l.h found here: https://github.com/eddyem/STM8_samples
#include "font5x7.h"

#define COLS_PORTD_MASK 0x1E 	// mask for cols on port D D1:D4
#define COLS_PORTA_MASK 0x08	// mask for cols on port A A3
#define ROWS_PORTB_MASK 0x30	// mask for rows on port B B4:B5
#define ROWS_PORTC_MASK 0xF8	// mask for rows on port C C3:C7

#define ROW1_MASK 0x01
#define ROW2_MASK 0x02
#define ROW3_MASK 0x04
#define ROW4_7MASK 0x78	

#define ROW4_MASK 0x08
#define ROW5_MASK 0x10
#define ROW6_MASK 0x20
#define ROW7_MASK 0x40

char testString[13] ={'H',' ','e',' ','l',' ','l',' ','o',' ','!',' ',' '};

const unsigned char colBitMask[5] = {(1<<2), (1<<3), (1<<4), (1<<3), (1<<1)};

volatile unsigned char colCounter = 0;
volatile unsigned char rowCounter = 0;
volatile unsigned char greyScaleCOunter =0;

volatile char readyFlag=0;




//volatile unsigned char displayBuffer[5];//={0, 0xff, 0xff,0,0} ;

#define numberOfCols 5
#define numberOfRows 7
volatile unsigned char dispBuffer[numberOfCols][numberOfRows]=
{{7, 5, 3, 1, 0, 3, 0},
 {7, 5, 3, 1, 0, 4, 0},
 {7, 5, 3, 1, 0, 5, 0},
 {7, 5, 3, 1, 0, 4, 0},
 {7, 5, 3, 1, 0, 3, 0}}; 

char myChar=0;

void reDot_displayASCII(char index, unsigned char background, unsigned char charGreyScale)
{
	unsigned char displayBuffer[numberOfCols];
	unsigned char Lcol, Lrow;

	index-=32;
	if (index>96) // if ascii>127
        	return;
	
    displayBuffer[0]=Font5x7[index][0];
    displayBuffer[1]=Font5x7[index][1];
    displayBuffer[2]=Font5x7[index][2];
    displayBuffer[3]=Font5x7[index][3];
    displayBuffer[4]=Font5x7[index][4];  
	
	for(Lcol=0; Lcol<numberOfCols; Lcol++)
	{
		for (Lrow=0; Lrow<numberOfRows; Lrow++)
		{
			if (displayBuffer[Lcol]&(1<<Lrow))
				dispBuffer[Lcol][Lrow]=charGreyScale;
			else
				dispBuffer[Lcol][Lrow]=background;
		}
	}
	
}  

// Timer1 Update/Overflow/Trigger/Break Interrupt
INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11){
	if(TIM1_SR1 & TIM_SR1_UIF)
	{ 
		
		
		PB_ODR |= ROWS_PORTB_MASK;    // set all rows to high = off 
		PC_ODR |= ROWS_PORTC_MASK;

		PD_ODR &= ~COLS_PORTD_MASK;	// cols off
		//PA_ODR &= ~COLS_PORTA_MASK;
		PA_ODR = 0;
		
		
		if (dispBuffer[colCounter][rowCounter-1]>greyScaleCOunter)
		{
			switch (rowCounter)		
			{
				case 1: PC_ODR = ~((ROW1_MASK)<<3); break;
				case 2: PB_ODR = ~((ROW2_MASK)<<4); break;
				case 3: PB_ODR = ~((ROW3_MASK)<<2); break;
				case 4: PC_ODR = ~((ROW4_MASK)<<1); break;
				case 5: PC_ODR = ~((ROW5_MASK)<<1); break;
				case 6: PC_ODR = ~((ROW6_MASK)<<1); break;
				case 7: PC_ODR = ~((ROW7_MASK)<<1); break;
			}
		}
		

		if (colCounter==3)
		{	
			PA_ODR |= colBitMask[colCounter];
		}
		else
		{
			PD_ODR |= colBitMask[colCounter];
		}

		
		greyScaleCOunter++;
		if (greyScaleCOunter==7)
		{
			greyScaleCOunter=0;
			rowCounter++;
			if (rowCounter>7) 
			{
				rowCounter=1;
				colCounter++;
				readyFlag=1;
				if (colCounter>4) colCounter=0;
			}
		}	
	}
	TIM1_SR1 = 0; // clear all interrupt flags
}


void cheap_delay(void)
{
	unsigned char a,b;
	for (a=0; a<60; a++)
	{	
		for (b=0; b<255; b++);
		nop();
		nop();
	}
}

int main (void)
{
	PD_DDR = COLS_PORTD_MASK;	//set all cols to push-pull output 
	PA_DDR = COLS_PORTA_MASK;
	PD_CR1 = COLS_PORTD_MASK;
	PA_CR1 = COLS_PORTA_MASK;

	PB_DDR = ROWS_PORTB_MASK;    // set all row to (true) open drain outputs 
	PC_DDR = ROWS_PORTC_MASK;
	PB_ODR = ROWS_PORTB_MASK;    // set all rows to high = off 
	PC_ODR = ROWS_PORTC_MASK;

	TIM1_ARRH = 0x00;
	TIM1_ARRL = 0x1F;

	TIM1_IER = TIM_IER_UIE; // interrupts: update
	TIM1_CR1 = TIM_CR1_APRE | TIM_CR1_URS | TIM_CR1_CEN; // auto-reload + interrupt on overflow + enable

	enableInterrupts();


	reDot_displayASCII('o',1,7);
	while(1)
	{}
	/*{
		cheap_delay();
		myChar++;
		if (myChar>7) myChar=0;
		reDot_displayASCII(128,1,myChar);
	}*/
	/*{
		//if (readyFlag)
		{
			readyFlag=0;
			reDot_displayASCII(testString[myChar],1,7);
        		if (myChar>=12)
				myChar=0;
			else
				myChar++;
		}
		//cheap_delay();
		//cheap_delay();
		cheap_delay();
	}*/
}
