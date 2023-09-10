name "laba5(COM)"

        .model tiny
        .code
        
        org 100h 
start:  mov ah,09h
        mov dx,offset message
        int 21h
        ret
message db "Kakaya-to stroka simvolov...",0dh,0ah,'$'
        end start
         