.model tiny
.stack 100h
.data

Array dw 1, 2, 7, 4, 35, 6, 7, 254, 0, 99

.code
main proc

    mov ax, @data
    mov ds, ax
    xor ax, ax

    xor bx, bx          ; tutaj bedzie wieksza liczba
    xor dx, dx          ; tutaj bedziemy porownywac
    lea si, Array
    xor dx, dx

    mov cx, 10
    call max_element
    pop bx

    ; max element w bx

    mov ax, 4C00h
    int 21h

main endp

max_element proc

loop_through_array:
    mov dx, ds:[si]

    cmp bx, dx
    jng updatemax

    add si, 2                  ; iterowanie - dodajemy dwa poniewaz Array jest tablica slow (2 bajtowych wartosci)

    loop loop_through_array

    mov bp, sp

    mov [bp+2], bx
    xor bx, bx
    ret

updatemax:
    ; update

    mov bx, dx

    add si, 2

    jmp loop_through_array

max_element endp

end main
