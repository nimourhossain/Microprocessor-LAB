.model small
.stack 100h
.data

a db 'Enter three Numbers: $'
b db 10,13,'Largest Number is: $'

.code

main proc
    mov ax,@data
    mov ds,ax
    
    
    mov ah,9
    lea dx,a
    int 21h
    
    
    mov ah,1
    int 21h
    mov bh,al
    int 21h
    mov bl,al
    int 21h
    mov ch,al
    
    
    
    cmp bh,bl
    jg l1
    
    l1:
    cmp bh,ch
    jbe l2
    mov ah,9
    lea dx,b
    int 21h
    mov ah,2
    mov dl,bh
    int 21h 
    jmp exit 
    
    
    l2:
    cmp ch,bl
    jbe l3
    
     mov ah,9
    lea dx,b
    int 21h
    mov ah,2
    mov dl,ch
    int 21h
    jmp exit 
    
    l3:
     mov ah,9
    lea dx,b
    int 21h
    mov ah,2
    mov dl,bl
    int 21h 
    jmp exit 
    
    exit:
    mov ah,4ch
    int 21h 
    main endp
end main
    
    