assume CS:code, DS:data 

data segment
    a db 30        
    b db 2
    d db 4
    c db 4
    one db 1
    result db 0
    digits db "0123456789ABCDEF"
data ends

code segment
start:
    mov AX, data
    mov DS, AX
    
    
    mov AX, 0
    mov AL, a       
    mov BL, b       
    div BL         
    mov CL, AL  
    
    
    mov AL, 0
    mov BL, 0
    mov AL, d 
    mov BL, c 
    div BL 
    add CL, AL  
    sub CL, one 
    
    mov result, CL 

    mov AL, [result]
    mov AH, 0
    mov CX, 0
    mov BX, 10

    dec_loop:
    mov DX, 0
    div BX
    push DX
    inc CX
    test AX, AX
    jnz dec_loop

    dec_print:
    pop DX
    add DL, '0'
    mov AH, 02h
    int 21h
    loop dec_print

    mov DL, ' '
    mov AH, 02h
    int 21h
    
    
    mov AL, [result]
    mov AH, 0

    mov CL, 4
    shr AL, CL
    mov BX, offset digits
    xlat
    mov DL, AL
    mov AH, 02h
    int 21h

    mov AL, [result]
    and AL, 0Fh
    mov BX, offset digits
    xlat
    mov DL, AL  
    mov AH, 02h
    int 21h
    
    mov ah, 4Ch    
    int 21h        
code ends
end start
