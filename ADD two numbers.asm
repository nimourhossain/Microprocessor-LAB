 .model small
 .stack 100h
 .data
 a db 'Input first interger$'
 b db 10,13, 'Input Second integer$'
 c db 10,13, 'Result$'
 
 .code
 
 main proc
    mov ax, @data
    mov ds,ax
    
    
    mov ah,9
    lea dx,a
    int 21h
    
    
    mov ah,1
    int 21h
    mov bl,al
    
    
     mov ah,9
    lea dx,b
    int 21h  
    
    
     mov ah,1
    int 21h
    mov bh,al   
    
    
     mov ah,9
    lea dx,c
    int 21h   
    
    add bl,bh  
    
    
    sub bl,48
    
    
    mov ah,2
    mov dl,bl
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
 
 end main