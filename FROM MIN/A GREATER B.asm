
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here  

.MODEL SMALL
.STACK 100H
.DATA
A DB ?
B DB ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    
    MOV AH,1
    INT 21H
    MOV A,AL
    
    
    MOV AH,1
    INT 21H
    MOV B,AL
    
     MOV BL,A
    CMP BL,B
    JNBE BIGA
    
    MOV AH,2
    
    MOV DL,B
    INT 21H  
    RET
    
    
    BIGA:
    MOV AH,2
    
    MOV DL,A
    INT 21H

ret




