
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here         

 MOV CX,26
 MOV AH,2
 MOV DL,'A'    
 
 LEVEL1:
 INT 21H
 INC DL
 LOOP LEVEL1
   
 
  
  
  

ret




