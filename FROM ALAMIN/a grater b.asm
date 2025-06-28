
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

; add your code here
.data 


.code

start:
 print "enter the number " 
 call scan_num
 mov bx,cx
 printn
 
 print "Enter the 2nd number :" 
 call scan_num
 mov dx,cx
 
 printn
 
 
 
 cmp bx,dx 
 jg biga
 
 mov ax,dx
 call print_num_uns
 
jmp exit

biga:
mov ax,bx
call print_num_uns
 
 

 

exit:
mov ah,4ch


define_scan_num
define_print_num_uns
define_print_string
define_get_string