
	list		p=16f877A		; list directive to define processor
	#include	<p16f877a.inc>	; processor specific variable definitions
	
	#include 	"..\LCD.asm"
	#include 	"..\MACRO.asm"
;	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF
	expand
; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.


;***** VARIABLE DEFINITIONS
	CBLOCK 0x25
	PORTBALT:1
	PORTBCOPY:1
	FLANKEN:1
	COUNT:1
	BCD:3
	LOOPCNT:1
	ENDC
;**********************************************************************
	ORG     0x0000      	; processor reset vector
	clrf	PCLATH
  	goto    init      	; go to beginning of program
	ORG     0x0004      	; interrupt vector location

; isr code can go here or be located as a call subroutine elsewhere
init
	call LCD_INIT
	BANK1
	bsf TRISB,0
	bcf OPTION_REG,7
	BANK0
	clrf COUNT
main
	MOVFF PORTB,PORTBCOPY
	comf PORTBCOPY,w
	andwf PORTBALT,w
	movwf FLANKEN
	MOVFF PORTBCOPY,PORTBALT
	btfss FLANKEN,0
	goto endmain
	incf COUNT
	FILETOBCD COUNT,BCD
	LCDCMD 0x80
	LCDREG BCD
	LCDREG BCD+1
	LCDREG BCD+2
	
endmain
	call WAIT20000
	goto main
	#include "..\LCDSUB.asm"
	END                       ; directive 'end of program'

