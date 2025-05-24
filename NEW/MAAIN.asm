include 'emu8086.inc'
org 100h

jmp start


start:

print "Enter n numbers: "
call scan_num
mov bx,0

printn
print "input the number" 
printn
mov si,cx

input_loop:
call scan_num
add bx,cx
printn
dec si
jnz input_loop

print "Total: "
mov ax,bx
call print_num
printn 

mov ah,4ch
int 21h

define_scan_num
define_print_num
define_print_num_uns
define_get_string

end