.model small ;ekhane ekta code segment and ekta data segment royeche
.stack 100h   ;memory stack
.code   ;code segment

main proc
    mov ah,1 
    int 21h
    mov bl,al
    
    
    mov ah,1
    int 21h
    mov bh,al
    
    
    mov ah,2
    mov dl,bl
    int 21h
    
    mov ah,2
    mov dl,bh
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
