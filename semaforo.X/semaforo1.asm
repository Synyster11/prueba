#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)
RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33
;inicio del programa:
 
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
;NOP ; NO AFECTA
 
CLRF PORTB
inicio:
    MOVLW b'00100001'
    MOVWF PORTB
    call cincosegundos  
    MOVLW b'00100010'
    MOVWF PORTB
    call unsegundo   
	nop ;EN 1 SEGUNDO, PRIMERA CORRIDA +1
	nop ;EN 1 SEGUNDO, PRIMERA CORRIDA +1
    MOVLW b'00001100'
    MOVWF PORTB
    call cincosegundos 
	;nop ;;EN 5 SEGUNDOs, SEGUNDA CORRIDA +1
	;nop ;;EN 5 SEGUNDOs, SEGUNDA CORRIDA +1
    MOVLW b'00010100'
    MOVWF PORTB
    call unsegundo   
    GOTO inicio
    
cincosegundos:
    ;bcf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 0
	nop ;EN 5 SEGUNDOS, EN CORRIDA 1 Y 2, +1
	nop 
	nop
	nop
	nop
	nop
	nop
	nop
    call cinco ;llamar a la rutina de tiempo
    ;nop ;NOPs de relleno (ajuste de tiempo)
    ;nop ;EN 5 SEGUNDOS, EN CORRIDA 1 Y 2, +1

     ;bsf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 1
    ;nop ;NOPs de relleno (ajuste de tiempo)

    cinco:
    movlw d'46' ;establecer valor de la variable k 
	; -1 = 6
    movwf m
    mloopl:
    decfsz m,f
    goto mloopl

    movlw d'101' ;establecer valor de la variable i
    movwf i
    iloopl:
    nop ;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    nop ;EN 5 SEGUNDOS, EN CORRIDA 1 Y 2, +202

    movlw d'89' ;establecer valor de la variable j 
    movwf j
    jloopl:
    nop ;NOPs de relleno (ajuste de tiempo)      ;NOP A EVALUAR EN 5 SEGUNDOS, EN CORRIDA 1 Y 2, +17978

    movlw d'91' ;establecer valor de la variable k 
    movwf k
    kloopl:
    decfsz k,f
    goto kloopl
    decfsz j,f
    goto jloopl
    decfsz i,f
    goto iloopl

    return ;salir de la rutina de tiempo y regresar al
    ;valor de contador de programa
 
unsegundo:
    ;bcf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 0

	nop;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +1
	nop
	nop
	nop
	nop
	nop 

    call uno ;llamar a la rutina de tiempo
    ;  nop ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +1

     ;bsf PORTB,0 ;poner el puerto B0 (bit 0 del puerto B) en 1
    ;nop ;NOPs de relleno (ajuste de tiempo)

    uno:
    movlw d'19' ;establecer valor de la variable k 
	; +1 = 6
    movwf m
    mloop:
    decfsz m,f
    goto mloop

     movlw d'108' ;establecer valor de la variable i
    movwf i
    iloop:
    nop ;NOPs de relleno (ajuste de tiempo)
    nop
    nop
    nop
    nop ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +216
    movlw d'60' ;establecer valor de la variable j ;60
    movwf j
    jloop:
    nop ;NOPs de relleno (ajuste de tiempo)  ;EN 1 SEGUNDO, EN CORRIDA 1 Y 2, +12960

    movlw d'24' ;establecer valor de la variable k 
    movwf k
    kloop:
    decfsz k,f
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop

    return ;salir de la rutina de tiempo y regresar al
    ;valor de contador de programa
END