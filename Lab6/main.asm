;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Fri May 13 2022
; Processor: AT89C51
; Compiler:  ASEM-51 (Proteus)
;====================================================================

$NOMOD51
$INCLUDE (8051.MCU)

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES


;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      org   0000h
      jmp   Start

;====================================================================
; CODE SEGMENT
;====================================================================

      org   0100h
Start:	
      ; Write your code here
      MOV A, PCON
      CLR ACC.7
      MOV PCON, A
      MOV TMOD, #020H
      MOV TH1,  #0F3H
      MOV SCON, #01000010B
      SETB TR1
      MOV P1, #000H
      


     
Loop:	
      
DocSo1:
      MOV A, #254d
      ACALL TRUYEN
      MOV A, #1
      ACALL TRUYEN
      ACALL choBamNut
      ; ki?m tra nút ac
      CJNE A, #'c', con1
      LJMP DocSo1
 con1:     
      MOV R0, A
      MOV SBUF, A
      ACALL TRUYEN
DocDau:
      ACALL choBamNut
      ; ki?m tra nút ac
       CJNE A, #'c', con2
      LJMP DocSo1
 con2:   
      MOV R1, A
      MOV SBUF, A
      ACALL TRUYEN
DocSo2:
      ACALL choBamNut
      ; ki?m tra nút ac
      CJNE A, #'c', con3
      LJMP DocSo1
 con3:   
      MOV R2, A
      MOV SBUF, A
      ACALL TRUYEN
phimBang:
      ACALL choBamNut
       CJNE A, #'=', con4
      JMP TinhToan
con4:   
      CJNE A, #'c', ChoXoa
      LJMP DocSo1   
      
TinhToan:
      MOV A, #'='
      MOV SBUF, A
      ACALL TRUYEN
      MOV A, R0
      SUBB A, #48D
      MOV R0, A
      MOV A, R2
      SUBB A, #48D
      MOV R2, A
      ;
      CJNE R1, #'/', con6
      MOV A, R0
      MOV B, R2
      DIV AB
      LJMP GuiKetQua
con6:
      CJNE R1, #'x', con7
      MOV A, R0
      MOV B, R2
      MUL AB
      LJMP GuiKetQua
con7:   
      CJNE R1, #'+', con8
      MOV A, R0
      ADD A, R2
      LJMP GuiKetQua
con8:
      CJNE R1, #'-', GuiKetQua
      MOV A, R0
      SUBB A, R2
      LJMP GuiKetQua	         
GuiKetQua:
      MOV B, #10d
      DIV AB
      
      CJNE A, #0, SEND_A
      JMP SEND_B
SEND_A:
      ADD A, #48d
      ACALL TRUYEN
SEND_B:
      MOV A, B
      ADD A, #48d
      ACALL TRUYEN
      
      
      ; in r3 ra ngoài
      
ChoXoa:
      ACALL choBamNut
      ;b?m linh tinh du?c nhung k ch?y dâu
      CJNE A, #'c', con5
      JMP DocSo1
con5:  
      ACALL TRUYEN
      JMP ChoXoa
      jmp Loop
	    
chia:
      
nhan:
      
cong:
      
tru:
 
	    
choBamNut:
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, duocNhan
      LJMP choBamNut
duocNhan:
      MOV P1, #0FEh
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, hang0
      MOV P1, #0FDh
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, hang1
      MOV P1, #0FBh
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, hang2
      MOV P1, #0F7h
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, hang3
      
hang0:
      MOV DPTR, #MAHANG0
      LJMP traVeNut
hang1:
      MOV DPTR, #MAHANG1
      LJMP traVeNut
hang2:
      MOV DPTR, #MAHANG2
      LJMP traVeNut
hang3:
      MOV DPTR, #MAHANG3
      LJMP traVeNut
traVeNut:
      RRC A 
      JNC khop
      INC DPTR 
      SJMP traVeNut
khop: 
      ACALL chongDoi
      MOV A,#0
      MOVC A, @A+DPTR 
      RET


chongDoi:
      MOV P1, #000H
      MOV A, P2
      ANL A, #00Fh
      CJNE A, #00Fh, chongDoi
      RET



TRUYEN:

      MOV SBUF, A
      CLR TI
      HERE: JNB TI, HERE 
      RET

      
delay: MOV R5,#100D
LABEL:
       ACALL DELAY1m
       DJNZ R5,LABEL
       RET
DELAY1m: MOV R6,#250D
       MOV R7,#250D
LOOP1: DJNZ R6,LOOP1
LOOP2: DJNZ R7,LOOP1
       RET
MAHANG0: DB '7','8','9','/'
MAHANG1: DB '4','5','6','x'
MAHANG2: DB '1','2','3','-'
MAHANG3: DB 'c','0','=','+'
;====================================================================
      END
