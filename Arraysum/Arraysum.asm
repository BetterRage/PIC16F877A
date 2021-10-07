
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
	ENDC
;**********************************************************************
	ORG     0x000      	; processor reset vector
	clrf	PCLATH
  	goto    main      	; go to beginning of program
	ORG     0x004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere

main
	MOVLF .22,UGRENZE
	MOVLF .11,OGRENZE
	MOVLF .33,SUM
	MOVLF .3,GUN
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	clrf ZSUM
	clrf 0x72
loop1
	movlw UGRENZE
	addwf 0x72,W
	movwf FSR
	movf INDF,W
	addwf ZSUM,f
	incf 0x72,f
	movf 0x72,W
	subwf GUN,W
	SKPZ
	goto loop1
	
	;;; SEE MACROS FILE (ARRAYSUM MACRO
	ARRAYSUM UGRENZE,GUN,ZSUM
	
	
	goto $
	END                       ; directive 'end of program'

