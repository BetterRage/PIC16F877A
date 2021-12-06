;################################################################################################
;   This file is a basic code template for assembly code generation   *
;   on the PIC16F877A. This file contains the basic code              *
;   building blocks to build upon.                                    *  
;                                                                     *
;   Refer to the MPASM User's Guide for additional information on     *
;   features of the assembler (Document DS33014).                     *
;                                                                     *
;   Refer to the respective PIC data sheet for additional             *
;   information on the instruction set.                               *
;                                                                     *
;**********************************************************************
;    Filename:	    xxx.asm                                           *
;    Date:                                                            *
;    File Version:                                                    *
;                                                                     *
;    Author:                                                          *
;    Company:                                                         *
;**********************************************************************
;    Files Required: P16F877A.INC                                     *
;**********************************************************************
;    Notes:                                                           *
;**********************************************************************


	list		p=16f877A		; list directive to define processor
	#include	<p16f877A.inc>	; processor specific variable definitions
	
;	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.


;***** VARIABLE DEFINITIONS

Rider		EQU	0x20
out 		EQU	0x21
PORTBold		EQU	0x22

;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH 		

  	goto    begin     	; go to beginning of program

	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere

begin
	BANKSEL	TRISB
	movf	TRISB,
	iorwf	b'00000111'
	movf	TRISB
	movlw	b'00000000'
	movwf	TRISC
	BANKSEL	OPTION_REG
	bcf		OPTION_REG,7
	BANKSEL	PORTC
	clrf	PORTC
main
	BANKSEL	TRISB
	bcf		TRISB,3
	bsf		TRISB,4
	BANKSEL PORTB
	bcf		PORTB,3
	comf	PORTB,w
	andlw	b'00000111'
	movwf	out
	rlf		out,f
	rlf		out,f
	rlf		out,f

	BANKSEL	TRISB
	bsf		TRISB,3
	bcf		TRISB,4
	BANKSEL	PORTB
	bcf		PORTB,4
	comf	PORTB,w
	andlw	b'00000111'
	iorwf	out,w
	movwf	PORTC
	

; remaining code goes here
	goto	main

	END                       ; directive 'end of program'

