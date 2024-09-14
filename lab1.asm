assume CS:code, DS:data 

data segment
    a db 10         
    b db 2
    d db 4
    c db 4
    one db 1
    result db 0
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    mov ax, 0
    mov al, a       
    mov bl, b       
    div bl         
    mov cl, al
    	
    mov al, 0
    mov bl, 0
    mov al, d 
    mov bl, c 
    div bl 
    add cl, al  
    sub cl, one 
    
    mov result, cl 
    
    mov ah, 4Ch    
    int 21h        
code ends
end start
