.model tiny
.stack 100h
.data
N dw 6

row dw 0

.code
main proc

    mov ax, @data
    mov ds, ax
    xor ax, ax
    xor di, di          ; czyscimy di (DESTINATION INDEX)

    xor ax, ax

    mov ax, 00003h
    int 10h

    xor ax, ax
    xor cx, cx

    mov cx, 0B800h
    mov es, cx          ; pointujemy na pierwszy adres ekranu
    mov bx, 0          
    mov al, 0A6h

    ; (80 * row) + column

    mov ah, 044h        ; kolor czewrwony

    xor cx, cx          ; loop var
    xor dx, dx          ; counting to 3
    xor bx, bx          ; counting to 5

    mov cx, 54

print_color:
    cmp bx, 5
    je  change_color

    mov es:[di], ax

    add di, 2
    
    inc bx
    loop print_color
    
exit:
    jmp bye

change_color:
    inc dx
    mov bx, 0
    cmp ah, 044h
    je  change_to_blue
    jne change_to_red

change_to_red:
    cmp cx, 0
    je bye
    mov ah, 044h
    cmp dx, 3
    je  increment_row
    loop print_color

change_to_blue:
    cmp cx, 0
    je bye
    mov ah, 011h
    cmp dx, 3
    je  increment_row
    loop print_color

increment_row:
    cmp cx, 0
    je bye
    inc [row]
    xor di, di
    push cx
    push ax
    mov cx, [row]
    mov ax, 80*2
    mul cx
    mov di, ax
    pop ax
    pop cx
    loop print_color

bye:
    xor cx, cx
    xor ax, ax
    mov ah, 000h
    int 016h

    mov ax, 4C00h
    int 21h

main endp
end main