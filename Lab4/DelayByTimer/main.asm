;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Fri Apr 1 2022
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
      jmp   Setup

;====================================================================
; CODE SEGMENT
;====================================================================

      org   0100h
Setup:	
      MOV TMOD, #011H
      SETB TR1
      MOV R0, #017h
      MOV R1, #03BH
      MOV R2, #000H
      MOV R3, #000H
      JMP Loop
      ;R0 = HOUR
      ;R1 = MINUTE
      ;R2 = SEC
      ;R3 = COUNT FROM 0 - 20 -> TIMER(50ms)*20 = 1s
      ; Write your code here
Loop:	
      MOV TH1, #03CH
      MOV TL1, #0B0H 
 Here1: 
      ACALL Scan
      JNB TF1, Here1
      CLR TF1
      INC R3
      ACALL check20
      JMP Loop


;R3, R2, R1, R0
Scan:
      MOV A, R0
      MOV B, #0AH
      DIV AB
      CLR P3.7
      MOV P3, A
      SETB P3.4
      ACALL Delay
      
      CLR P3.4
      MOV P3, B
      SETB P3.5
      ACALL Delay
      
      MOV A, R1
      MOV B, #0AH
      DIV AB
      CLR P3.5
      MOV P3, A
      SETB P3.6
      ACALL Delay
      
      CLR P3.6
      MOV P3, B
      SETB P3.7
      ACALL Delay
      RET


      
checkHour:
      CJNE R0, #018H, returnCheckHour
      MOV R0, #0
returnCheckHour:
      RET

checkMin:
      CJNE R1, #03CH, returnCheckSec
      MOV R1, #0
      INC R0
      ACALL checkHour
returnCheckMin:
      RET

checkSec:
      CJNE R2, #03CH, returnCheckSec
      MOV R2, #0
      INC R1
      ACALL checkMin
returnCheckSec:
      RET

check20:
      CJNE R3, #013H, returnCheck20
      MOV R3, #0
      INC R2
      ACALL checkSec
 returnCheck20:
      RET



      
Delay: 
      MOV TH0, #0FCH
      MOV TL0, #018H 
      SETB TR0 
Here2: JNB TF0, Here2
      CLR TR0
      CLR TF0
      RET
     
;====================================================================
      END