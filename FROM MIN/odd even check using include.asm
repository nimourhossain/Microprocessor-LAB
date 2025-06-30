
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include 'emu8086.inc'
org 100h

; add your code here 

.data

.code


print "Enter the number : "
                              
call scan_num

mov bx,cx

printn


test bx,1
jE EVEN


print "ODD NUMBER" 
jmp exit


EVEN:
print "Even "

exit:
mov ah,4ch

 
define_scan_num
define_print_num_uns
define_get_string
define_print_string
end



