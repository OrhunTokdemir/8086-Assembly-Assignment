;2. grup 1. soru
data segment
m1 db 10,13,'tam olarak 16 bitide yaziniz ve enter a basiniz: $';sayi tam olarak 16 bit girilmeli yoksa program hata verir.
m2 db 10,13,'2 byte hexadecimal: $';ornegin 0000111100001111 gibi tam boyutlu girilmezse program d?zg?n calismaz
bin db 17,18 dup('$')
num dw 0
mulnum dw 1000000000000000b
divnum dw 10b
divnum1 dw 0010h
remain dw 0
data ends
code segment
main proc far
assume cs:code,ds:data
mov ax,0
push ds ax
mov ax,data
mov ds,ax
    
jmp start

start:
    mov ah,09h
    lea dx,m1
    int 21h

    mov ah,0ah
    lea dx,bin
    int 21h
    
    mov cl,16
atobin:
    mov bx,offset bin
    mov al,18
    sub al,cl
    xlat
    
    sub al,30h
    
    mov ah,0
    mul mulnum
    add num,ax
    
    mov ax,mulnum
    mov dx,0
    div divnum
    mov mulnum,ax
    loop atobin
    
    mov divnum,1000h
    mov cx,4
    
    mov ah,09h
    lea dx,m2
    int 21h
bintohex:
    
    mov ax,num
    mov dx,0
    div divnum
    mov remain,dx
    cmp ax,10
    jl lnot
    
    add ax,55
    jmp junc
    
lnot:
    add al,30h
    
junc:
    mov ah,02h
    mov dl,al
    int 21h
    
    mov dx,remain
    mov num,dx
    mov dx,0
    mov ax,divnum
    div divnum1
    mov divnum,ax
    
    loop bintohex
    
    mov ah,02h
    mov dl,'h'
    int 21h
    
    
    ret
main endp
code ends
end main
    