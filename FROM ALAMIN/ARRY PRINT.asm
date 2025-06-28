
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here  


 .DATA
 AR DB 1,2,3
 
 .CODE
 MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX
    
  XOR SI, SI        ; SI = 0 (INDEX FOR ARRAY)
    MOV CX, 3         ; LOOP COUNTER = 3 ELEMENTS
    XOR BL, BL        ; BL = 0 (TO STORE SUM)
    
    LEVEL1:  
    MOV DL,AR[SI]
    ADD BL,DL  
    ADD DL,48
     
    MOV AH,2 
    INT 21H
    INC SI
    LOOP LEVEL1  
     
      
      MOV AH, 2
    MOV DL, 10         ; NEW LINE (LINE FEED)
    INT 21H
    MOV DL, 13         ; CARRIAGE RETURN
    INT 21H
     
     
    MOV AH,2
    ADD BL,48
    MOV DL,BL
    INT 21H
    


  









ret




