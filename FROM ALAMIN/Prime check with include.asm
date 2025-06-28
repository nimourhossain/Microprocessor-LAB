#check a number is prime or not

include 'emu8086.inc'

org 100h

jmp start


start:
        
        print "Enter n "
        
        call scan_num
        mov ax,cx
        mov si,cx
        mov bx,2
        
        check:
            xor dx,dx
            div bx 
            mov ax,cx 
            cmp dx,0
            je output
            
            inc bx
            cmp bx,si
            jne check
            
        
        
            
        printn
        print "Prime" 
        mov ah,4ch
        int 21h
        
        output:
            printn
            print "Not Prime" 
             
        
define_scan_num
define_print_num
define_print_num_uns
end   