
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here      
 
MOV AH,2
MOV CX,26
MOV DL,'A'

    LEVEL1:
    INT 21H
    INC DL
    LOOP LEVEL1 
    
    
MOV AH,2
MOV DL,10
INT 21H

MOV AH,2 
MOV DL,13
INT 21H 



MOV AH,2
MOV CX,26
MOV DL,'a'

    LEVEL2:
    INT 21H
    INC DL
    LOOP LEVEL2  


    
MOV AH,2
MOV DL,10
INT 21H

MOV AH,2 
MOV DL,13
INT 21H 



MOV CX,100
MOV AH,2
ADD DL,'0'
MOV DL,1

    LEVEL3:
    INT 21H
    INC DL
    LOOP LEVEL3




ret




