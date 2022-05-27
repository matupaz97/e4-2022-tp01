/**
 * Referencias importantes:
 * https://developer.arm.com/documentation/dui0552/a
 * https://github.com/ARM-software/abi-aa/tree/main/aapcs32
 */
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.macro defun nombre
    .section .text.\nombre
    .global \nombre
    .type \nombre, %function
\nombre:
.endm

.macro endfun nombre
    .size \nombre, . - \nombre
.endm

defun copiaMemoria
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitud
    cmp R2, #0
    beq 0f
1:    
    ldrb R3, [R0], #1
    strb R3, [R1], #1
    sub R2, #1
    cmp R2, #0
    bne 1b
0:    
    bx lr
endfun copiaMemoria

defun copiaCadena
    // Implementación aquí
    // R0: origen, R1: destino, R2: longitudMaxima
    //R4 longitud de cadena de trabajo
    push {R4,LR} 
    mov R4 , #0x01
0:
    tst R2, #(-1)
    beq 1f
    ldrb R3,[R0],#1
    cmp R3 , #0x00
    beq 1f
    cmp R4, R2
    beq 0b
    strb R3,[R1],#1
    add R4,R4,#1 
    b 0b
1:
    mov R3, #0x00
    strb R3, [R1]
    pop {R4,PC}
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    push {R1, LR}
    cbz R1, terminar

main:
    ldrb R2, [R0], #1
    cmp R2, #0x00 
    beq terminar
    cmp R2, #97 
    blt contadormay
    cmp R2, #122
    bgt contadormay
    sub R2, #32
    sub R0, #1
    strb R2, [R0], #1

contadormay:
    subs R1, #1
    beq terminar 
    bl main

terminar:
    pop {R1, PC}
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    push {R1, LR}
    cbz R1, final

main2:
    ldrb R2, [R0], #1
    cmp R2, #0x00
    beq final
    cmp R2, #65 
    blt contadormin
    cmp R2, #90 
    bgt contadormin
    add R2, #32
    sub R0, #1
    strb R2, [R0], #1

contadormin:
    subs R1, #1
    beq final 
    bl main2

final:
    pop {R1, PC}
    bx lr
endfun minusculaEnLugar