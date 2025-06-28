
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here    
.STACK 100H
.DATA 
SG1 DB 3
SG2 DB ?
.CODE
MAIN PROC
   MOV AX,@DATA
    MOV DS,AX 
    
   MOV AH,2
   ADD SG1,48
   MOV DL,SG1
   INT 21H   
   
   MOV AH,2
   MOV DL,10
   INT 21H 
   
   MOV AH,2
   MOV DL,13
   INT 21H
   
   
   MOV AH,1
   MOV SG2,AL
   INT 21H 
   
   MOV AH,2
   ADD SG2,48
   MOV DL,AL
   INT 21H
               
               
 



ret




