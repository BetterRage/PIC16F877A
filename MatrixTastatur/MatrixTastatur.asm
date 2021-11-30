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
	INPUT:1
	ENDC
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    begin      	; go to beginning of program
	ORG     0x004      	; interrupt vector location

begin
	BANKSEL TRISC
	clrf TRISC
	bcf OPTION_REG,7
	movlw .7
	iorwf TRISB,f
	BANKSEL PORTB
main
	comf PORTB,w
	andlw .7
	movwf INPUT
	movf PORTC,w
	andlw b'11111000'
	iorwf INPUT,w
	movwf PORTC
	goto main
	END