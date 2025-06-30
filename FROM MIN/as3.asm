
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here   
.DATA
sg DB 3
sg1 DB ?
.CODE
MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX  
    
    
     MOV ah,2 
     ADD sg,48  
    MOV DL,sg
    int 21h  
    
    
    MOV ah,1
    INT 21H
    MOV sg1,AL   
    
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    MOV AH,2 
    MOV DL, sg1
    INT 21H
    
    

ret




