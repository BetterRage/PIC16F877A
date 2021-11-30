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
	SIGNALCOUNT:1
	SREGS:1
	WREGS:1
	ENDC


;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    begin


      	; go to beginning of program
	ORG     0x004      	; interrupt vector location
	bcf INTCON,TMR0IF
	movwf WREGS
	MOVFF STATUS,SREGS
	MOVLF .16,TMR0
	movf PORTC,w
	andlw b'11111100'
	movwf PORTC
	movf SIGNALCOUNT,w
	call signal
	iorwf PORTC,f	
	incf SIGNALCOUNT,f
	movlw .11
	subwf SIGNALCOUNT,w
	SKPNZ
	clrf SIGNALCOUNT
	MOVFF SREGS,STATUS
	swapf WREGS,f
	swapf WREGS,w
	return
	
begin
	clrf SIGNALCOUNT
	BANKSEL TRISC
	bcf TRISC,0
	bcf TRISC,1
	bsf OPTION_REG, PSA
	bcf OPTION_REG,	T0CS
	BANKSEL PORTC
	bsf INTCON,GIE
 	bsf INTCON,TMR0IE
	bcf INTCON,TMR0IF

main
	goto main

signal
	addwf PCL,f
	retlw .3
	retlw .3
	retlw .3
	retlw .3
	retlw .2
	retlw .2
	retlw .0
	retlw .1	
	retlw .1	
	retlw .3	
	retlw .0
	END