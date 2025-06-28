.MODEL SMALL
.STACK 100H

.DATA
    NL DB 13, 10, '$'     ; New line characters

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 1             ; Start from 1

PRINT_LOOP:
    MOV AX, CX            ; Move current number to AX
    CALL PRINT_NUM        ; Print the number

    ; Print new line
    LEA DX, NL
    MOV AH, 9
    INT 21H

    INC CX
    CMP CX, 101           ; Stop at 100
    JNE PRINT_LOOP

    MOV AH, 4CH
    INT 21H
MAIN ENDP

; --------- PRINT_NUM: Prints number in AX ---------
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX
    MOV BX, 10

REVERSE_LOOP:
    XOR DX, DX
    DIV BX                ; AX / 10, remainder in DX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE REVERSE_LOOP

PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_DIGITS

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN
