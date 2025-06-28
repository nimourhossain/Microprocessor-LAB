
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here    
MOV AH,1
INT 21H
MOV BL,AL   

MOV AH,1
INT 21H
MOV CL,AL


MOV AH,2
MOV DL,BL
INT 21H

MOV AH,2
MOV DL,CL
INT 21H

ret




