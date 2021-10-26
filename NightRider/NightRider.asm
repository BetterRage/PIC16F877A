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
	#include "..\MACRO.asm"
;	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.


;***** VARIABLE DEFINITIONS

CBLOCK 0x71
Rider		:1
Direction  	:1
Loop1		:1
Loop2		:1
Loop3		:1
ENDC
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
	 		
  	goto    main      	; go to beginning of program

	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere


main
	BANKSEL TRISC
	clrf TRISC
	BANKSEL PORTC
	clrf 	Rider
	clrf 	Direction
	bsf 	Rider,0
	CLRC
loop
	btfss	Direction,0
	rlf	Rider,f
	btfsc 	Direction,0
	rrf 	Rider,f
	btfsc	Rider,7
	bsf 	Direction,0
	btfsc	Rider,0	
	bcf 	Direction,0
	MOVFF Rider,PORTC
	call	delay
	goto	loop

delay
	movlw	.13
	movwf	Loop3
loop3
	movlw	.250
	movwf	Loop2
loop2
	movlw	.255
	movwf	Loop1
loop1
	decfsz	Loop1
	goto	loop1
	decfsz	Loop2
	goto 	loop2
	decfsz	Loop3
	goto 	loop3
	return
	

	END                       ; directive 'end of program'

