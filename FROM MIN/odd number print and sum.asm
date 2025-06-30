.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 10,13, 'ODD NUMBERS:$'
MSG2 DB 10,13, 'SUM = $'
NEWLINE DB 10,13,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print header
    MOV AH, 9
    LEA DX, MSG1
    INT 21H

    ; Registers:
    ; CX = counter from 1 to 20
    ; BX = sum
    ; DL = current odd number

    MOV CX, 1      ; Start from 1
    MOV BX, 0      ; Sum = 0

PRINT_ODD:
    ; Check if odd: (number mod 2) ? 0
    MOV AX, CX
    MOV DX, 0
    MOV SI, 2
    DIV SI         ; AX / 2 ? remainder in DX
    CMP DX, 0
    JE SKIP        ; If even, skip

    ; Print the odd number
    MOV AX, CX
    CALL PRINT_NUM
    CALL PRINT_SPACE

    ; Add to sum
    ADD BX, CX

SKIP:
    INC CX
    CMP CX, 20
    JLE PRINT_ODD

    ; New line
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H

    ; Print sum message
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    ; Print the sum in BX
    MOV AX, BX
    CALL PRINT_NUM

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP

;-----------------------------
; Subroutine: PRINT_NUM
; Input: AX contains the number to print
;-----------------------------
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX        ; Digit counter
    MOV BX, 10

PRINT_LOOP:
    XOR DX, DX
    DIV BX            ; AX / 10
    PUSH DX           ; Store remainder
    INC CX
    CMP AX, 0
    JNE PRINT_LOOP

PRINT_DIGITS:
    POP DX
    ADD DL, 30h
    MOV AH, 2
    INT 21H
    LOOP PRINT_DIGITS

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

;-----------------------------
; Subroutine: PRINT_SPACE
;-----------------------------
PRINT_SPACE PROC
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    RET
PRINT_SPACE ENDP

END MAIN
