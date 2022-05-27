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
    cmp R2, #0
    beq 0f
1:
    ldrb R3, [R0], #1
    cmp R3, #0
    beq 2f
    strb R3, [R1], #1
    sub R2, #1
    cmp R2, #0
    bne 1b
2:
    mov R0, #0x00
    strb R0, [R1, #-1]
0:  
    bx lr
endfun copiaCadena

defun mayusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1, #0
    beq 0f
4:
    mov R3, #0x61
    ldrh R2, [R0]
1:
    cmp R2,R3
    beq 3f
    add R3, #1
    cmp R3, #0x7B
    bne 1b
    beq 2f
3:
    sub R2, #0x20    
2:
    strh R2, [R0], #2
    sub R1, #1
    cmp R1, #0
    bne 4b
0:    
    bx lr
endfun mayusculaEnLugar

defun minusculaEnLugar
    // Implementación aquí
    // R0: cadena, R1: longitudMaxima
    cmp R1, #0
    beq 0f
4:
    mov R3, #0x41
    ldrh R2, [R0]
1:
    cmp R2,R3
    beq 3f
    add R3, #1
    cmp R3, #0x5B
    bne 1b
    beq 2f
3:
    add R2, #0x20    
2:
    strh R2, [R0], #2
    sub R1, #1
    cmp R1, #0
    bne 4b
0:
    bx lr
endfun minusculaEnLugar
