;************************************************************************************************************
;		ROUTINE ZUR PROGRAMMVERZ�GERUNG VON 20MS BEI FOSC=20MHz
;------------------------------------------------------------------------------------------------------------
WAIT20000	movlw	D'130'
		movwf	WAIT2
		movlw	D'221'
		movwf	WAIT1
WAIT20000_1	decfsz	WAIT1,F
		goto	WAIT20000_1
		decfsz	WAIT2,F
		goto	WAIT20000_1
		retlw	.0
;***********************************************************************************************************
;		LCD ANZEIGE INITIALISIERUNG
;-----------------------------------------------------------------------------------------------------------
LCD_INIT	BANK1				;Wechsle in Bank 1
		bcf	LCD_RSTRIS		;RS-Leitung wird ein Ausgang
		bcf	LCD_RWTRIS		;RW-Leitung wird ein Ausgang
		bcf	LCD_ETRIS		;E-Leitung wird ein Ausgang
		bcf	LCD_D7TRIS
		bcf	LCD_D6TRIS
		bcf	LCD_D5TRIS
		bcf	LCD_D4TRIS
		BANK0				;Wechsle in Bank 0
;-----------------------------------------------------------------------------------------------------------
		bcf	LCD_RW_			;Schreiben aktivieren
;-----------------------------------------------------------------------------------------------------------
		call	WAIT20000		;20ms lang warten
;-----------------------------------------------------------------------------------------------------------
		bcf	LCD_RS			;Kontrollregister selektieren
		bcf	LCD_D7
		bcf	LCD_D6
		bsf	LCD_D5
		bsf	LCD_D4
		call	LCD_FLN			;an E eine negative Flanke anlegen
;-----------------------------------------------------------------------------------------------------------
		call	WAIT20000		;20ms lang warten
;-----------------------------------------------------------------------------------------------------------
		call	LCD_FLN			;an E eine negative Flanke anlegen
;-----------------------------------------------------------------------------------------------------------
		call	WAIT20000		;20ms lang warten
;-----------------------------------------------------------------------------------------------------------
		call	LCD_FLN			;an E eine negative Flanke anlegen
;-----------------------------------------------------------------------------------------------------------
		call	WAIT20000		;20ms lang warten
;-----------------------------------------------------------------------------------------------------------
		bcf	LCD_D4
		call	LCD_FLN			;an E eine negative Flanke anlegen
;-----------------------------------------------------------------------------------------------------------
		call	WAIT20000		;20ms lang warten
;-----------------------------------------------------------------------------------------------------------
		LCDCMD	0x01			;Display l�schen und Corsor auf Ursprungsposition (0, 0)
;-----------------------------------------------------------------------------------------------------------
		LCDCMD	0x02			;Cursor Home (dieser Befehls ist nicht unbedingt notwendig)
;-----------------------------------------------------------------------------------------------------------
		LCDCMD	0x06			;I/D=1(Auto Increment der Zeichen Adresse),S=0(Schieben OFF)
;-----------------------------------------------------------------------------------------------------------
		LCDCMD	0x0C			;Display ON, Cursor OFF, Blinking OFF
;-----------------------------------------------------------------------------------------------------------
		LCDCMD	0x28			;2 Zeilen, Schriftgr��e 5x7 Dots
;-----------------------------------------------------------------------------------------------------------
		retlw	.0			;Gehe zum Hauptprogramm
;***********************************************************************************************************
;		DAS DATEN REGISTER DER LCD ANZEIGE WIRD MIT DEM INHALT VON LCD_WREG BESCHRIEBEN
;-----------------------------------------------------------------------------------------------------------
LCD_WDATA	
        call	LCD_WAITBUSY		;Wartet bis BF "0" ist
		bsf	LCD_RS
		call	LCD_WHNIBBLE		;�bertrage High Nibble
		call	LCD_WLNIBBLE		;�bertrage Low Nibble
		retlw	.0
;***********************************************************************************************************
;		DAS CONTROL BZW. BEFEHLSREGISTER DER ANZIGE WIRD MIT DEM INHALT VON LCD_WREG BESCHRIEBEN
;-----------------------------------------------------------------------------------------------------------
LCD_WCNT	
        call	LCD_WAITBUSY		;Wartet bis BF "0" ist
		bcf	LCD_RS
		call	LCD_WHNIBBLE		;�bertrage High Nibble
		call	LCD_WLNIBBLE		;�bertrage Low Nibble
		retlw	.0
;***********************************************************************************************************
;		�BERTR�GT DAS HIGH NIBBLE VON LCD_WREG ZUR LCD ANZEIGE
;-----------------------------------------------------------------------------------------------------------
LCD_WHNIBBLE	
        BANK1
		bcf	LCD_D7TRIS
		bcf	LCD_D6TRIS		;Bestimme Ausg�nge
		bcf	LCD_D5TRIS
		bcf	LCD_D4TRIS
		BANK0				;Wechsle in Bank 0
		bcf	LCD_RW_			;RW\ Leitung umschalten auf Schreiben
		bcf	LCD_D7
		btfsc	LCD_WREG,7
		bsf	LCD_D7
		bcf	LCD_D6
		btfsc	LCD_WREG,6
		bsf	LCD_D6
		bcf	LCD_D5
		btfsc	LCD_WREG,5
		bsf	LCD_D5
		bcf	LCD_D4
		btfsc	LCD_WREG,4
		bsf	LCD_D4
		call	LCD_FLN			;an E eine negative Flanke anlegen
		retlw	.0
;***********************************************************************************************************
;		�BERTR�GT DAS LOW NIBBLE VON LCD_WREG ZUR LCD ANZEIGE
;-----------------------------------------------------------------------------------------------------------
LCD_WLNIBBLE	
        BANK1				;Wechsle in Bank 1
		bcf	LCD_D7TRIS
		bcf	LCD_D6TRIS		;mache alle Datenleitungen zu Ausg�ngen
		bcf	LCD_D5TRIS
		bcf	LCD_D4TRIS
		BANK0				;Wechsle in Bank 0
		bcf	LCD_RW_			;RW\ Leitung umschalten auf schreiben
		bcf	LCD_D7
		btfsc	LCD_WREG,3
		bsf	LCD_D7
		bcf	LCD_D6
		btfsc	LCD_WREG,2
		bsf	LCD_D6
		bcf	LCD_D5
		btfsc	LCD_WREG,1
		bsf	LCD_D5
		bcf	LCD_D4
		btfsc	LCD_WREG,0
		bsf	LCD_D4
		call	LCD_FLN			;an E eine negative Flanke anlegen
		retlw	.0
;***********************************************************************************************************
;		LIEST DAS CONTROL BYTE DER LCD ANZEIGE UND SCHREIBT DIESES IN LCD_RREG
;-----------------------------------------------------------------------------------------------------------
LCD_RCNT	
        BANK1				;Wechsle in Bank 1
		bsf	LCD_D7TRIS		;mache alle Datenleitungen zu Eing�ngen
		bsf	LCD_D6TRIS
		bsf	LCD_D5TRIS
		bsf	LCD_D4TRIS
		BANK0				;Wechsle in Bank 0
		bsf	LCD_RW_			;Am Ausgang LCD_RW_ wird High angelegt also es wird gelesen
		bcf	LCD_RS			;Control Register ausw�hlen
		call	LCD_FLP			;Gibt Datenaustausch frei
		bcf	LCD_RREG,7
		bcf	LCD_RREG,6
		bcf	LCD_RREG,5
		bcf	LCD_RREG,4
		btfsc	LCD_D7
		bsf	LCD_RREG,7
		btfsc	LCD_D6
		bsf	LCD_RREG,6
		btfsc	LCD_D5
		bsf	LCD_RREG,5
		btfsc	LCD_D4
		bsf	LCD_RREG,4
		call	LCD_FLP
		bcf	LCD_RREG,3
		bcf	LCD_RREG,2
		bcf	LCD_RREG,1
		bcf	LCD_RREG,0
		btfsc	LCD_D7
		bsf	LCD_RREG,3
		btfsc	LCD_D6
		bsf	LCD_RREG,2
		btfsc	LCD_D5
		bsf	LCD_RREG,1
		btfsc	LCD_D4
		bsf	LCD_RREG,0
		retlw	.0
;***********************************************************************************************************
;		LCD_WAITBUSY WARTET BIS DIE LCD ANZEIGE WIEDER BEREIT IST DATEN BZW. BEFEHLE ZU VERARBEITEN
;-----------------------------------------------------------------------------------------------------------
LCD_WAITBUSY	
        call	LCD_RCNT		;Liest das Control Register der LCD Anzeige nach LCD_RREG
		btfsc	LCD_BF			;Schau ob BUSY Flag LOW ist
		goto	LCD_WAITBUSY		;Wenn BUSY FLAG High ist dann warte
		retlw	.0			;Wenn BUSY FLAG LOW ist dann spring zur�ck
;***********************************************************************************************************
LCD_FLN	
    	bsf	LCD_E			;die Pulsdauer von E muss mindestens 450ns lang dauern
		nop
		nop
		bcf	LCD_E
		retlw	.0
;***********************************************************************************************************
LCD_FLP		
        bcf	LCD_E
		bsf	LCD_E
		retlw	.0