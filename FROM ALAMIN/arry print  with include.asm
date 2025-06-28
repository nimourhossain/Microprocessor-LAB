include 'emu8086.inc'
org 100h

.data
count dw ?
arr dw 100 dup(?)   ; 100?? word ????? ????? ?????

.code

start:

    print "Enter the number of array: " 
    call scan_num
    mov count, cx 
    mov bx, cx
    printn

    mov si, 0

    ; ????? ?????? ???
    print "Enter numbers:"
    printn

input:
    call scan_num  
    printn
    mov arr[si], cx
    add si, 2            ; ???? ??????? word 2 byte
    dec bx 
    cmp bx, 0
    jne input

    ; ?????? ??????? ???? ????
    printn                    
    
    print "You entered: "
    printn

    mov si, 0
    mov bx, count

output:
    mov ax, arr[si]
    call print_num_uns
    printn
    add si, 2
    dec bx
    cmp bx, 0
    jne output

    ; Program exit
    mov ah, 4ch
    int 21h

define_scan_num
define_print_num
define_print_num_uns
define_get_string
define_print_string
end
