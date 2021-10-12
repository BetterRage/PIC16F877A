
	list		p=16f877A		; list directive to define processor
	#include	<p16f877a.inc>	; processor specific variable definitions
	#include 	"..\MACRO.asm"
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
	GUN:1
	ZSUM:1
	COMPARE:1
	OFFSET:1
	ENDC
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    main      	; go to beginning of program
	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere

main
	clrf ZSUM
	clrf OFFSET
	MOVLF .20,UGRENZE
	MOVLF .19,OGRENZE
	MOVLF .22,SUM
	MOVLF .3,GUN
	MOVLF .20,COMPARE
	SMALLERTHRESHOLD UGRENZE,GUN,COMPARE,ZSUM
	clrf ZSUM
	GREATERTHRESHOLD UGRENZE,GUN,COMPARE,ZSUM
	goto $
	END                       ; directive 'end of program'

