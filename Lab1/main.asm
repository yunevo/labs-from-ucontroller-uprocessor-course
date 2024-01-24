.model small
.data  
 var1 dd 0010ffffh  
 var2 dd 0002ffffh    
.code 
 mov ax, @data  
 mov ds, ax  
 mov ax, word ptr var1 ;lsb of var1
 mov bx, word ptr var1+2 ;msb of var1
 mov cx, word ptr var2; lsb of var2
 mov dx, word ptr var2+2; msb of var2
 add ax, cx
 adc bx, dx 
 
 mov cx, 8
print1:
 mov ah, 2
 mov dl, '0'
 test bh, 10000000b  
 jz zero1
 mov dl, '1'
zero1: 
 int 21h
 shl bh, 1
 loop print1 
 
 mov cx, 8
print2:
 mov ah, 2
 mov dl, '0'
 test bl, 10000000b  
 jz zero2
 mov dl, '1'
zero2: 
 int 21h
 shl bl, 1
 loop print2

 mov ax, @data  
 mov ds, ax  
 mov ax, word ptr var1 ;lsb of var1
 mov bx, word ptr var1+2 ;msb of var1
 mov cx, word ptr var2; lsb of var2
 mov dx, word ptr var2+2; msb of var2
 add ax, cx
 mov bx, ax
 mov cx, 8
print3:
 mov ah, 2
 mov dl, '0'
 test bh, 10000000b  
 jz zero3
 mov dl, '1'
zero3: 
 int 21h
 shl bh, 1
 loop print3 
 
 mov cx, 8
print4:
 mov ah, 2
 mov dl, '0'
 test bl, 10000000b  
 jz zero4
 mov dl, '1'
zero4: 
 int 21h
 shl bl, 1
 loop print4   
 
 mov dl, 'b'
 int 21h
 
 mov ah, 0
 int 16h
 ret
