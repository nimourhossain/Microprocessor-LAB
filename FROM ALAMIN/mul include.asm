
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

; add your code here

.data 

a dw ?
b dw ?

.code

start:
print "Enter the 1st number : "
call scan_num
mov a,cx

printn

print "enter the 2nd number :"
call scan_num
mov b,cx
printn

mov ax,a

mov bx,b

mul bx 
 
print "MUL : "
call print_num_uns 
 
ret
define_scan_num
define_print_num_uns
define_get_string
define_print_string



