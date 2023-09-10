name "laba7"    
    .model small
    .stack 100h
    
    .code  
output proc 
    mov ah,09h
    int 21h
    ret
output endp

input proc
    mov ah,0ah
    int 21h
    ret
input endp  

get_number proc
    xor di,di
    xor ax,ax
    mov cl,n_length
    xor ch,ch
    xor bx,bx
    mov si,cx
    mov cl,10 
    mov minus,0
 loop0:
    mov bl,byte ptr number[di] 
    cmp bl,'-'
    je negative
    cmp bl,'0'
    jb error4
    cmp bl,'9'
    ja error4 
    sub bl,30h
    mul cx
    jo error3
    add ax,bx
    jmp next
   negative:
    cmp di,0
    je negative2  
    jmp error4
     negative2: 
        inc minus 
        cmp signed_style,0
        jne next
        inc signed_style         
   next:
    inc di
    cmp di,si
    jb loop0 
    
    cmp minus,1
    jb finish 
    neg ax
  finish:  
        ret
 error4:
    lea dx,error_message4
    call output
    jmp exit  
get_number endp
    
get_str proc
    xor cx,cx
    mov ax,ax
    mov ax,result
    lea di,result_str  
    
    cmp minus,1
    jne to_stack
    mov [di],'-'
    neg ax 
    inc offs
 to_stack:         
    xor dx,dx
    div ten
    push dx 
    inc cl 
    cmp ax,0
  jne to_stack    
 xor bx,bx
 add bl,offs 
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
   

start:  mov ax,@data
        mov ds,ax 
        
        lea dx,message1
        call output        
        lea dx,buffer
        call input      
        lea dx,enter
        call output 
        
        cmp n_length,0
        je error1                
        call get_number
        mov number1,ax
        xor ax,ax
        mov al,minus
        mov sign1,al  
        
        lea dx,message2
        call output
        lea dx,buffer
        call input
        lea dx,enter
        call output 
         
        cmp n_length,0
        je error1   
        call get_number 
        mov number2,ax 
        xor ax,ax
        mov al,minus
        mov sign2,al  
        
        mov minus,0
 
 continue:       
        lea dx,message3
        call output
        lea dx,enter
        call output 
                
        mov ah,08h
        int 21h 
        cmp al,'+'
        je summation
        cmp al,'-'
        je subtraction
        cmp al,'*'
        je multiplication
        cmp al,'/'
        je division             
               
        lea dx,error_message2
        call output 
        jmp exit

  summation:   
        mov ax,number1
        cmp signed_style,1
        je signed_sum
     unsigned_sum:  
          clc
          add ax,number2
          jc error3
          jmp break
     signed_sum:
          add ax,number2
          jo error3
          jmp break      
  subtraction:  
        cmp sign1,0
        jne non_kostyl
        cmp sign2,1
        jne non_kostyl
        neg number2
        dec signed_style
        dec minus
        jmp summation       
     non_kostyl:   
        mov ax,number1 
        clc
        sub ax,number2
        jc error3 
        jo error3  
        jmp break
  multiplication:  
        xor ax,ax
        mov al,sign1
        add al,sign2
        cmp al,1
        jne dalee
        inc minus
     dalee:
        xor ax,ax  
        mov ax,number1 
        cmp signed_style,1   
        je signed_mul
     unsigned_mul: 
        cmp signed_style,0
        mul number2 
        jc error3
        jmp break 
     signed_mul: 
        ; cmp number2,0
        imul number2
        jo error3
        jmp break
  division:  
        xor ax,ax
        mov al,sign1
        add al,sign2
        cmp al,2
        jne dalee2
        neg number1
        neg number2 
        mov ax,number1 
        cmp number2,0
        je error4 
        div number2 
        mov ost,dx 
        jmp break
     dalee2: 
        cmp sign1,1
        je sign1_is_active
        cmp sign2,1
        je sign2_is_active          
        mov ax,number1 
        cmp number2,0
        je error4 
        div number2 
        mov ost,dx 
        jmp break  
      sign1_is_active:
            neg number1
            mov ax,number1 
            cmp number2,0
            je error4             
            div number2  
            inc minus
          jmp break 
      sign2_is_active:
            mov ax,number1 
            cmp number2,0
            je error4
            neg number2 
            div number2 
            inc minus 
          jmp break         
 break:   
    jns continuamos   
    inc minus
  continuamos:     
    mov result,ax 
    xor bx,bx
    mov bx,result 
    
    lea dx,message4
    call output
    
    call get_str  
    lea dx,result_str
    call output 
    jmp exit 
 
 error3:
    lea dx,error_message3
    call output
    jmp exit   
 error1:
    lea dx,error_message1
    call output             
                                                 
 exit:  mov ax,4c00h
        int 21h           
        
    .data
enter db 0Dh,0Ah,'$' 
message1 db "Enter the first number: $"
message2 db "Enter the second number: $"
message3 db "What do you want? (enter +,-,* or /) $"
message4 db "Result = $" 
buffer db 6
n_length db ?
number db 6 dup (?) 
error_message1 db "You haven't entered anything!!!",07h,0Dh,0Ah,'$'
error_message2 db "Enter +,-,* or /!",07h,0Dh,0Ah,'$'
error_message3 db "OVERFLOW!!!",07h,0Dh,0Ah,'$' 
error_message4 db "Error of input!!!",07h,0Dh,0Ah,'$' 
number1 dw ?
number2 dw ?  
minus db 0
sign1 db 0
sign2 db 0  
signed_style db 0
result dw ?
result_str db 10 dup ('$') 
ten dw 10  
offs db 0 
ost dw 0
    end start