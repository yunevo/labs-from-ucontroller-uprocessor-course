.MODEL SMALL
.STACK 100h
.DATA
                    ;khai bao
n dw ?
vec1 db 20 dup(0),1         
vec2 db 20 dup(0),1
vec3 db 21 dup(0)
moinhap db "Nhap so co 2 chu so (ex: 05,15,..): $"
print db 10,13,21 dup(30h)     ;10,13 :dau xuong dong
input db 10,?,2 dup(30h) 

.CODE 
main PROC 
 MOV AX,@DATA
 MOV DS,AX ; Khoi dong thanh ghi DS
 MOV ES,AX

 MOV dx, offset moinhap ;moinhap
 MOV ah, 9
 int 21h
 
 mov dx, offset input ;nhap ki tu so n
 mov ah, 0ah
 int 21h
 
 mov al, [input + 2]
 sub al, 30h
 mov bl, 10
 mul bl         ;ax = so thu nhat*10   
 mov bl, [input + 3]    
 sub bl, 30h
 add al, bl     ;ax = so thu nhat*10 + so thu hai
 xor ah, ah ; lam trong ah
 mov n, ax      ;luu ax vao n 
 
 ;so 1
 cmp n, 0
 je EXIT
 mov [print + 23], '$'  
 mov ah, 9
 mov dx, offset print  ; in so thu 1 la 0
 int 21h
 dec n
 
 mov cx, 2
so1va2:
 cmp n, 0
 je EXIT  
 dec n
 mov [print + 22], '1' 
 mov [print + 23], '$'
 mov ah, 9
 mov dx, offset print  ; in so thu 2 va 3 la 2 so 2
 int 21h     
 loop so1va2
 
fib:
 cmp n, 0                  ; kiem tra da print du so chua
 je EXIT  
 dec n
 lea si, [vec1 + 20]
 lea di, [vec2 + 20]
 lea bx, [vec3 + 20]
 mov cx, 21    
 xor ah, ah
sum:                ; cong 2 so lien truoc
 mov al, [si]   
 add al, [di]
 add al, ah 
 xor ah, ah
 cmp al, 10
 jnae CONT 
 sub al, 10
 mov ah, 1
CONT: 
 mov [bx], al
 
 dec si
 dec di
 dec bx
 loop sum 
 
 mov cx, 21
 lea si, [vec3+20]  
 lea di, [print+22]
printNumN:        ; in ket qua
 mov al, [si]
 add al, 30h
 mov [di], al
 
 dec si
 dec di
 loop printNumN
 
 mov [print+23], '$'
 mov dx, offset print
 mov ah, 9
 int 21h 
 
copyVec:           ; copy 2 so lien ke ve vec1 va vec 2 de cong
 cld
 lea si, [vec2]
 lea di, [vec1] 
 mov cx, 21
 rep movsb  
 
 lea si, [vec3]
 lea di, [vec2] 
 mov cx, 21
 rep movsb
 xor ah, ah        
 jmp fib
 
 
 
EXIT:
 mov ah, 0
 int 16h 
 main endp

