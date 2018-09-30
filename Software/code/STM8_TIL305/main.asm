;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Mar 24 2016) (Linux)
; This file was generated Sun Feb  4 20:40:40 2018
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _colBitMask
	.globl _Font5x7
	.globl _main
	.globl _cheap_delay
	.globl _TIM1_UPD_OVF_TRG_BRK_IRQHandler
	.globl _reDot_displayASCII
	.globl _myChar
	.globl _dispBuffer
	.globl _readyFlag
	.globl _greyScaleCOunter
	.globl _rowCounter
	.globl _colCounter
	.globl _testString
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_testString::
	.ds 13
_colCounter::
	.ds 1
_rowCounter::
	.ds 1
_greyScaleCOunter::
	.ds 1
_readyFlag::
	.ds 1
_dispBuffer::
	.ds 35
_myChar::
	.ds 1
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ;reset
	int 0x0000 ;trap
	int 0x0000 ;int0
	int 0x0000 ;int1
	int 0x0000 ;int2
	int 0x0000 ;int3
	int 0x0000 ;int4
	int 0x0000 ;int5
	int 0x0000 ;int6
	int 0x0000 ;int7
	int 0x0000 ;int8
	int 0x0000 ;int9
	int 0x0000 ;int10
	int _TIM1_UPD_OVF_TRG_BRK_IRQHandler ;int11
	int 0x0000 ;int12
	int 0x0000 ;int13
	int 0x0000 ;int14
	int 0x0000 ;int15
	int 0x0000 ;int16
	int 0x0000 ;int17
	int 0x0000 ;int18
	int 0x0000 ;int19
	int 0x0000 ;int20
	int 0x0000 ;int21
	int 0x0000 ;int22
	int 0x0000 ;int23
	int 0x0000 ;int24
	int 0x0000 ;int25
	int 0x0000 ;int26
	int 0x0000 ;int27
	int 0x0000 ;int28
	int 0x0000 ;int29
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 64: void reDot_displayASCII(char index, unsigned char background, unsigned char charGreyScale)
;	-----------------------------------------
;	 function reDot_displayASCII
;	-----------------------------------------
_reDot_displayASCII:
	sub	sp, #25
;	main.c: 69: index-=32;
	ld	a, (0x1c, sp)
	sub	a, #0x20
	ld	(0x1c, sp), a
;	main.c: 70: if (index>96) // if ascii>127
	ld	a, (0x1c, sp)
	cp	a, #0x60
	jrsle	00102$
;	main.c: 71: return;
	jp	00112$
00102$:
;	main.c: 73: displayBuffer[0]=Font5x7[index][0];
	ldw	x, sp
	addw	x, #3
	ldw	(0x08, sp), x
	ldw	x, #_Font5x7+0
	ldw	(0x12, sp), x
	push	#0x05
	ld	a, (0x1d, sp)
	push	a
	call	__muluschar
	addw	sp, #2
	addw	x, (0x12, sp)
	ldw	(0x10, sp), x
	ldw	x, (0x10, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ld	(x), a
;	main.c: 74: displayBuffer[1]=Font5x7[index][1];
	ldw	x, (0x08, sp)
	incw	x
	ldw	y, (0x10, sp)
	ld	a, (0x1, y)
	ld	(x), a
;	main.c: 75: displayBuffer[2]=Font5x7[index][2];
	ldw	x, (0x08, sp)
	incw	x
	incw	x
	ldw	y, (0x10, sp)
	ld	a, (0x2, y)
	ld	(x), a
;	main.c: 76: displayBuffer[3]=Font5x7[index][3];
	ldw	x, (0x08, sp)
	addw	x, #0x0003
	ldw	y, (0x10, sp)
	ld	a, (0x3, y)
	ld	(x), a
;	main.c: 77: displayBuffer[4]=Font5x7[index][4];  
	ldw	x, (0x08, sp)
	addw	x, #0x0004
	ldw	y, (0x10, sp)
	ld	a, (0x4, y)
	ld	(x), a
;	main.c: 79: for(Lcol=0; Lcol<numberOfCols; Lcol++)
	clr	(0x02, sp)
	clrw	x
	ldw	(0x0e, sp), x
	clrw	x
	ldw	(0x0c, sp), x
;	main.c: 81: for (Lrow=0; Lrow<numberOfRows; Lrow++)
00116$:
	clrw	x
	ld	a, (0x02, sp)
	ld	xl, a
	addw	x, (0x08, sp)
	ldw	(0x0a, sp), x
	clr	(0x01, sp)
00108$:
;	main.c: 83: if (displayBuffer[Lcol]&(1<<Lrow))
	ldw	x, (0x0a, sp)
	ld	a, (x)
	push	a
	ldw	x, #0x0001
	ld	a, (0x02, sp)
	jreq	00138$
00137$:
	sllw	x
	dec	a
	jrne	00137$
00138$:
	pop	a
	ld	(0x19, sp), a
	clr	(0x18, sp)
	ld	a, xl
	and	a, (0x19, sp)
	ld	(0x17, sp), a
	ld	a, xh
	and	a, (0x18, sp)
	ld	(0x16, sp), a
	ldw	x, (0x16, sp)
	jreq	00104$
;	main.c: 84: dispBuffer[Lcol][Lrow]=charGreyScale;
	ldw	x, #_dispBuffer+0
	addw	x, (0x0c, sp)
	ld	a, xl
	add	a, (0x01, sp)
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (0x1e, sp)
	ld	(x), a
	jra	00109$
00104$:
;	main.c: 86: dispBuffer[Lcol][Lrow]=background;
	ldw	x, #_dispBuffer+0
	addw	x, (0x0e, sp)
	ld	a, xl
	add	a, (0x01, sp)
	ld	(0x15, sp), a
	ld	a, xh
	adc	a, #0x00
	ld	xh, a
	ld	a, (0x15, sp)
	ld	xl, a
	ld	a, (0x1d, sp)
	ld	(x), a
00109$:
;	main.c: 81: for (Lrow=0; Lrow<numberOfRows; Lrow++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x07
	jrc	00108$
;	main.c: 79: for(Lcol=0; Lcol<numberOfCols; Lcol++)
	ldw	x, (0x0e, sp)
	addw	x, #0x0007
	ldw	(0x0e, sp), x
	ldw	x, (0x0c, sp)
	addw	x, #0x0007
	ldw	(0x0c, sp), x
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	cp	a, #0x05
	jrc	00116$
00112$:
	addw	sp, #25
	ret
;	main.c: 93: INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11){
;	-----------------------------------------
;	 function TIM1_UPD_OVF_TRG_BRK_IRQHandler
;	-----------------------------------------
_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
	sub	sp, #6
;	main.c: 94: if(TIM1_SR1 & TIM_SR1_UIF)
	ldw	x, #0x5255
	ld	a, (x)
	srl	a
	jrc	00152$
	jp	00121$
00152$:
;	main.c: 98: PB_ODR |= ROWS_PORTB_MASK;    // set all rows to high = off 
	ldw	x, #0x5005
	ld	a, (x)
	or	a, #0x30
	ld	(x), a
;	main.c: 99: PC_ODR |= ROWS_PORTC_MASK;
	ldw	x, #0x500a
	ld	a, (x)
	or	a, #0xf8
	ld	(x), a
;	main.c: 101: PD_ODR &= ~COLS_PORTD_MASK;	// cols off
	ldw	x, #0x500f
	ld	a, (x)
	and	a, #0xe1
	ld	(x), a
;	main.c: 103: PA_ODR = 0;
	mov	0x5000+0, #0x00
;	main.c: 106: if (dispBuffer[colCounter][rowCounter-1]>greyScaleCOunter)
	ldw	x, #_dispBuffer+0
	ldw	(0x02, sp), x
	ld	a, _colCounter+0
	ld	xl, a
	ld	a, #0x07
	mul	x, a
	addw	x, (0x02, sp)
	ldw	(0x05, sp), x
	ld	a, _rowCounter+0
	dec	a
	clrw	x
	ld	xl, a
	addw	x, (0x05, sp)
	ld	a, (x)
	cp	a, _greyScaleCOunter+0
	jrule	00110$
;	main.c: 108: switch (rowCounter)		
	ld	a, _rowCounter+0
	cp	a, #0x07
	jrugt	00110$
	clrw	x
	ld	xl, a
	sllw	x
	ldw	x, (#00155$, x)
	jp	(x)
00155$:
	.dw	#00108$
	.dw	#00101$
	.dw	#00102$
	.dw	#00103$
	.dw	#00104$
	.dw	#00105$
	.dw	#00106$
	.dw	#00107$
;	main.c: 110: case 1: PC_ODR = ~((ROW1_MASK)<<3); break;
00101$:
	mov	0x500a+0, #0xf7
	jra	00110$
;	main.c: 111: case 2: PB_ODR = ~((ROW2_MASK)<<4); break;
00102$:
	mov	0x5005+0, #0xdf
	jra	00110$
;	main.c: 112: case 3: PB_ODR = ~((ROW3_MASK)<<2); break;
00103$:
	mov	0x5005+0, #0xef
	jra	00110$
;	main.c: 113: case 4: PC_ODR = ~((ROW4_MASK)<<1); break;
00104$:
	mov	0x500a+0, #0xef
	jra	00110$
;	main.c: 114: case 5: PC_ODR = ~((ROW5_MASK)<<1); break;
00105$:
	mov	0x500a+0, #0xdf
	jra	00110$
;	main.c: 115: case 6: PC_ODR = ~((ROW6_MASK)<<1); break;
00106$:
	mov	0x500a+0, #0xbf
	jra	00110$
;	main.c: 116: case 7: PC_ODR = ~((ROW7_MASK)<<1); break;
00107$:
	mov	0x500a+0, #0x7f
;	main.c: 117: }
00108$:
00110$:
;	main.c: 121: if (colCounter==3)
	ld	a, _colCounter+0
	cp	a, #0x03
	jrne	00112$
;	main.c: 123: PA_ODR |= colBitMask[colCounter];
	ldw	x, #0x5000
	ld	a, (x)
	ld	(0x04, sp), a
	ldw	x, #_colBitMask+0
	ld	a, xl
	add	a, _colCounter+0
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	or	a, (0x04, sp)
	ldw	x, #0x5000
	ld	(x), a
	jra	00113$
00112$:
;	main.c: 127: PD_ODR |= colBitMask[colCounter];
	ldw	x, #0x500f
	ld	a, (x)
	ld	(0x01, sp), a
	ldw	x, #_colBitMask+0
	ld	a, xl
	add	a, _colCounter+0
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	or	a, (0x01, sp)
	ldw	x, #0x500f
	ld	(x), a
00113$:
;	main.c: 131: greyScaleCOunter++;
	ld	a, _greyScaleCOunter+0
	inc	a
	ld	_greyScaleCOunter+0, a
;	main.c: 132: if (greyScaleCOunter==7)
	ld	a, _greyScaleCOunter+0
	cp	a, #0x07
	jrne	00121$
;	main.c: 134: greyScaleCOunter=0;
	clr	_greyScaleCOunter+0
;	main.c: 135: rowCounter++;
	inc	_rowCounter+0
;	main.c: 136: if (rowCounter>7) 
	ld	a, _rowCounter+0
	cp	a, #0x07
	jrule	00121$
;	main.c: 138: rowCounter=1;
	mov	_rowCounter+0, #0x01
;	main.c: 139: colCounter++;
	inc	_colCounter+0
;	main.c: 140: readyFlag=1;
	mov	_readyFlag+0, #0x01
;	main.c: 141: if (colCounter>4) colCounter=0;
	ld	a, _colCounter+0
	cp	a, #0x04
	jrule	00121$
	clr	_colCounter+0
00121$:
;	main.c: 145: TIM1_SR1 = 0; // clear all interrupt flags
	mov	0x5255+0, #0x00
	addw	sp, #6
	iret
;	main.c: 149: void cheap_delay(void)
;	-----------------------------------------
;	 function cheap_delay
;	-----------------------------------------
_cheap_delay:
;	main.c: 152: for (a=0; a<60; a++)
	clr	a
	ld	xl, a
00106$:
;	main.c: 154: for (b=0; b<255; b++);
	ld	a, #0xff
	ld	xh, a
00105$:
	ld	a, xh
	dec	a
	ld	xh, a
	tnz	a
	jrne	00105$
;	main.c: 155: nop();
	nop
;	main.c: 156: nop();
	nop
;	main.c: 152: for (a=0; a<60; a++)
	incw	x
	ld	a, xl
	cp	a, #0x3c
	jrc	00106$
	ret
;	main.c: 160: int main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 162: PD_DDR = COLS_PORTD_MASK;	//set all cols to push-pull output 
	mov	0x5011+0, #0x1e
;	main.c: 163: PA_DDR = COLS_PORTA_MASK;
	mov	0x5002+0, #0x08
;	main.c: 164: PD_CR1 = COLS_PORTD_MASK;
	mov	0x5012+0, #0x1e
;	main.c: 165: PA_CR1 = COLS_PORTA_MASK;
	mov	0x5003+0, #0x08
;	main.c: 167: PB_DDR = ROWS_PORTB_MASK;    // set all row to (true) open drain outputs 
	mov	0x5007+0, #0x30
;	main.c: 168: PC_DDR = ROWS_PORTC_MASK;
	mov	0x500c+0, #0xf8
;	main.c: 169: PB_ODR = ROWS_PORTB_MASK;    // set all rows to high = off 
	mov	0x5005+0, #0x30
;	main.c: 170: PC_ODR = ROWS_PORTC_MASK;
	mov	0x500a+0, #0xf8
;	main.c: 172: TIM1_ARRH = 0x00;
	mov	0x5262+0, #0x00
;	main.c: 173: TIM1_ARRL = 0x1F;
	mov	0x5263+0, #0x1f
;	main.c: 175: TIM1_IER = TIM_IER_UIE; // interrupts: update
	mov	0x5254+0, #0x01
;	main.c: 176: TIM1_CR1 = TIM_CR1_APRE | TIM_CR1_URS | TIM_CR1_CEN; // auto-reload + interrupt on overflow + enable
	mov	0x5250+0, #0x85
;	main.c: 178: enableInterrupts();
	rim
;	main.c: 181: reDot_displayASCII('o',1,7);
	push	#0x07
	push	#0x01
	push	#0x6f
	call	_reDot_displayASCII
	addw	sp, #3
;	main.c: 182: while(1)
00102$:
	jra	00102$
	ret
	.area CODE
_Font5x7:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5F	; 95
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x7F	; 127
	.db #0x14	; 20
	.db #0x7F	; 127
	.db #0x14	; 20
	.db #0x24	; 36
	.db #0x2A	; 42
	.db #0x7F	; 127
	.db #0x2A	; 42
	.db #0x12	; 18
	.db #0x23	; 35
	.db #0x13	; 19
	.db #0x08	; 8
	.db #0x64	; 100	'd'
	.db #0x62	; 98	'b'
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x55	; 85	'U'
	.db #0x22	; 34
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1C	; 28
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x1C	; 28
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x2A	; 42
	.db #0x1C	; 28
	.db #0x2A	; 42
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3E	; 62
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x3E	; 62
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x45	; 69	'E'
	.db #0x3E	; 62
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x7F	; 127
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x61	; 97	'a'
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x46	; 70	'F'
	.db #0x21	; 33
	.db #0x41	; 65	'A'
	.db #0x45	; 69	'E'
	.db #0x4B	; 75	'K'
	.db #0x31	; 49	'1'
	.db #0x18	; 24
	.db #0x14	; 20
	.db #0x12	; 18
	.db #0x7F	; 127
	.db #0x10	; 16
	.db #0x27	; 39
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x39	; 57	'9'
	.db #0x3C	; 60
	.db #0x4A	; 74	'J'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x71	; 113	'q'
	.db #0x09	; 9
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x36	; 54	'6'
	.db #0x06	; 6
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x29	; 41
	.db #0x1E	; 30
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x56	; 86	'V'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x51	; 81	'Q'
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x32	; 50	'2'
	.db #0x49	; 73	'I'
	.db #0x79	; 121	'y'
	.db #0x41	; 65	'A'
	.db #0x3E	; 62
	.db #0x7E	; 126
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x7E	; 126
	.db #0x7F	; 127
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x36	; 54	'6'
	.db #0x3E	; 62
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x7F	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x22	; 34
	.db #0x1C	; 28
	.db #0x7F	; 127
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x41	; 65	'A'
	.db #0x7F	; 127
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x3E	; 62
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x51	; 81	'Q'
	.db #0x32	; 50	'2'
	.db #0x7F	; 127
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x7F	; 127
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x7F	; 127
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x3F	; 63
	.db #0x01	; 1
	.db #0x7F	; 127
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x22	; 34
	.db #0x41	; 65	'A'
	.db #0x7F	; 127
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7F	; 127
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x7F	; 127
	.db #0x7F	; 127
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x7F	; 127
	.db #0x3E	; 62
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x3E	; 62
	.db #0x7F	; 127
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x3E	; 62
	.db #0x41	; 65	'A'
	.db #0x51	; 81	'Q'
	.db #0x21	; 33
	.db #0x5E	; 94
	.db #0x7F	; 127
	.db #0x09	; 9
	.db #0x19	; 25
	.db #0x29	; 41
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
	.db #0x31	; 49	'1'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x7F	; 127
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x3F	; 63
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x3F	; 63
	.db #0x1F	; 31
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x1F	; 31
	.db #0x7F	; 127
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x7F	; 127
	.db #0x63	; 99	'c'
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x61	; 97	'a'
	.db #0x51	; 81	'Q'
	.db #0x49	; 73	'I'
	.db #0x45	; 69	'E'
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7F	; 127
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x7F	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x78	; 120	'x'
	.db #0x7F	; 127
	.db #0x48	; 72	'H'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x20	; 32
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x48	; 72	'H'
	.db #0x7F	; 127
	.db #0x38	; 56	'8'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x18	; 24
	.db #0x08	; 8
	.db #0x7E	; 126
	.db #0x09	; 9
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x3C	; 60
	.db #0x7F	; 127
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x7D	; 125
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x44	; 68	'D'
	.db #0x3D	; 61
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7F	; 127
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x7F	; 127
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x7C	; 124
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x7C	; 124
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x7C	; 124
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x18	; 24
	.db #0x7C	; 124
	.db #0x7C	; 124
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x48	; 72	'H'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x20	; 32
	.db #0x04	; 4
	.db #0x3F	; 63
	.db #0x44	; 68	'D'
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x3C	; 60
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x7C	; 124
	.db #0x1C	; 28
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x1C	; 28
	.db #0x3C	; 60
	.db #0x40	; 64
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x3C	; 60
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x0C	; 12
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x3C	; 60
	.db #0x44	; 68	'D'
	.db #0x64	; 100	'd'
	.db #0x54	; 84	'T'
	.db #0x4C	; 76	'L'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x36	; 54	'6'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7F	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0x36	; 54	'6'
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x2A	; 42
	.db #0x1C	; 28
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x1C	; 28
	.db #0x2A	; 42
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x7F	; 127
	.db #0x7F	; 127
	.db #0x7F	; 127
	.db #0x7F	; 127
	.db #0x7F	; 127
_colBitMask:
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x02	; 2
	.area INITIALIZER
__xinit__testString:
	.db #0x48	;  72	'H'
	.db #0x20	;  32
	.db #0x65	;  101	'e'
	.db #0x20	;  32
	.db #0x6C	;  108	'l'
	.db #0x20	;  32
	.db #0x6C	;  108	'l'
	.db #0x20	;  32
	.db #0x6F	;  111	'o'
	.db #0x20	;  32
	.db #0x21	;  33
	.db #0x20	;  32
	.db #0x20	;  32
__xinit__colCounter:
	.db #0x00	; 0
__xinit__rowCounter:
	.db #0x00	; 0
__xinit__greyScaleCOunter:
	.db #0x00	; 0
__xinit__readyFlag:
	.db #0x00	;  0
__xinit__dispBuffer:
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
__xinit__myChar:
	.db #0x00	;  0
	.area CABS (ABS)
