
	list		p=16f877A		; list directive to define processor
	#include	<p16f877a.inc>	; processor specific variable definitions
	
	#include 	"..\MACRO.asm"
;	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF
	expand
; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.


;***** VARIABLE DEFINITIONS
	CBLOCK 0x25
	WURFEL:1
	ENDC
;**********************************************************************
	ORG     0x0000      	; processor reset vector
	clrf	PCLATH
  	goto    begin      	; go to beginning of program

	ORG     0x004      	; interrupt vector location
	
	
begin
	BANKSEL TRISC
	bcf OPTION_REG,7
	clrf TRISC
	bsf TRISB,1
	BANKSEL PORTC
	MOVLF .1,WURFEL
main
	btfss PORTB,1
	goto gedruckt
	btfsc PORTB,1
	goto nicht
gedruckt
	clrf PORTC
	rlf WURFEL,f
	btfss WURFEL,6
	goto endmain
	MOVLF .1,WURFEL
	goto endmain
nicht
	MOVFF WURFEL,PORTC
endmain
	goto main
	END                       ; directive 'end of program'

