	ORG 0x00
CONT EQU 0x20
CONT1 EQU 0x21
CONT2 EQU 0x22
CONTINI EQU 248


DIGA EQU 0x30
DIGB EQU 0x31
DIGC EQU 0x32
DIGD EQU 0x33

INICIO:

	CLRF DIGA
	CLRF DIGB
	CLRF DIGC
	CLRF DIGD
	
	MOVLW TRISd
	MOVWF FSR
	CLRF INDF
	MOVLW TRISa
	MOVWF FSR
	CLRF INDF
	MOVLW 0x00
	MOVWF PORTA

CONTA
	
	CALL DELAY_S
	BTFSC 0x34,0
	GOTO CONTA
	INCF DIGA, F
	MOVLW 10
	SUBWF DIGA, W
	BTFSS STATUS,Z
	GOTO CONTA
	CLRF DIGA
	INCF DIGB, F
	MOVLW 10
	SUBWF DIGB, W
	BTFSS STATUS,Z
	GOTO CONTA
	CLRF DIGB
	INCF DIGC, F
	MOVLW 10
	SUBWF DIGC, W
	BTFSS STATUS,Z
	GOTO CONTA
	CLRF DIGC
	INCF DIGD, F
	MOVLW 10
	SUBWF DIGD, W
	BTFSS STATUS,Z
	GOTO CONTA
	CLRF DIGD
	GOTO CONTA	

MOSTRA
	BTFSC PORTB, 4; BOTAO B4 INICIA A CONTAGEM
	BSF 0x34, 0
	BTFSC PORTB, 3; BOTAO B3 FAZ PAUSAR A CONTAGEM
	BCF 0x34, 0
	BTFSC PORTB, 5; BOTAO B5 ZERA A CONTAGEM
	GOTO INICIO
	MOVFW DIGA
	CALL DIG
	MOVWF PORTD
	BSF PORTA, 5
	BCF PORTA,5	
	MOVFW DIGB
	CALL DIG
	MOVWF PORTD
	BSF PORTA, 4
	BCF PORTA, 4	
	MOVFW DIGC
	CALL DIG
	MOVWF PORTD
	BSF PORTA, 3
	BCF PORTA,3	
	MOVFW DIGD
	CALL DIG
	MOVWF PORTD
	BSF PORTA, 2
	BCF PORTA,2
	RETURN	


	
;	MOVFW 0x22
;	CALL DIG
;	MOVWF PORTB
;	INCF 0x22,F
;	MOVLW 10
;	SUBWF 0x22,W
;	BTFSS STATUS,Z
;	GOTO CONTA
FIM
	GOTO FIM
LOOP0		
	CALL DELAY_S
	MOVLW 0x01    ;1
	MOVWF PORTB   ;1

	
LOOP
	CALL DELAY_S
	RLF PORTB,F   ;1
	BTFSC PORTB,7 ;1
	GOTO LOOP0    ;2
	GOTO LOOP			
	
	
	
	
DELAY_MS
	CALL MOSTRA
	MOVLW CONTINI
	MOVWF CONT
	NOP
	NOP
	NOP
DELAY_LOOP
	NOP
	DECFSZ CONT,F
	GOTO DELAY_LOOP
	RETURN	

DELAY_100MS
	MOVLw 100
	MOVWF CONT1
DELAY_100MS_LOOP
	CALL DELAY_MS
	DECFSZ CONT1,F
	GOTO DELAY_100MS_LOOP	
	RETURN

DELAY_S
	MOVLW 10
	MOVWF CONT2
DELAY_S_LOOP
	CALL DELAY_100MS
	DECFSZ CONT2,F
	GOTO DELAY_S_LOOP
	RETURN
	
DIG	ADDWF	PCL,F	
DIG0	RETLW 0x3F
DIG1	RETLW 0x06
DIG2	RETLW 0x5b
DIG3	RETLW 0x4F
DIG4	RETLW 0x66
DIG5	RETLW 0x6D
DIG6	RETLW 0x7D
DIG7	RETLW 0x07
DIG8	RETLW 0x7F
DIG9	RETLW 0x6F