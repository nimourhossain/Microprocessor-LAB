.model small
.stack 100h

.data
  msg1   db 10,13,'Enter string: $'
  msg2   db 10,13,'Reversed: $'
  buffer db 255          ; max buffer size
         db ?            ; actual length filled by DOS
         db 255 dup(0)   ; input storage

.code
main proc
    mov ax,@data
    mov ds,ax

    ; Prompt for input
    mov ah,9
    mov dx,OFFSET msg1
    int 21h

    ; Read line (0Ah)
    mov ah,0Ah
    mov dx,OFFSET buffer
    int 21h

    ; Prompt for reversed output
    mov ah,9
    mov dx,OFFSET msg2
    int 21h

    ; Set pointers for reverse print
    xor cx,cx
    mov cl,[buffer+1]      ; CL = length
    lea si,buffer+2        ; SI -> start of string
    mov di,si
    add di,cx
    dec di                 ; DI -> last valid character

rev_loop:
    mov dl,[di]
    mov ah,2
    int 21h
    dec di
    loop rev_loop

    ; Exit
    mov ah,4Ch
    int 21h
main endp
end main
