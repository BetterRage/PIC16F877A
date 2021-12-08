	;BENJAMIN SCHMID TIES 
	list		p=16f877A			
	#include	<p16f877a.inc>
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

;Kopiert den Inhalt von SRC nach DST
MOVFF macro SRC, DST
	movf SRC, W
	movwf DST
	endm

;Literal L wird in DEST geschrieben
MOVLF macro L,DEST
	movlw L
	movwf DEST
	endm
	
AL equ 0x20
AH equ 0x21
QL equ 0x22
QH equ 0x23

	ORG     0x000      
	clrf	PCLATH
  	goto    main   	
	ORG     0x004
main
	MOVLF 0x8F,AH
	clrf AL
	call divideby16
 	goto main

divideby16
	local shiftloop
	MOVLF .4,0x71 ;Zähler der Schleife
	clrf QH
	clrf QL
	MOVFF AL,0x72 ;0x72 und 0x73 werden als zwischenspeicher für 
	MOVFF AH,0x73 ;AH und AL verwendet
	btfss AH,7
	bcf QH,7
	btfsc AH,7
	bsf QH,7
shiftloop
	CLRC
	rrf 0x73,f
	rrf 0x72,f
	decfsz 0x71
	goto shiftloop
	movf 0x73,w
	andlw b'00000111'
	iorwf QH,f
	MOVFF 0x72,QL
	return
	END

