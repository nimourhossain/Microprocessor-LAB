
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here    
.code 

MOV BL,0

MOV AH,1
INT 21H


CMPLOOP:
CMP AL,0DH
JE ENDLOOP 
INC BL

AGAINLOOP:
MOV AH,1
INT 21H
 
LOOP CMPLOOP

ENDLOOP: 

MOV AH,2
MOV DL,10
INT 21H

MOV AH,2
MOV DL,13
INT 21H




MOV AH,2  
MOV DL,BL
ADD DL,48
INT 21H



ret




