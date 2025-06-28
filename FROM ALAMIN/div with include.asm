
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

; add your code here 
.data


.code

start:
print "Enter the divident :"
call scan_num
printn

mov ax,cx


print "Enter the divisor :"
call scan_num
printn

mov bx,cx


xor dx,dx

div bx



printn

print "Out put :"
call print_num_uns


printn


print "reminder :"
mov ax,dx

call print_num_uns




exit:
mov ah,4ch

define_scan_num
define_print_num
define_print_num_uns
define_get_string
define_print_string




