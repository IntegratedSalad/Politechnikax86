.model tiny
.stack 100h

.data
; Nic w data
.code
main proc

    mov ax, @data
    mov ds, ax
    xor ax, ax

    mov ax, 8000h

    mov dx, 0AFFFh

shift:
    cmp ax, 0
    je bye

    mov cx, ax          ; zapisujemy wartosc w ax do cx, bo bedzie nadpisana
    ; operacja and zwroci w tym przypadku ax, jezeli w ax (rejestrze ktory ma wartosc przesuwana, porownujaca) jest jedynka na miejscu
    ; jedynki w naszej liczbie sprawdzanej w bx
    and ax, dx
    cmp ax, cx          ; CMP ustawi ZFLAG=1 jezeli rowne cx (starej wartosci ax)
    je  incbx

    mov ax, cx

    shr ax, 1           ; Instrukcja do przesuniecia logicznego w prawo (dzielenie przez dwa)

    jmp shift

incbx:
    inc bx
    mov ax, cx
    shr ax, 1           ; Tutaj tez musimy wczytac wartosc z cx do ax i przesunac 1 w prawo
    jmp shift

bye:
    mov ax, 4C00h       ; Przerwanie 21h, funkcja 4C00h
    int 21h

main endp
end main