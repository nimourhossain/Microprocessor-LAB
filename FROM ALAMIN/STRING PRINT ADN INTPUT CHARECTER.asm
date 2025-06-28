
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h



; add your code here    
.STACK 100H
.DATA
STR DB 'L LOVE BANGLADESH$' 

.CODE 
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    MOV AH,9
    LEA DX,STR
    INT 21H  
    
    
    MOV AH,2
    MOV DL,10
    INT 21H
    
    MOV AH,2
    MOV DL,13
    INT 21H 
    
    MOV AH,1 
    INT 21H
    MOV BL,AL  
    
    
    MOV AH,2
    MOV DL,10
    INT 21H
    
    MOV AH,2
    MOV DL,13
    INT 21H
 
    
    MOV AH,2
    MOV DL,BL
    INT 21H

ret




