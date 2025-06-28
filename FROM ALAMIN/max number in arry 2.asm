; Program to input array elements and find the maximum
include 'emu8086.inc'
org 100h

.data
count dw ?         ; to store number of elements
arr dw 100 dup(?)  ; array to hold max 100 elements

.code

start:
    ; Prompt for number of elements
    print "Enter how many elements of the array: "
    call scan_num
    printn
    mov count, cx   ; save the count
    mov bx, cx      ; use bx as loop counter
    mov si, 0       ; index for array

; ---------- Input Loop ----------
print "Enter number: "
input_loop:
   
    call scan_num
    mov arr[si], cx
    printn
    add si, 2
    dec bx
    cmp bx, 0
    jne input_loop

; ---------- Output Loop ----------
    printn
    print "Array elements are:"
    printn

    mov si, 0
    mov bx, count

output_loop:
    mov ax, arr[si]
    call print_num_uns
    printn
    add si, 2
    dec bx
    cmp bx, 0
    jne output_loop

; ---------- Find Maximum ----------
    printn
    print "Maximum value is: "
    printn

    mov si, 0
    mov bx, count
    mov dx, arr[si] ; assume first element is max
    add si, 2
    dec bx

find_max:
    mov ax, arr[si]
    cmp ax, dx
    jle next
    mov dx, ax      ; update max

next:
    add si, 2
    dec bx
    cmp bx, 0
    jne find_max

    ; print maximum
    mov ax, dx
    call print_num_uns
    printn

    ret

; Macro definitions
define_print_string
define_get_string
define_scan_num
define_print_num
define_print_num_uns
