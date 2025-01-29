;1. grup 1. soru
data segment
char db ?
sira db 2
m1 db 10,13,'metin giriniz: $'
m2 db 10,13,'karakter giriniz: $'
m3 db 10,13,'pozisyon(lar):$'
onbol db 10
onlar db ?
birler db ?

dizi db 90,93  dup('$')

data ends


code segment
main proc far
assume cs:code,ds:data
mov ax,0
push ds ax
mov ax,data
mov ds,ax

jmp basla

basla:

    mov ah,09h
    lea dx,m1
    int 21h
    
    mov ah,0Ah
    lea dx,dizi
    int 21h
    
    mov ah,09h
    lea dx,m2
    int 21h
    
    mov ah,01h
    int 21h
    mov char,al
    
    mov bx,offset dizi;girilen dizinin boyutunu ??renir
    mov al,1
    xlat
    mov cl,al ;dizi boyutunu cl ye atar,d?ng? sayisini belirler
    
    mov ah,09h
    lea dx,m3
    int 21h
    
    check:
        mov bx,offset dizi
        mov al,sira
        xlat
        add sira,1
        cmp char,al
        jne next ;bulundugu siradaki karakter char ile e?itse karakterin siras?n? ekrana yazd?r?r.
        
        mov ah,0    ;ax bolunen olacagi icin ama sadece al uzerinden islem yapmak istedigim icin ah=0 al'ye de deger verilir
        mov al,sira ;dizimin boyut siniri belli oldugundan sira degiskeninin boyutunun al nin boyutunu asma ihtimali yok.
        sub al,2
        div onbol   ;div fonksiyonunda sadece dogrudan sayi degerleri kullan?lamad?g? icin onceden 10 degerini atad?g?m degiskeni bolen olarak kullan?yorum
        mov onlar,al;al bolumu ah'da kalanlar? verir.10 a boldugum icin bolum, onlar basamag?; kalanlarda, birler basamag? olur.
        mov birler,ah
        
        cmp onlar,0
        je ones     ;sayi ondan kucukse,yani onlar basamag? s?f?rsa onlar basamag?n? yazd?rmay? atl?yor
        
        mov ah,02h
        mov dl,onlar
        add dl,30h
        int 21h
        
    ones:
        mov ah,02h
        mov dl,birler
        add dl,30h
        int 21h
        
        mov ah,02h
        mov dl,44
        int 21h
        next:
       
        loop check
        
        

ret

main endp
code ends
end main
