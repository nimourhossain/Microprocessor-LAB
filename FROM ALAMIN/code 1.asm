
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

 MOV CX,5H 
 MOV AX,0000H
 
 HERE:  
 MOV BX, CX
 MOV AX,0000H
  
 CALC:  
 
    ADD AX,BX
    DEC BX
    JNZ CALC   
 CALL PRINT_NUM_UNS
 PUTC 10  
 PUTC 13
 DEC CX
 JNZ HERE
 
 

ret

DEFINE_PRINT_NUM_UNS

