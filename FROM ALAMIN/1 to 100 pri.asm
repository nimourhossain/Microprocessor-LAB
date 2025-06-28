.MODEL SMALL
.STACK 100H

.DATA
    NL DB 13, 10, '$'     ; Newline characters

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV SI, 2             ; Start from 2, as 1 is not prime

NEXT_NUM:
    CMP SI, 100
    JA DONE               ; If SI > 100, end

    ; ===== PRIME CHECK BEGIN =====
    MOV BX, SI            ; Copy current number to BX
    MOV CX, 2             ; Divisor starts from 2
    MOV AL, 1             ; Assume number is prime

CHECK_DIV:
    MOV AX, BX
    XOR DX, DX            ; Clear DX before division
    DIV CX                ; AX / CX ? Quotient in AX, Remainder in DX
    CMP DX, 0
    JE NOT_PRIME          ; If divisible (remainder 0), not a prime

    INC CX
    CMP CX, BX
    JL CHECK_DIV          ; Check until CX < BX

    ; ===== PRIME FOUND =====
    ; Print the number

    ; Convert number to ASCII and print
    PUSH SI               ; Save SI

    MOV AX, SI
    CALL PRINT_NUM

    ; Print newline
    LEA DX, NL
    MOV AH, 9
    INT 21H

    POP SI                ; Restore SI
    JMP NEXT

NOT_PRIME:
    ; Not a prime number, just continue
    JMP NEXT

NEXT:
    INC SI
    JMP NEXT_NUM

DONE:
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; ===== PRINT_NUM: Print number in AX =====
; AX contains number to print (0-65535)

PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX            ; CX = 0 (digit count)

    MOV BX, 10

REVERSE_LOOP:
    XOR DX, DX
    DIV BX                ; AX / 10 ? Quotient in AX, Remainder in DX
    PUSH DX               ; Save remainder (digit)
    INC CX                ; Count digits
    CMP AX, 0
    JNE REVERSE_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN
