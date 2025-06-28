
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

 
 MOV BH,0
 MOV BL,10



INPUT:
MOV AH,1
INT 21H
CMP AL,13
JNE NUMBER
JMP EXIT

NUMBER:
SUB AL,48
MOV CL,AL 
MOV AL,BH
MUL BL
ADD AL,CL
MOV BH,AL
JMP INPUT  

EXIT:


ret




