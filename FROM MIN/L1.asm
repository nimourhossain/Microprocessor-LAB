
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

       MOV AH,1    ;tAKE INPUT
      INT 21H  
      
      
       ;PUTC 10  
        ;PUTC 13   
        PRINTN ""    ;FOR NEW LINE
 
       MOV AH,2
       MOV DL,AL      ;OUTPUT  
       INT 21H
ret



