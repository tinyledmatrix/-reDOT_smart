;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Mar 24 2016) (Linux)
; This file was generated Fri Feb  2 18:21:32 2018
;--------------------------------------------------------
	.module til305
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _colBitMask
	.globl _Font5x7
	.globl _myChar
	.globl _displayBuffer
	.globl _colCounter
	.globl _reDot_displayASCII
	.globl _TIM1_UPD_OVF_TRG_BRK_IRQHandler
	.globl _reDot_init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_colCounter::
	.ds 1
_displayBuffer::
	.ds 5
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_myChar::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	til305.c: 35: void reDot_displayASCII(char index)
;	-----------------------------------------
;	 function reDot_displayASCII
;	-----------------------------------------
_reDot_displayASCII:
	sub	sp, #6
;	til305.c: 37: index-=32;
	ld	a, (0x09, sp)
	sub	a, #0x20
	ld	(0x09, sp), a
;	til305.c: 38: if (index>95) // if ascii>127
	ld	a, (0x09, sp)
	cp	a, #0x5f
;	til305.c: 39: return;
	jrsgt	00103$
;	til305.c: 40: displayBuffer[0]=Font5x7[index][0];
	ldw	x, #_displayBuffer+0
	ldw	(0x01, sp), x
	ldw	x, #_Font5x7+0
	ldw	(0x05, sp), x
	push	#0x05
	ld	a, (0x0a, sp)
	push	a
	call	__muluschar
	addw	sp, #2
	addw	x, (0x05, sp)
	ldw	(0x03, sp), x
	ldw	x, (0x03, sp)
	ld	a, (x)
	ldw	x, (0x01, sp)
	ld	(x), a
;	til305.c: 41: displayBuffer[1]=Font5x7[index][1];
	ldw	x, #_displayBuffer+1
	ldw	y, (0x03, sp)
	ld	a, (0x1, y)
	ld	(x), a
;	til305.c: 42: displayBuffer[2]=Font5x7[index][2];
	ldw	x, #_displayBuffer+2
	ldw	y, (0x03, sp)
	ld	a, (0x2, y)
	ld	(x), a
;	til305.c: 43: displayBuffer[3]=Font5x7[index][3];
	ldw	x, #_displayBuffer+3
	ldw	y, (0x03, sp)
	ld	a, (0x3, y)
	ld	(x), a
;	til305.c: 44: displayBuffer[4]=Font5x7[index][4];  
	ldw	x, #_displayBuffer+4
	ldw	y, (0x03, sp)
	ld	a, (0x4, y)
	ld	(x), a
00103$:
	addw	sp, #6
	ret
;	til305.c: 48: INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11){
;	-----------------------------------------
;	 function TIM1_UPD_OVF_TRG_BRK_IRQHandler
;	-----------------------------------------
_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
	sub	sp, #2
;	til305.c: 49: if(TIM1_SR1 & TIM_SR1_UIF)
	ldw	x, #0x5255
	ld	a, (x)
	srl	a
	jrc	00122$
	jp	00107$
00122$:
;	til305.c: 51: colCounter++;
	inc	_colCounter+0
;	til305.c: 52: if (colCounter>4) colCounter=0;
	ld	a, _colCounter+0
	cp	a, #0x04
	jrule	00102$
	clr	_colCounter+0
00102$:
;	til305.c: 54: PB_ODR |= ROWS_PORTB_MASK;    // set all rows to high = off 
	ldw	x, #0x5005
	ld	a, (x)
	or	a, #0x30
	ld	(x), a
;	til305.c: 55: PC_ODR |= ROWS_PORTC_MASK;
	ldw	x, #0x500a
	ld	a, (x)
	or	a, #0xf8
	ld	(x), a
;	til305.c: 57: PD_ODR &= ~COLS_PORTD_MASK;	// cols off
	ldw	x, #0x500f
	ld	a, (x)
	and	a, #0xe1
	ld	(x), a
;	til305.c: 59: PA_ODR = 0;
	mov	0x5000+0, #0x00
;	til305.c: 63: PB_ODR = ~( (displayBuffer[colCounter] )<<4);
	ldw	x, #_displayBuffer+0
	ld	a, xl
	add	a, _colCounter+0
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	swap	a
	and	a, #0xf0
	cpl	a
	ldw	x, #0x5005
	ld	(x), a
;	til305.c: 64: PC_ODR = ~( (displayBuffer[colCounter] )<<1);
	ldw	x, #_displayBuffer+0
	ld	a, xl
	add	a, _colCounter+0
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	sll	a
	cpl	a
	ldw	x, #0x500a
	ld	(x), a
;	til305.c: 67: if (colCounter==3)
	ld	a, _colCounter+0
	cp	a, #0x03
	jrne	00104$
;	til305.c: 69: PA_ODR |= colBitMask[colCounter];
	ldw	x, #0x5000
	ld	a, (x)
	ld	(0x02, sp), a
	ldw	x, #_colBitMask+0
	ld	a, xl
	add	a, _colCounter+0
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	or	a, (0x02, sp)
	ldw	x, #0x5000
	ld	(x), a
	jra	00107$
00104$:
;	til305.c: 73: PD_ODR |= colBitMask[colCounter];
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
00107$:
;	til305.c: 76: TIM1_SR1 = 0; // clear all interrupt flags
	mov	0x5255+0, #0x00
	addw	sp, #2
	iret
;	til305.c: 80: void reDot_init (void)
;	-----------------------------------------
;	 function reDot_init
;	-----------------------------------------
_reDot_init:
;	til305.c: 82: PD_DDR = COLS_PORTD_MASK;	//set all cols to push-pull output 
	mov	0x5011+0, #0x1e
;	til305.c: 83: PA_DDR = COLS_PORTA_MASK;
	mov	0x5002+0, #0x08
;	til305.c: 84: PD_CR1 = COLS_PORTD_MASK;
	mov	0x5012+0, #0x1e
;	til305.c: 85: PA_CR1 = COLS_PORTA_MASK;
	mov	0x5003+0, #0x08
;	til305.c: 87: PB_DDR = ROWS_PORTB_MASK;    	// set all row to (true) open drain outputs 
	mov	0x5007+0, #0x30
;	til305.c: 88: PC_DDR = ROWS_PORTC_MASK;
	mov	0x500c+0, #0xf8
;	til305.c: 89: PB_ODR = ROWS_PORTB_MASK;    	// set all rows to high = off 
	mov	0x5005+0, #0x30
;	til305.c: 90: PC_ODR = ROWS_PORTC_MASK;
	mov	0x500a+0, #0xf8
;	til305.c: 92: TIM1_ARRH = 0x01;
	mov	0x5262+0, #0x01
;	til305.c: 93: TIM1_ARRL = 0xD0;
	mov	0x5263+0, #0xd0
;	til305.c: 95: TIM1_IER = TIM_IER_UIE; 	// interrupts: update
	mov	0x5254+0, #0x01
;	til305.c: 96: TIM1_CR1 = TIM_CR1_APRE | TIM_CR1_URS | TIM_CR1_CEN; // auto-reload + interrupt on overflow + enable
	mov	0x5250+0, #0x85
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
_colBitMask:
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x02	; 2
	.area INITIALIZER
__xinit__myChar:
	.db #0x48	;  72	'H'
	.area CABS (ABS)
