.model small
.stack 100h
.data
a db 10,13,'Star related problem$'
.code
main proc 
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,a
    int 21h
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov cx,10
    
    lev:
    mov ah,2
    mov dl,'*'
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
    int 21h
     
      mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    loop lev  
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    