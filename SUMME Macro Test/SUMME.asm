
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
	SUM1H:1
	SUM1L:1
	SUM2H:1
	SUM2L:1
	SUMH:1
	SUML:1
	ENDC
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    main      	; go to beginning of program
	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere

main
	MOVLF .8,UGRENZE
	MOVLF .8,OGRENZE
	MOVLF .8,SUM1H
	MOVLF .4,SUM1L
	MOVLF .8,SUM2H
	MOVLF .4,SUM2L
	SUMME UGRENZE, OGRENZE, SUM
	MOVFF SUM,GUN
	ADD16 SUM1H,SUM1L,SUM2H,SUM2L,SUMH,SUML
	ADD8 SUM1H,SUM2L,SUMH
	goto $
	END                       ; directive 'end of program'

