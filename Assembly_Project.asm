.model small
lfcr macro
    mov ah, 02
    
    mov dl, 0ah
    int 21h
    
    mov dl, 0dh
    int 21h
    
lfcr endm
.stack 100h
.data
nl1 db "Enter 1st number: $"
nl2 db "Enter 2nd number: $"
opl db "enter any (+, -, *, /) : $"
rel db "result: $"
integer dw 0
integer2 dw 0
count dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 09
    lea dx, nl1
    int 21h
    
    call readInt
    
    mov dx, integer
    mov integer2, dx
    
    lfcr
    mov integer, 0
    
    mov ah, 09
    lea dx, nl2
    int 21h
     
    call readInt
    lfcr
    
    mov ah, 09
    lea dx, opl
    int 21h
    
    
    mov ah, 01
    int 21h
    cmp al, '+'
    je addnum
    cmp al, '*'
    je mulnum
    
    jmp exit
    
    mov ah, 09
    lea dx, rel
    int 21h
    
    addnum:
    lfcr
    call addition
    jmp exit
    mulnum:
    lfcr
    call multiply
    jmp exit
    
    exit:
    mov ah, 4ch
    int 21h
main endp
multiply proc
        
    mov ax, integer
    mul integer2
    
    mov bx, 10000
    idiv bx
    mov integer, ax
    mov integer2, dx
    call writeInt
    
    mov dx, integer2
    mov integer, dx
    call writeInt
    
    
    ret
multiply endp
addition proc
    mov dx, integer
    add dx, integer2
    
    mov integer, dx
    call writeInt
    ret
addition endp    
readInt proc
       xor cx, cx
       xor bx, bx
       mov cx, 4
       
       l1:
          mov ah, 01
          int 21h
          mov bl, al
          sub bl, 48
          mov ax, 10
          mul integer
          mov integer, ax
          add integer, bx          
       loop l1
       
       ret
readInt endp
writeInt proc
     mov cx, 5    
     mov count, 0
     mov ax, integer
     mov bx, 10
     l2:
       xor dx, dx 
       cmp ax, 0
       je outt
       div bx
       push dx
       inc count
       
       
     loop l2
     outt:
     mov cx, count
     l3:
     mov ah, 02
     pop dx
     add dx, 48
     int 21h
     loop l3
     ret
writeInt endp
end main