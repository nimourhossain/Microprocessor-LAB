org 100h

.DATA
    N1 DB ?
    N2 DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Read first digit and convert to number
    MOV AH, 1 
    INT 21H  
    SUB AL, '0'     ; Convert ASCII to number (same as SUB AL, 48)
    MOV N1, AL
    
    ; Read second digit and convert to number
    MOV AH, 1
    INT 21H  
    SUB AL, '0'
    MOV N2, AL
    
    ; Print new line (carriage return + line feed)
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
   
    ; Display first number (convert back to ASCII)
    MOV AH, 2
    MOV DL, N1
    ADD DL, '0'      ; Convert number to ASCII
    INT 21H
   
    ; Display second number (convert back to ASCII)
    MOV AH, 2
    MOV DL, N2
    ADD DL, '0'
    INT 21H  
   
    ; Print new line again
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H 
   
    ; Calculate and display sum
    MOV AL, N1
    ADD AL, N2       ; Add the numbers (not ASCII values)
    
    ; Display result (handle both single and double digits)
    CMP AL, 10
    JB SINGLE_DIGIT  ; If sum < 10
    
    ; Handle two-digit result
    MOV AH, 0        ; Clear AH for division
    MOV BL, 10
    DIV BL           ; AL = tens digit, AH = units digit
    
    PUSH AX          ; Save units digit
    ADD AL, '0'      ; Convert tens digit to ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H          ; Display tens digit
    
    POP AX
    MOV AL, AH       ; Get units digit
    
    SINGLE_DIGIT:
    ADD AL, '0'      ; Convert to ASCII
    MOV DL, AL
    MOV AH, 2
    INT 21H          ; Display units digit
   RET