
WAIT1		EQU	H'0020'			;Variable f�r Verz�gerungsschleifen Nr.1
WAIT2		EQU	H'0021'			;Variable f�r Verz�gerungsschleifen Nr.2
;-----------------------------------------------------------------------------------------------------------
ZWS		EQU     H'0022'
;-----------------------------------------------------------------------------------------------------------
LCD_WREG	EQU	H'0023'			;Zwischenspeicher Schreiben ins Daten- bzw. Befehlsregister
LCD_RREG	EQU	H'0024'			;Zwischenspeicher Lesen aus dem Daten- bzw. Befehlsregister
;-----------------------------------------------------------------------------------------------------------
#define	LCD_BF		LCD_RREG,7		;BUSY Flag Position
;-----------------------------------------------------------------------------------------------------------
#define	LCD_E		PORTD,3			;steuert den Enable Eingang E der LCD
#define	LCD_ETRIS	TRISD,3
#define	LCD_RW_		PORTD,2			;1=Read, 0=Write
#define	LCD_RWTRIS	TRISD,2
#define	LCD_RS		PORTD,1			;Register Selektierung der LCD Anzeige
#define	LCD_RSTRIS	TRISD,1
#define	LCD_D7		PORTD,7			;Datenleitung D7 des 4-Bit Datenbus der LCD
#define	LCD_D7TRIS	TRISD,7
#define	LCD_D6		PORTD,6			;Datenleitung D6 des 4-Bit Datenbus der LCD
#define	LCD_D6TRIS	TRISD,6
#define	LCD_D5		PORTD,5			;Datenleitung D5 des 4-Bit Datenbus der LCD
#define	LCD_D5TRIS	TRISD,5
#define	LCD_D4		PORTD,4			;Datenleitung D4 des 4-Bit Datenbus der LCD
#define	LCD_D4TRIS	TRISD,4
;***********************************************************************************************************
;		MAKROS F�R DIE BANKSELEKTIERUNG
;-----------------------------------------------------------------------------------------------------------
BANK0		MACRO				;Bank 0 wird ausgew�hlt
		bcf	STATUS,RP0
		bcf	STATUS,RP1
		ENDM
;-----------------------------------------------------------------------------------------------------------
BANK1		MACRO				;Bank 1 wird ausgew�hlt
		bsf	STATUS,RP0
		bcf	STATUS,RP1
		ENDM
;-----------------------------------------------------------------------------------------------------------
BANK2		MACRO				;Bank 2 wird ausgew�hlt
		bcf	STATUS,RP0
		bsf	STATUS,RP1
		ENDM
;-----------------------------------------------------------------------------------------------------------
BANK3		MACRO				;Bank 3 wird ausgew�hlt
		bsf	STATUS,RP0
		bsf	STATUS,RP1
		ENDM	
;***********************************************************************************************************
;		MAKROS F�R KOMMUNIKATION MIT DER LCD ANZEIGE
;-----------------------------------------------------------------------------------------------------------
LCDCMD		MACRO	ADR			;�bertr�gt ADR ins Control oder Command Register der Anzeige
		movlw	ADR
		movwf	LCD_WREG
		call	LCD_WCNT		;�bertrage Daten ins Control oder Command Register 
		ENDM	
;-----------------------------------------------------------------------------------------------------------
LCDCHAR		MACRO	CHAR			;�bertr�gt CHAR ins Daten Register der Anzeige
		movlw	CHAR
		movwf	LCD_WREG
		call	LCD_WDATA		;�bertrage Daten ins Datenregister
		ENDM	
;-----------------------------------------------------------------------------------------------------------
LCDREG		MACRO	REG			;�bertr�gt den Inhalt von REG ins Daten Register der Anzeige
		movf	REG,W
		movwf	LCD_WREG
		call	LCD_WDATA		;�bertrage Daten ins Datenregister
		ENDM
