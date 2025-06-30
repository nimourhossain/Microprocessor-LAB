                          
# a program to find 1 to 100 prime number:
include 'emu8086.inc'

org 100h

jmp start


start:
        
        
        
    print " A programm to find 1 to 100 prime number :"
    printn
    
    mov cx,3
    
    ready:
        
        mov si,cx
        mov ax,cx
        
        mov bx,2
        
        inner_loop:
                 xor dx,dx
                 div bx
                 cmp dx,0
                 je skipped
                 
                 inc bx
                 mov ax,si
                 cmp bx,si
                 jl inner_loop
        
        mov ax,cx
        call print_num
        printn        
        skipped:
        inc cx
        cmp cx,100
        jle ready
                
        
define_scan_num
define_print_num
define_print_num_uns
end   