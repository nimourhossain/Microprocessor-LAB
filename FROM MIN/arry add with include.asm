
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

; add your code here
.data
count dw ?
arr dw 100 dup(?)


.code

start:
print "Enter how many number : "
call scan_num
printn

mov count,cx
mov dx,0

mov bx,cx
mov si,0
print "Enter the number "  

input:
call scan_num
printn
mov arr[si],cx 
add dx,cx
add si,2
dec bx
cmp bx,0
jne input:



print "output :"
mov si,0
mov bx,count

output: 
printn
mov ax,arr[si]
call print_num_uns  
printn
add si,2
dec bx
cmp bx,0
jne output

printn

print "sumation is :" 
mov ax,dx
call print_num_uns

exit:
mov ah,4ch                             





define_scan_num
define_print_num
define_print_num_uns
define_get_string
define_print_string
end



