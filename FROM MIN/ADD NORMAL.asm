
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here   
 ;INPUT TAKE

MOV AH,1  


INT 21H
MOV BL,AL


INT 21H                                        
MOV BH,AL 


ADD BL,BH   ;BL=BL+BH    



;FOR PRINT NOW
MOV AH,2  
SUB BL,48
MOV DL,BL  
INT 21H
             
                       
                       
                       
                       
                       
ret




