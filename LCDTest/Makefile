# MPLAB IDE generated this makefile for use with GNU make.
# Project: LCDTest.mcp
# Date: Tue Dec 14 15:45:59 2021

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

LCDTest.cof : LCDTest.o
	$(CC) /p16F877A "LCDTest.o" /u_DEBUG /u_DEBUGCODESTART=0x1f00 /u_DEBUGCODELEN=0x100 /u_DEBUGDATASTART=0x1e5 /u_DEBUGDATALEN=0x6 /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /z__MPLAB_DEBUGGER_PK3=1 /z__ICD2RAM=1 /o"LCDTest.cof" /M"LCDTest.map" /W /x

LCDTest.o : LCDTest.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/p16f877a.inc ../LCD.asm ../LCDSUB.asm
	$(AS) /q /p16F877A "LCDTest.asm" /l"LCDTest.lst" /e"LCDTest.err" /d__DEBUG=1 /d__MPLAB_DEBUGGER_PK3=1

clean : 
	$(CC) "LCDTest.o" "LCDTest.hex" "LCDTest.err" "LCDTest.lst" "LCDTest.cof"

