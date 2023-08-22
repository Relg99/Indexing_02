;---------------------------------------------------------;
;                                                         ;
;Author:	 Relg99                                   ;
;Date:		 21/08/23                                 ;
;                                                         ;
;                                                         ;
;Program:	Indexing_02                               ;
;                                                         ;
;Description:                                             ;
;                                                         ;
;Control level of water inside a tank.                    ;
;Sensors:	Empty(A0), full(A1), overflow(A2).        ;
;Water pumps:	WP1(B5), WP2(B6).                         ;
;Indicators: 	Empty(B0), filling up(B1), full(B2),      ;
;		overflow(B3), Alarm(B4).                  ;
;                                                         ;
;                                                         ;
;                     _______________________________     ;
;                    / _____________________________ \    ;
;                   / /      ______________         \ \   ;
;                   | |     / ____________ \	    | |	  ;
;                   | |    / /            \ \       | |   ;
;                   | |    | |            | |       | |   ;
;                                        _|_|_     _|_|_  ;
;	|---------overflow------|	/     \   /     \ ;
;       |			|       | WP1 |   | WP2 | ;
;       |--------full-----------|       \_____/   \_____/ ;
;       |			|                         ;
;       |			|                         ;
;       |			|                         ;
;       |--------empty----------|                         ;
;       |_______________________|                         ;
;                                                         ;
;                                                         ;
;1. If the tank is empty both water pumps will activate.  ;
;   The "Empty" indicator will turn on.                   ;
;2. When the water gets to the empty level and touches    ;
;   the empty sensor the "Filling up" indicator will turn ;
;   on, turning off the "Empty" indicator.                ;
;3. If the water gets to the full sensor the WP2 will turn;
;   off. The "Full" indicator will turn on.               ;
;4. Finally, if the water gets to the overflow sensor     ;
;   both WP1 and WP2 will shut down and the "Overflow"    ;
;   indicator will shine.	                          ;
;                                                         ;
;---------------------------------------------------------;




#include "p16f628a.inc"

	__CONFIG _CP_OFF & _CPD_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _PWRTE_OFF & _WDTE_OFF & _FOSC_INTOSCIO


	LIST P=16F628A

	ORG	0x00
	

	CLRF	PORTA
	CLRF	PORTB

	MOVLW	0x07
	MOVWF	CMCON

	BSF	STATUS,RP0
	BCF	STATUS,RP1

	MOVLW	0x1F
	MOVWF	TRISA

	MOVLW	0x00
	MOVWF	TRISB

	BCF	STATUS,RP0
	BCF	STATUS,RP1

main:

	MOVF	PORTA,W
	MOVWF	PORTB

	GOTO	main

	END
