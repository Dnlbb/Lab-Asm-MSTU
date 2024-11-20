assume CS:code, DS:data

data segment
    msg    db "ABCD$"
    var    dw 5678h
           dw 1234h
    count  dw 3
data ends

PUSHM macro X
    push word ptr X+2
    push word ptr X
endm

CALLM macro P
    LOCAL after_callm
    push offset after_callm
    jmp P
    after_callm:
endm

POPM macro X
    pop word ptr X
    pop word ptr X+2
endm

LOOPM macro L
    dec CX
    jnz L
endm

RETM macro N
    pop AX
    add SP, N
    jmp AX
endm


code segment
start:
    mov AX, data
    mov DS, AX

    mov AH, 09h
    mov DX, offset msg
    int 21h
   
    PUSHM var

    mov word ptr var, 0ABCDh
    mov word ptr var+2, 0EF01h

    POPM var

    CALLM gofunc

    mov CX, count

loop_start:
    mov AH, 02h
    mov DL, 'G'
    int 21h

    LOOPM loop_start

    mov AH, 4Ch
    int 21h

gofunc:
    mov AH, 02h
    mov DL, 'O'
    int 21h
    RETM 0
code ends

end start
