name "laba6"    
    .model small
    .stack 100h
    
    .code
start:  mov ax,@data
        mov ds,ax 
           
        mov ah,09h 
        mov dx,offset message1
        int 21h 
 
        mov ah,0ah        
        lea dx,buffer  
        int 21h  
        
        mov ah,09h
        mov dx,offset enter
        int 21h    
        
        cmp str_length,00h
        je error
        
        lea di,buffer_content
        mov bl,str_length
        mov [bx+di],' '
        inc str_length
          
        mov ch,00h
        mov cl,str_length 
        mov bx,0000h         
        
        do_pretransformation:                 
            word_search:
                mov bl,ch 
                inc ch
                cmp [bx+di],' '            
                jne check_end 
                jmp continue
                    check_end:  
                        cmp ch,str_length
                        jl word_search 
            continue:
            mov ch,help
            inc bl 
            mov help,bl
            to_stack: 
                dec bl 
                inc ch
                push [bx+di]
                cmp ch,help
                jne to_stack
            mov bl,help  
            mov ch,bl 
            mov cl,help
            cmp cl,str_length
            jb do_pretransformation 
 
        mov bl,00h           
        do_transformation:
            pop ax
            mov [bx+di],al
            inc bl
            dec ch
            jne do_transformation 
            
        mov ah,09h        
        lea dx,message2 
        int 21h          
        lea dx,buffer_content
        int 21h         
        jmp finish
        
        error:
            mov ah,09h
            lea dx,error_message
            int 21h              
 
        finish:                                       
        mov ax,4c00h
        int 21h           
        
    .data
message1 db "Enter a string: $"    
message2 db "Result: $" 
enter db 0Dh,0Ah,'$'
buffer db 200
str_length db ?
buffer_content db 200 dup ('$') 
help db 00h 
error_message db "You haven't entered anything!!!",07h,'$'
    end start
