assume CS:code,DS:data

data segment
    string1 db 100, 99 dup (0)   ; Первая строка
    string2 db 100, 99 dup (0)   ; Вторая строка
    msg_equal db 'Strings are equal.', 0Dh, 0Ah, '$'
    msg_first_greater db 'First string is greater.', 0Dh, 0Ah, '$'
    msg_second_greater db 'Second string is greater.', 0Dh, 0Ah, '$'
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    ; Чтение первой строки
    mov dx, offset string1
    mov ah, 0Ah
    int 21h

    ; Чтение второй строки
    mov dx, offset string2
    mov ah, 0Ah
    int 21h

    ; Вызов функции strncmp (far call)
    push word ptr 50             ; Максимальная длина сравнения
    push offset string2 + 2      ; Указатель на вторую строку (пропускаем длину)
    push offset string1 + 2      ; Указатель на первую строку (пропускаем длину)
    call far ptr strncmp         ; Вызов strncmp как far procedure                

    ; Сравнение результата
    cmp ax, 0                   
    je strings_are_equal

    ; Если не равны, проверим, больше ли первая строка второй
    jg first_is_greater

    ; Если первая строка меньше, выводим соответствующее сообщение
    jmp second_is_greater

first_is_greater:
    mov dx, offset msg_first_greater
    mov ah, 09h
    int 21h
    jmp finish

second_is_greater:
    mov dx, offset msg_second_greater
    mov ah, 09h
    int 21h
    jmp finish

strings_are_equal:
    mov dx, offset msg_equal
    mov ah, 09h
    int 21h

finish:
    mov ah, 4Ch
    int 21h

strncmp proc far
    push bp
    mov bp, sp
    mov si, [bp+4]       
    mov di, [bp+6]       
    mov cx, [bp+8]       

    xor ax, ax           

compare_loop:
    cmp cx, 0 
    je done              

    mov al, [si]         
    mov bl, [di]         
    cmp al, bl           
    jne compare_not_equal 

    inc si               
    inc di               
    dec cx               
    jmp compare_loop     

compare_not_equal:
    mov ah, 0            
    sub al, bl           
    jmp done

done:
    pop bp
    retf                 
strncmp endp

code ends
end start
