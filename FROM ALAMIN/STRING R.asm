
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here 

.MODEL SMALL
.STACK 100H


.CODE 
MAIN PROC 
    MOV CH,0
    MOV CL,0

INPUT:
MOV AH,1
INT 21H
CMP AL,13
JE NEWLINE
MOV DX,0
MOV DL,AL 
PUSH DX 
INC CL
JMP INPUT 


NEWLINE:
MOV AH,2
MOV DL,10
INT 21H

MOV AH,2
MOV DL,10
INT 21H



PRINT:
AND DX,0
POP DX
MOV AH,2  
INT 21H 
LOOP PRINT



ret




