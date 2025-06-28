include 'emu8086.inc'   ; Include standard macros and procedures
org 100h               ; Set program start address at 100h (COM file)

MOV CX, 15             ; Set max odd number to 15
MOV AX, 0              ; Clear AX to store sum = 0
MOV BX, 1              ; Start BX with first odd number = 1

NEXT_ODD:
    ADD AX, BX        ; Add current odd number (BX) to sum (AX)

    MOV DX, AX        ; Move sum to DX for printing
    CALL PRINT_NUM_UNS ; Print unsigned number in DX (running sum)
    PUTC 10           ; Print line feed (new line)
    PUTC 13           ; Print carriage return (new line)

    ADD BX, 2         ; Move BX to next odd number (increase by 2)
    CMP BX, CX        ; Compare current odd number (BX) with max (15)
    JG END_LOOP       ; If BX > 15, jump to end
    JMP NEXT_ODD      ; Otherwise, repeat loop

END_LOOP:
RET                   ; Return from program

DEFINE_PRINT_NUM_UNS   ; Include print procedure for unsigned numbers
