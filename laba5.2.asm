name "laba5(EXE)"

        .model small
        .stack 100h
        
        .code          
start:  mov ax,@data
        mov ds,ax
        mov ah,09h
        mov dx,offset message
        int 21h
        mov ax,4c00h
        int 21h
        
        .data
message db "Kakaya-to stroka simvolov...",0dh,0ah,'$'
        end start
