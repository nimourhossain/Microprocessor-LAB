
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
AND AX,0 
MOV AL,BH
MOV CL,10
MOV BX,0000H

    STORE:
    DIV CL
    MOV [0000H+BX],AH
    ADD BX,2H
    MOV AH,0
    CMP AL,0
    JNE STORE
    
    
    MOV AH,2
    MOV DL,10
    INT 21H 
    
    MOV AH,2
    MOV DL,13
    INT 21H
    
    PRINT:
    SUB BX,2H 
    MOV DL,[0000H+BX]
    ADD DL,48
    INT 21H
    CMP BX,0
    JNE PRINT
    





ret




