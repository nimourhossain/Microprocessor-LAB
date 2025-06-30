org 100h

.model small
.stack 100h
.code
start:

    ; Take one character input
    mov ah, 1
    int 21h             ; AL = ASCII of digit
    sub al,48        ; Convert ASCII to number

    mov bl, 2
    xor ah, ah          ; Clear AH before DIV
    div bl              ; AL / BL ? AL=quotient, AH=remainder

    cmp ah, 0
    je EVEN             ; If remainder = 0 ? even

ODD:
    mov ah, 2
    mov dl, '1'         ; Print 1 for odd
    int 21h
    jmp EXIT

EVEN:
    mov ah, 2
    mov dl, '0'         ; Print 0 for even
    int 21h

EXIT:
    mov ah, 4ch
    int 21h
