.model small
.stack 100h

.data
  msg1   db 10,13,'Enter string: $'
  msg2   db 10,13,'You entered: $'
  buffer db 255          ; maximum buffer size
         db ?            ; (DOS fills this with actual length)
         db 255 dup(0)   ; storage for the characters

.code
main proc
    mov ax,@data
    mov ds,ax

    ; Prompt
    mov ah,9
    mov dx,OFFSET msg1
    int 21h

    ; Buffered input (max 255 chars)
    mov ah,0Ah
    mov dx,OFFSET buffer
    int 21h

    ; Echo prompt
    mov ah,9
    mov dx,OFFSET msg2
    int 21h

    ; Set up loop counter = length byte
    xor  cx,cx
    mov  cl,[buffer+1]
    lea  si,buffer+2

print_loop:
    mov  dl,[si]
    mov  ah,2
    int  21h
    inc  si
    loop print_loop

    ; Exit
    mov ah,4Ch
    int 21h
main endp
end main
