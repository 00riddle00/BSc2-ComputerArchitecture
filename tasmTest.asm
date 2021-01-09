; This is a testing file for TASM syntax and
; the specifics of various operations. 
;
; This file assembles to .EXE:
;   tasm -zi tasmtest.asm
;   tlink -v tasmtest.obj
.8086

.model small
.stack 100h

.data
    message db "Hello World",13,10,"$"
.code


; ---------------------------------------------------------------------------------
;                         Two equivalent expressions
; ---------------------------------------------------------------------------------
;add word ptr [SI+9249h], 0FFDBh ; 83 84 49 92 DB 
;add word ptr [SI-6DB7h], 0FFDBh ; 83 84 49 92 DB

; ---------------------------------------------------------------------------------
;                           TASM/NASM differences
; ---------------------------------------------------------------------------------

    ; ---------------------------- TASM ---------------------------------
    ; (same results when assembling both to .COM and .EXE)
    ;
    ;MOV SI,  0102h              ; BE 02 01
    ;MOV SI, [0102h]             ; BE 02 01
    ;MOV SI, word ptr [0102h]    ; BE 02 01
    ;MOV SI, word ptr DS:[0102h] ; 8B 36 02 01      
    ;MOV SI, word ptr ES:[0102h] ; 26 8B 36 02 01
    ; same with 'byte ptr' and other 'r/m' values
    ;
    ;CALL AX                    ; FF D0
    ;
    ;CALL word ptr [0102h]      ; =illegal immediate
    ;CALL word ptr DS:[0102h]   ; FF 16 02 01 
    ;
    ;CALL word ptr [BX+SI]      ; FF 10
    ;CALL word ptr [BX+SI]      ; FF 10
    ;CALL word ptr DS:[BX+SI]   ; FF 10
    ;CALL ES:[BX+SI]            ; 26 FF 10
    ;CALL word ptr ES:[BX+SI]   ; 26 FF 10
    ; ---------------------------- DEBUG.COM ----------------------------
    ;MOV SI,  0102              ; BE 02 01
    ;MOV SI, [0102]             ; 8B 36 02 01
    ;MOV SI, word ptr [0102]    ; 8B 36 02 01      
    ;MOV SI, word ptr DS:[0102] ; 3E 8B 36 02 01      
    ;MOV SI, word ptr ES:[0102] ; 26 8B 36 02 01
    ;
    ;CALL AX                    ; FF D0
    ;
    ;CALL word ptr [0102h]      ; FF 16 02 01 
    ;CALL word ptr DS:[0102h]   ; 3E FF 16 02 01
    ;
    ;CALL [BX+SI]               ; FF 18
    ;CALL word ptr [BX+SI]      ; FF 10
    ;CALL word ptr DS:[BX+SI]   ; 3E FF 10
    ;CALL ES:[BX+SI]            ; 26 FF 18
    ;CALL word ptr ES:[BX+SI]   ; 26 FF 10
    ; -------------------------------------------------------------------

; ---------------------------------------------------------------------------------
;                                 short jumps
; ---------------------------------------------------------------------------------
;jg $-128  ; =$-200o  ; out of range by 2 bytes
;jg $-127  ; =$-177o  ; out of range by 1 byte
;jg $-126  ; =$-176o  ; 7F 80  = 128(=-128)=200o ; jumps -128 bytes
;jg $-125  ; =$-175o  ; 7F 81  = 129(=-127)=201o
;jg  $-3   ; =$-003o  ; 7F FB  = 251(=-5)  =373o
;jg  $-2   ; =$-002o  ; 7F FC  = 252(=-4)  =374o
;jg  $-1   ; =$-001o  ; 7F FD  = 253(=-3)  =375o
;jg  $+0   ; =$+000o  ; 7F FE  = 254(=-2)  =376o
;jg  $+1   ; =$+001o  ; 7F FF  = 255(=-1)  =377o  ; jumps -1 bytes
;jg  $+2   ; =$+002o  ; 7F 00  = 0         =000o  ; jumps 0 bytes (since 7F 00 is 2 bytes already)
;jg  $+3   ; =$+003o  ; 7F 01  = 1         =001o  ; jumps 1 bytes (...)
;jg  $+18  ; =$+022o  ; 7F 10  =16         =020o
;jg  $+33  ; =$+041o  ; 7F 1F  =31         =037o
;jg  $+35  ; =$+047o  ; 7F 25  =37         =045o
;jg  $+45  ; =$+055o  ; 7F 2B  =43         =053o
;jg  $+92  ; =$+134o  ; 7F 5A  =90         =132o
;jg  $+127 ; =$+177o  ; 7F 7D  =125        =175o
;jg  $+128 ; =$+200o  ; 7F 7E  =126        =176o
;jg  $+129 ; =$+201o  ; 7F 7F  =127        =177o ; jumps 127 bytes
;jg  $+130 ; =$+202o  ; out of range by 1 byte,  =202o
;jg  $+131 ; =$+203o  ; out of range by 2 bytes, =203o

; ---------------------------------------------------------------------------------
;                              near calls and jumps
; ---------------------------------------------------------------------------------
;call $-1000000              ; E8 BD BD

;call $-65538                ; relative E8 FB FF ; jumps -5 bytes
;call $-65537                ; relative E8 FC FF ; jumps -4 bytes
;call $-65536                ; relative jump ouf of range by 8003h bytes
;call $-65535                ; relative jump ouf of range by 8002h bytes
;call $-65534                ; relative jump ouf of range by 8001h bytes

;call $-65533                ; E8 00 00 ; jumps 0 bytes
;call $-65532                ; E8 01 00 ; jumps 1 bytes
;call $-65531                ; E8 02 00 ; jumps 2 bytes

;call $-32770                ; E8 FB 7F
;call $-32769                ; E8 FC 7F
;call $-32768                ; E8 FD 7F
;call $-32767                ; E8 FE 7F
;call $-32766                ; E8 FF 7F

; ---------------------------------------------------------
;call $-32765 ; =$-077775o   ; E8 00 80  = -32768 = 000 200 ; jumps -32768 bytes 8000h = 100 000o. neg(octal)-3
;call $-32764 ; =$-077774o   ; E8 01 80  = -32767 = 001 200                            = 100 001o
;call $-32763 ; =$-077773o   ; E8 02 80  = -32766 = 002 200                            = 100 002o
;call $-32762 ; =$-077772o   ; E8 03 80  = -32765 = 003 200                            = 100 003o
;call $-32761 ; =$-077771o   ; E8 04 80  = -32764 = 004 200                              100 004o

;call $-257   ; =$-000401o   ; E8 FC FE  = -260   = 374 376                            = 177 374o
;call $-256   ; =$-000400o   ; E8 FD FE  = -259   = 375 376                            = 177 375o

;call $-128   ; =$-000200o   ; E8 7D FF  = -131   = 175 377                          
;call $-127   ; =$-000177o   ; E8 7E FF  = -130   = 176 377 ; jmp $-177o => E9 7E FF
;call $-126   ; =$-000176o   ; E8 7F FF  = -129   = 177 377 ; (jmp short) "jmp $-176" verciasi i EB 80,
                                                            ; kur 80 = 128, tai jumpina -128, o ne -129, 
                                                            ; kaip call atveju, nes EB 80 uzima 2 baitus, 
                                                            ; o ne 3. Disasembliavus atgal gausime
                                                            ; "jmp short $-176o"

;call $-125   ; =$-000175o   ; E8 80 FF  = -128   = 200 377 ; (jmp short)

;call  $-3    ; =$-000003o   ; E8 FA FF  = -6     = 372 377 ; (jmp short)
;call  $-2    ; =$-000002o   ; E8 FB FF  = -5     = 373 377 ; (jmp short)
;call  $-1    ; =$-000001o   ; E8 FC FF  = -4     = 374 377 ; (jmp short)
;call  $+0    ; =$+000000o   ; E8 FD FF  = -3     = 375 377 ; (jmp short)
;call  $+1    ; =$+000001o   ; E8 FE FF  = -2     = 376 377 ; jumps -2 bytes (jmp short)
;call  $+2    ; =$+000002o   ; E8 FF FF  = -1     = 377 377 ; jumps -1 byte  (jmp short)
;call  $+3    ; =$+000003o   ; E8 00 00  = +0     = 000 000 ; jumps 0 bytes (since E8 00 00 is 3 bytes already) (jmp short)
;call  $+4    ; =$+000004o   ; E8 01 00  = +1     = 001 000 ; jumps 1 bytes (since E8 00 00 is 3 bytes already) (jmp short)
;call  $+5    ; =$+000005o   ; E8 02 00  = +2     = 002 000 ; jumps 2 bytes (since E8 00 00 is 3 bytes already) (jmp short)

;call  $+18   ; =$+000022o   ; E8 0F 00  = +15    = 017 000 ; (jmp short)
;call  $+33   ; =$+000041o   ; E8 1E 00  = +30    = 036 000 ; (jmp short)
;call  $+35   ; =$+000043o   ; E8 20 00  = +32    = 040 000 ; (jmp short)
;call  $+45   ; =$+000055o   ; E8 2A 00  = +42    = 052 000 ; (jmp short)
;call  $+92   ; =$+000134o   ; E8 59 00  = +89    = 131 000 ; (jmp short)

;call $+127   ; =$+000177o   ; E8 7C 00  = +124   = 174 000 ; (jmp short)
;call $+128   ; =$+000200o   ; E8 7D 00  = +125   = 175 000 ; (jmp short)
;call $+129   ; =$+000201o   ; E8 7E 00  = +126   = 176 000 ; (jmp short) "jmp $+201o" verciasi i EB 7F, 
                                                            ; kur 7F = 127, nes jumpina 127 bytes, o ne 
                                                            ; 126, kaip call atveju, nes EB 7F uzima 2
                                                            ; baitus, o ne 3. Disasembliavus atgal 
                                                            ; gausime  "jmp short $+201o"

;call $+130   ; =$+000202o   ; E8 7F 00  = +127   = 177 000 ; jmp $+202o => E9 7F 00
;call $+131   ; =$+000203o   ; E8 80 00  = +128   = 200 000

;call $+32767 ; =$+077777o   ; E8 FC 7F  = +32764 = 374 177
;call $+32768 ; =$+100000o   ; E8 FD 7F  = +32765 = 375 177
;call $+32769 ; =$+100001o   ; E8 FE 7F  = +32766 = 376 177
;call $+32770 ; =$+100002o   ; E8 FF 7F  = +32767 = 377 177 ; jumps +32767 bytes
; ---------------------------------------------------------
;call $+32771                ; E8 00 80 ; jumps +32768 bytes

;call $+65534                ; E8 FB FF ; jumps -5 bytes
;call $+65535                ; E8 FC FF ; jumps -4 bytes
;call $+65536                ; E8 FD FF ; jumps -3 bytes
;call $+65537                ; E8 FE FF ; jumps -2 bytes
;call $+65538                ; E8 FF FF ; jumps -1 byte 

;call $+65539                ; E8 00 00 ; jumps 0 bytes
;call $+65540                ; E8 01 00 ; jumps 1 bytes
;call $+65541                ; E8 02 00 ; jumps 2 bytes

;call $+1000000              ; E8 3D 42
; ---------------------------------------------------------------------------------
end
