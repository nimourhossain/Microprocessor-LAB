
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here 
.MODEL SMALL
.STACK 100H

.DATA
AR DB 1,2,3,4

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    AND SI,0 
    MOV CX,4
    
    LEVEL1:
    MOV AH,2
    MOV AL,AR[SI]
    ADD AL,48
    MOV DL,AL 
    INC SI
    INT  21H
    LOOP LEVEL1
    

ret




