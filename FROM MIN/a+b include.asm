include 'emu8086.inc'
org 100h

.data
a dw ?
b dw ?

.code
start:

    print "Enter a :"
    call scan_num
    mov a, cx

    printn

    print "Enter b :"
    call scan_num
    mov b, cx

    printn

    mov ax, a
    add ax, b        ; ????? ax ? ????

    print "Sum is: "
    call print_num_uns

    ret

define_scan_num
define_print_num_uns
define_get_string
define_print_string
