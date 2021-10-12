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

;BILDET DIE SUMME ALLER BYTES VON STARTADDR BIS STARTADDR + OFFSET
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
;startaddr bis startaddr+offset die größer oder gleich compare sind
GREATERTHRESHOLD macro STARTADDR,OFFSET,COMPARE,COUNT
	local loop
	clrf 71h
loop
	movlw STARTADDR
	addwf 71h,W
	movwf FSR
	movf COMPARE,W
	subwf INDF,W
	SKPNC
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


