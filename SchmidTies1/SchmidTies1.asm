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

;Kopiert alle Register SOURCEADDR:(SOURCEADDR+OFFSET) 
;nach DEySTADDR:(DESTADDR+OFFSET)
MEMCOPY macro SOURCEADDR,OFFSET,DESTADDR
	local loop
	clrf 0x71 		;0x71 wird als Zähler verwendet
loop
	movlw SOURCEADDR
	addwf 0x71,w
	movwf FSR
	MOVFF INDF,0x72 ;Die zu kopierenden Werte werden
	movlw DESTADDR	;in 0x72 zwischengespeichert
	addwf 0x71,w
	movwf FSR
	MOVFF 0x72,INDF
	incf 0x71,f
	movf 0x71,w
	sublw OFFSET
	SKPZ
	goto loop
	endm

;Sucht den kleinsten Registerinhalt 
;im Bereich STARTADDR:(STARTADDR+OFFSET) und speichert ihn in RESULT
FINDMIN macro STARTADDR,OFFSET,RESULT
	local loop
	clrf 71h 		;0x71 wird als Zähler verwendet
	MOVLF .127,0x20 ;aktuell kleinster Wert
loop
	movlw STARTADDR
	addwf 0x71,w
	movwf FSR
	movf INDF,w		;letzter MIN wert - aktueller wert der Schleife
	subwf 0x20,f		
	btfsc 0x20,7 	;wenn das Ergebnis positiv ist wurder neuer min wert gefunden
	goto nomin
	MOVFF INDF,0x20
nomin
	incf 0x71,f
	movf 0x71,w
	sublw OFFSET
	SKPZ
	goto loop
	endm
	
Min equ 0x20

	ORG     0x000      
	clrf	PCLATH
  	goto    main   	
	ORG     0x004
main
	MEMCOPY 0x30,.17,0x50
	FINDMIN 0x30,.17,Min
	goto main
	END

