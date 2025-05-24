.model small
.stack 100h
.data
a db 'Input 2 numbers$'
b db 10,13,'Largest number$'
.code
main proc
    mov ax,@data
    mov ds,ax 
    
    mov ah,9
    lea dx,a
    int 21h
    
    
    mov ah,1
    int 21h
    mov bl,al 
    
    mov ah,1
    int 21h
    mov bh,al       
    
    
    
    biggest:
    cmp bl,bh
    
    jg level1
    jmp level2
    
    level2:
    
    mov ah,9
    lea dx,b
    int 21h
    
     mov ah,2
      mov dl,bh
     int 21h 
     jmp exit  
     
     level1:
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
        
        
    