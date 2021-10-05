
	list		p=16f877A		; list directive to define processor
	#include	<p16f877a.inc>	; processor specific variable definitions
	
;	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.


;***** VARIABLE DEFINITIONS

	CBLOCK 0x20
	UGRENZE:1
	OGRENZE:1
	SUM:1
	ENDC

SUMME macro START, STOPP, ERGEBNIS
	clrf 71h
	movf START,W
	movwf 70h
add
	movf 71h,W
	addwf 70h,W
	movwf 71h	
	incf 70h,f
	movf 70h,W
	subwf STOPP,W
	SKPNC
	goto add
	movf 71h,W
	movwf ERGEBNIS
	endm
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    main      	; go to beginning of program
	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere

main
	movlw .8
	movwf UGRENZE
	movlw .20
	movwf OGRENZE
	SUMME UGRENZE, OGRENZE, SUM
	NOP
	goto $
	END                       ; directive 'end of program'

