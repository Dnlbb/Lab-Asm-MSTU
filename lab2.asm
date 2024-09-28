assume CS:code, DS:data

data segment
    arr DW 3, -2, 1, -1  
    len DW 4                  
    sum DW 0
data ends
code segment
MAIN:    
    MOV AX, data              
    MOV DS, AX         
    XOR CX, CX
    XOR SI, SI              
    MOV CX, [len]            
    XOR DX, DX               
    CLD                       
loop_start:
    MOV AX, [arr + SI]        
    CMP AX, 0                
    JL skip                   
    ADD DX, AX               
skip:
    ADD SI, 2                 
    LOOP loop_start           
    MOV [sum], DX  
    
    MOV AX, 4C00h             
    INT 21h                   
code ends
end MAIN
