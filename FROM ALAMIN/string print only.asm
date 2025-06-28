
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here   
.data
str1 db 'Bangladesh is a small country $'  

.code
main proc
    mov ax,@data
    mov ds,ax
    
    
    mov ah,9
    lea dx,str1
    int 21h  
    
    
    exit:
    mov ah,4ch
    main endp
end main
    

ret




