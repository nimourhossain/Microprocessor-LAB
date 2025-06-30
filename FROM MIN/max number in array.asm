; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

include 'emu8086.inc'
org 100h

.data
count dw ?
arr dw 100 dup(?)

.code

start:
    print "Enter how many number : "
    call scan_num
    printn

    mov count, cx
    mov bx, cx
    mov si, 0

    print "Enter the numbers:"
    printn

    ; ------ INPUT ------
    input:
        call scan_num
        printn
        mov arr[si], cx
        add si, 2
        dec bx
        cmp bx, 0
        jne input

    ; ------ PRINT OUTPUT ------
    printn
    print "You entered:"
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

    ; ------ FIND MAXIMUM ------
    printn
    print "Maximum number is: "
    mov si, 0
    mov cx, count
    mov ax, arr[si]    ; ????? ??????
    mov dx, ax         ; dx = maximum
    add si, 2
    dec cx             ; ????? ??? ??? ??????

    find_max:
        mov ax, arr[si]
        cmp ax, dx
        jle skip_update
        mov dx, ax
    skip_update:
        add si, 2
        loop find_max

    mov ax, dx
    call print_num_uns

    ; ------ EXIT ------
    mov ah, 4ch
    int 21h

define_scan_num
define_print_num
define_print_num_uns
define_get_string
define_print_string
end
