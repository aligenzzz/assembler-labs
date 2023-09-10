name "laba8"    
    .model small
    .stack 100h
    
    .code  
open_file proc
    mov ah,3dh
    mov al,0 
    mov dx,offset fileName
    int 21h  
    jc error1
    mov handle,ax 
    ret
open_file endp

close_file proc 
    mov ah,3eh
    mov bx,handle
    int 21h 
    jc error3 
    ret
close_file endp

read_file proc 
    mov ah,3fh
    mov bx,handle
    xor cx,cx
    mov cl,buffer
    lea dx,buffer_content
    int 21h  
    jc error2
    cmp ax,cx
    jnl return1
    mov file_end,01h
  return1:
      mov buffer_length,al
      ret
read_file endp  

clean_buffer proc  
    xor cx,cx   
    xor bx,bx
    mov cl,buffer_length 
    lea di,buffer_content    
  loop0:
    cmp cl,ch
    je return2 
    mov [bx+di],'$'
    inc bx
    inc ch 
    jmp loop0
  return2:
      ret        
clean_buffer endp  
    
empty_strings proc 
  reading:   
    call clean_buffer
    mov buffer_length,0
    call read_file     
    lea dx,buffer_content
    call output         
    xor bx,bx
    xor cx,cx
    mov cl,buffer_length
    xor di,di
   counting:
       cmp cl,ch
       je return3
       mov bl,byte ptr buffer_content[di] 
       inc di
       cmp bl,' '
       je dalee 
       cmp bl,0Dh
       je dalee
       cmp bl,0Ah
       je plus_string
       inc help
       jmp dalee
      plus_string:
          cmp help,0
          jne continuamos
          mov help,0 
          inc count_of_empty
          jmp dalee 
      continuamos:
       mov help,0
      dalee: 
       inc ch
       jmp counting    
  return3: 
    cmp file_end,01h
    jne reading   
    ret    
empty_strings endp 

output proc
    mov ah,09h
    int 21h 
    ret
output endp  

get_str proc
    xor cx,cx
    xor ax,ax
    mov al,count_of_empty
    lea di,result  
 to_stack:         
    xor dx,dx
    div ten
    push dx 
    inc cl 
    cmp ax,0
  jne to_stack    
 xor bx,bx
 from_stack:
   xor ax,ax 
   xor dx,dx
   pop ax 
   mov dl,al
   mov ax,dx
   add al,30h
   mov [bx+di],al
   inc ch  
   inc bx
   cmp cl,ch
   jne from_stack  
   ret
get_str endp 

get_fileName proc   
  xor bx,bx 
  xor cx,cx
  mov cl,cmd_length 
  xor di,di
  xor ax,ax
  lea si,fileName    
  loop00:  
    cmp cl,ch
    je tiz
    mov al,byte ptr cmd_string[di]  
    mov [bx+si],al
    inc bx
    inc di 
    inc ch 
    jmp loop00
 tiz:    
   dec bx
   mov [bx+si],0
   ret
get_fileName endp

start:  mov ax,@data
        mov es,ax 
    
        xor cx,cx
	    mov cl,ds:[80h] 
	    mov bl,cl	    
        cmp bl,0
        je error4  
        dec cx
        mov si,82h
        mov di,offset cmd_string        
        rep movsb 
         
        mov ds,ax
        mov cmd_length,bl  
        lea dx,message3
        call output              
        lea dx,cmd_string
        call output 
        lea dx,enter
        call output
        lea dx,enter
        call output 
        
        call get_fileName
                
        lea dx,message1
        call output 
                   
        call open_file                
        call empty_strings 
        call close_file 
                  
        lea dx,enter
        call output
        lea dx,enter
        call output
        lea dx,message2
        call output
             
        call get_str
        lea dx,result
        call output        
        
        jmp exit
        
error1: lea dx,error_message1
        call output
        jmp exit 
error2: lea dx,error_message2
        call output
        jmp exit
error3: lea dx,error_message3
        call output
        jmp exit  
error4: mov ds,ax
        lea dx,error_message4
        call output
        jmp exit     
                                                  
exit:   mov ax,4c00h
        int 21h           
        
    .data 
cmd_length db 0 
cmd_string db 120 dup ('$') 
fileName db 20 dup ('$')
fileName0 db 'data.txt',0  
handle dw 0  
buffer db 20
buffer_length db ?
buffer_content db 22 dup ('$')   
file_end db 0
help db 0   
count_of_empty db 0 
result db 10 dup ('$') 
ten dw 10      
message1 db "***File contents",0Dh,0Ah,'$'
message2 db "***Count of empty strings = $"
message3 db "***Command line parameter = $"
enter db 0Dh,0Ah,'$'
error_message1 db "Error while opening file!!!",07h,0Dh,0Ah,'$'
error_message2 db "Error while reading file!!!",07h,0Dh,0Ah,'$'   
error_message3 db "Error while closing file!!!",07h,0Dh,0Ah,'$' 
error_message4 db "There are no arguments in the command line!!!",07h,0Dh,0Ah,'$' 
    end start
