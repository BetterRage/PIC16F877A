;SUMME ALLER NATÜRLICHEN ZAHLEN ZWISCHEN START UND STOPP => ERGEBNIS
;z.B.: (START = 5)   (STOPP = 7)  =>  (ERGEBNIS = 18)  
SUMME macro START, STOPP, ERGEBNIS
	local add
	clrf ERGEBNIS
	MOVFF START,71h
add
	movf ERGEBNIS,W
	addwf 71h,W
	movwf ERGEBNIS	
	incf 71h,f
	movf 71h,W
	subwf STOPP,W
	SKPNC
	goto add
	endm

;MOVE FILE REGISTER 1 -> FILE REGISTER 2 
MOVFF macro FROM, TO
	movf FROM, W
	movwf TO
	endm

;SUM1+SUM2->SUM
ADD8 macro SUM1,SUM2,SUM
	movf SUM1,W
	addwf SUM2,W
	movwf SUM
	endm

;SUM1HL+SUM2HL->SUMHL
ADD16 macro SUM1H, SUM1L,SUM2H,SUM2L,SUMH,SUML
	ADD8 SUM1H,SUM2H,SUMH
	ADD8 SUM1L,SUM2L,SUML
	SKPNC
	incf SUMH,f
	endm

;L->DEST
MOVLF macro L,DEST
	movlw L
	movwf DEST
	endm

;BILDET DIE SUMME ALLER LITERALS VON STARTADDR BIS STARTADDR + OFFSET
ARRAYSUM macro STARTADDR,OFFSET,SUMME
	local loop
	clrf 0x71 
	clrf SUMME
loop
	movlw UGRENZE
	addwf 0x71,W
	movwf FSR
	movf INDF,W
	addwf SUMME,f
	incf 0x71,f
	movf 0x71,W
	subwf GUN,W
	SKPZ
	goto loop
	endm

;Zählt alle elemente im speicher von 
;startaddr bis startaddr+offset die größer als compare sind
GREATERTHRESHOLD macro STARTADDR,OFFSET,COMPARE,COUNT
	local loop
	clrf 71h
loop
	movlw STARTADDR
	addwf 71h,W
	movwf FSR
	movf INDF,W
	subwf COMPARE,W
	SKPC
	incf COUNT,F
	incf 71h,F
	movf OFFSET,W
	subwf 71h,W
	SKPC
	goto loop
	endm

;Zählt alle elemente im speicher von 
;startaddr bis startaddr+offset die kleiner als compare sind
SMALLERTHRESHOLD macro STARTADDR,OFFSET,COMPARE,COUNT
	local loop
	clrf 71h
loop
	movlw STARTADDR
	addwf 71h,W
	movwf FSR
	movf COMPARE,W
	subwf INDF,W
	SKPC
	incf COUNT,F
	incf 71h,F
	movf OFFSET,W
	subwf 71h,W
	SKPC
	goto loop
	endm

;Zählt alle elemente im speicher von 
;startaddr bis startaddr+offset die gleich compare sind
EQUALTHRESHOLD macro STARTADDR,OFFSET,COMPARE,COUNT
	local loop
	clrf 71h
loop
	movlw STARTADDR
	addwf 71h,W
	movwf FSR
	movf COMPARE,W
	subwf INDF,W
	SKPNZ
	incf COUNT,F
	incf 71h,F
	movf OFFSET,W
	subwf 71h,W
	SKPC
	goto loop
	endm

;setzt den speicher von Startaddr bis startaddr+offset auf 0
MEMCLEAR macro STARTADDR,OFFSET
	local loop
	MOVLF OFFSET,0x71
	movlw STARTADDR
	movwf FSR
loop
	clrf INDF
	incf FSR,f
	decfsz 0x71,f
	goto loop
	endm

LEADING0REPLACE macro STARTADDR,OFFSET
	local loop
	MOVLF OFFSET,0x71
	movlw ASCII
	movwf FSR
loop
	movlw '0'
	subwf INDF,w
	SKPZ
	goto stop
	MOVLF ' ',INDF
	incf FSR,f
	decfsz 0x71,f
	goto loop
stop
	endm

LITERALTOBCD macro LITERAL,DEST
	local count100
	local count10
	local endcount
	MEMCLEAR DEST,.3
	MOVLF LITERAL,0x71
	MOVFF 0x71,DEST+.2
count100
	movf DEST+.2,W
	sublw .100
	SKPNC
	goto count10
	incf DEST,f
	movlw .100
	subwf DEST+.2,f
	goto count100
count10
	movf DEST+.2,W
	sublw .10
	SKPNC
	goto endcount
	incf DEST+.1,f
	movlw .10
	subwf DEST+.2,f
	goto count10
endcount
	movlw '0'
	addwf DEST+.2,f
	addwf DEST+.1,f
	addwf DEST,f
	endm

FILETOBCD macro FILE,DEST
	local count100
	local count10
	local endcount
	MEMCLEAR DEST,.3
	MOVFF FILE,0x71
	MOVFF 0x71,DEST+.2
count100
	movf DEST+.2,W
	sublw .100
	SKPNC
	goto count10
	incf DEST,f
	movlw .100
	subwf DEST+.2,f
	goto count100
count10
	movf DEST+.2,W
	sublw .10
	SKPNC
	goto endcount
	incf DEST+.1,f
	movlw .10
	subwf DEST+.2,f
	goto count10
endcount
	movlw '0'
	addwf DEST+.2,f
	addwf DEST+.1,f
	addwf DEST,f
	endm

	


