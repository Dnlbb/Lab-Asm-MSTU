assume cs: code, ds: data

data segment
    first db 255, 254 dup (0)
    second db 255, 254 dup (0)
    n dw 10
    bigger_s db "  first$"
    smaller_s db "  second$"
    equal_s db "  equal$"   
data ends

code segment

input proc
    push bp
    mov bp, sp
    
    mov dx, [bp+4]
    xor ax, ax
    mov ah, 0Ah
    int 21h
    
    mov dx, [bp+4]
    inc dx
    mov si, dx
    mov cx, [si]
    xor ch, ch
    add si, cx
    mov byte ptr [si+1], '$'
    pop bp
    ret
input endp


print proc
    push bp
    mov bp, sp
    
    mov dx, [bp+4]
    add dx, 2
    xor ax, ax
    mov ah, 09h
    int 21h
    pop bp
    ret
print endp


endl proc
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    ret
endl endp


strncmp proc
    push bp
    mov bp, sp
    
    mov si, [bp+4]
    mov di, [bp+6]
    mov cx, [bp+8]
    
compare_loop:
    cmp cx, 0  
    je equal_strings  
    
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne strings_differ  
    cmp al, 0
    je equal_strings
    inc si 
    inc di 
    dec cx 
    jmp compare_loop
    
strings_differ:
    sub al, bl 
    pop bp
    ret
    
equal_strings:
    xor ax, ax  
    pop bp
    ret
strncmp endp

main:
    mov ax, data
    mov ds, ax  
    push offset first
    call input
    call endl
    push offset second
    call input
    call endl
    push n                
    push offset first + 2
    push offset second + 2
    call strncmp
    cmp al, 0
    je equa_strings
    jg second_is_greater
    jl first_is_greater
    
equa_strings:
    push offset equal_s
    call print
    jmp exit_program

first_is_greater:
    push offset bigger_s
    call print
    jmp exit_program

second_is_greater:
    push offset smaller_s
    call print

exit_program:
    call endl
    mov ah, 4ch
    int 21h  
 
code ends
end main
