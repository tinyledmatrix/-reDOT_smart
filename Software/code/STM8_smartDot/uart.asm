;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Mar 24 2016) (Linux)
; This file was generated Fri Feb  2 18:21:45 2018
;--------------------------------------------------------
	.module uart
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uart_init
	.globl _uart_sendByte
	.globl _uart_getBuffer
	.globl _UART1_RX_IRQHandler
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_uartBuffer:
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
;	uart.c: 8: void uart_init(void)
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	uart.c: 11: PD_DDR |= GPIO_PIN5; 
	ldw	x, #0x5011
	ld	a, (x)
	or	a, #0x20
	ld	(x), a
;	uart.c: 12: PD_CR1 |= GPIO_PIN5;
	ldw	x, #0x5012
	ld	a, (x)
	or	a, #0x20
	ld	(x), a
;	uart.c: 15: UART1_BRR2 = 0;	// write UBRR2 first
	mov	0x5233+0, #0x00
;	uart.c: 16: UART1_BRR1 = 0x0D;
	mov	0x5232+0, #0x0d
;	uart.c: 19: UART1_CR2 = UART_CR2_TEN | UART_CR2_REN | UART_CR2_RIEN;
	mov	0x5235+0, #0x2c
	ret
;	uart.c: 23: void uart_sendByte(uint8_t inByte)
;	-----------------------------------------
;	 function uart_sendByte
;	-----------------------------------------
_uart_sendByte:
;	uart.c: 25: while(!(UART1_SR & UART_SR_TXE)); // wait until previous byte transmitted
00101$:
	ldw	x, #0x5230
	ld	a, (x)
	tnz	a
	jrpl	00101$
;	uart.c: 26: UART1_DR = inByte;
	ldw	x, #0x5231
	ld	a, (0x03, sp)
	ld	(x), a
	ret
;	uart.c: 29: uint8_t uart_getBuffer(void)
;	-----------------------------------------
;	 function uart_getBuffer
;	-----------------------------------------
_uart_getBuffer:
;	uart.c: 31: return uartBuffer;
	ld	a, _uartBuffer+0
	ret
;	uart.c: 35: INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
;	-----------------------------------------
;	 function UART1_RX_IRQHandler
;	-----------------------------------------
_UART1_RX_IRQHandler:
;	uart.c: 38: if(UART1_SR & UART_SR_RXNE) 		// if data received
	ldw	x, #0x5230
	ld	a, (x)
	bcp	a, #0x20
	jreq	00106$
;	uart.c: 40: tempBuf = UART1_DR; 		// read received byte & clear RXNE flag
	ldw	x, #0x5231
	push	a
	ld	a, (x)
	ld	xh, a
	pop	a
;	uart.c: 41: while(!(UART1_SR & UART_SR_TXE));
	and	a, #0x80
00101$:
	tnz	a
	jreq	00101$
;	uart.c: 42: UART1_DR = uartBuffer; 		//push out old buffer
	mov	0x5231+0, _uartBuffer+0
;	uart.c: 43: uartBuffer = tempBuf; 		// put received byte into buffer
	ld	a, xh
	ld	_uartBuffer+0, a
00106$:
	iret
	.area CODE
	.area INITIALIZER
__xinit__uartBuffer:
	.db #0x0A	; 10
	.area CABS (ABS)
