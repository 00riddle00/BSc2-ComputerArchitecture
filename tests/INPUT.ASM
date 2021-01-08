.8086
.model tiny

.code
org 100h

start:
CALL $-77775o                           ; 0100: E8 00 80         
JMP $-77774o                            ; 0103: E9 01 80         
CALL $-77773o                           ; 0106: E8 02 80         
JMP $-77772o                            ; 0109: E9 03 80         
CALL $-77771o                           ; 010C: E8 04 80         
CALL $-401o                             ; 010F: E8 FC FE         
JMP $-400o                              ; 0112: E9 FD FE         
CALL $-200o                             ; 0115: E8 7D FF         
JMP $-177o                              ; 0118: E9 7E FF         
CALL $-176o                             ; 011B: E8 7F FF         
CALL $-175o                             ; 011E: E8 80 FF         
CALL $-3o                               ; 0121: E8 FA FF         
CALL $-2o                               ; 0124: E8 FB FF         
CALL $-1o                               ; 0127: E8 FC FF         
CALL $-0o                               ; 012A: E8 FD FF         
CALL $+1o                               ; 012D: E8 FE FF         
CALL $+2o                               ; 0130: E8 FF FF         
CALL $+3o                               ; 0133: E8 00 00         
CALL $+4o                               ; 0136: E8 01 00         
CALL $+5o                               ; 0139: E8 02 00         
CALL $+22o                              ; 013C: E8 0F 00         
CALL $+41o                              ; 013F: E8 1E 00         
CALL $+43o                              ; 0142: E8 20 00         
CALL $+55o                              ; 0145: E8 2A 00         
CALL $+134o                             ; 0148: E8 59 00         
CALL $+177o                             ; 014B: E8 7C 00         
CALL $+200o                             ; 014E: E8 7D 00         
CALL $+201o                             ; 0151: E8 7E 00         
JMP $+202o                              ; 0154: E9 7F 00         
CALL $+202o                             ; 0157: E8 7F 00         
CALL $+203o                             ; 015A: E8 80 00         
CALL $+77777o                           ; 015D: E8 FC 7F         
JMP $+100000o                           ; 0160: E9 FD 7F         
CALL $+100001o                          ; 0163: E8 FE 7F         
JMP $+100002o                           ; 0166: E9 FF 7F         
JO $-176o                               ; 0169: 70 80            
JNO $-175o                              ; 016B: 71 81            
JB $-3o                                 ; 016D: 72 FB            
JAE $-2o                                ; 016F: 73 FC            
JE $-1o                                 ; 0171: 74 FD            
JNE $-0o                                ; 0173: 75 FE            
JBE $+1o                                ; 0175: 76 FF            
JA $+2o                                 ; 0177: 77 00            
JS $+3o                                 ; 0179: 78 01            
JNS $+22o                               ; 017B: 79 10            
JP $+41o                                ; 017D: 7A 1F            
JNP $+47o                               ; 017F: 7B 25            
JL $+55o                                ; 0181: 7C 2B            
JGE $+134o                              ; 0183: 7D 5A            
JLE $+177o                              ; 0185: 7E 7D            
JG $+200o                               ; 0187: 7F 7E            
LOOPNE $+201o                           ; 0189: E0 7F            
LOOPE $-176o                            ; 018B: E1 80            
LOOP $-175o                             ; 018D: E2 81            
JCXZ $-3o                               ; 018F: E3 FB            
JMP short $-176o                        ; 0191: EB 80            
JMP short $-2o                          ; 0193: EB FC            
JMP short $-0o                          ; 0195: EB FE            
JMP short $+3o                          ; 0197: EB 01            
JMP short $+41o                         ; 0199: EB 1F            
JMP short $+55o                         ; 019B: EB 2B            
JMP short $+201o                        ; 019D: EB 7F            
CALL ES:[BX+SI+111o]                    ; 019F: 26 FF 50 49      
CALL DS:[111111o]                       ; 01A3: FF 16 49 92      
CALL SS:[111111o]                       ; 01A7: 36 FF 16 49 92   
CALL [BX+SI]                            ; 01AC: FF 10            
CALL [BX+SI+111o]                       ; 01AE: FF 50 49         
CALL [BX+SI+177511o]                    ; 01B1: FF 90 49 FF      
CALL [BX+SI+311o]                       ; 01B5: FF 90 C9 00      
CALL [BX+SI+177311o]                    ; 01B9: FF 90 C9 FE      
CALL [BX+SI+177611o]                    ; 01BD: FF 50 89         
CALL [BX+SI+211o]                       ; 01C0: FF 90 89 00      
CALL [BX+SI+711o]                       ; 01C4: FF 90 C9 01      
CALL [BX+SI+111111o]                    ; 01C8: FF 90 49 92      
CALL DS:[111111o]                       ; 01CC: FF 16 49 92      
CALL AX                                 ; 01D0: FF D0            
JMP [BX+SI]                             ; 01D2: FF 20            
JMP AX                                  ; 01D4: FF E0            
CALL dword ptr [BX+SI+111o]             ; 01D6: FF 58 49         
CALL dword ptr [BX+SI+111111o]          ; 01D9: FF 98 49 92      
JMP dword ptr [BX+SI+111o]              ; 01DD: FF 68 49         
JMP dword ptr [BX+SI+111111o]           ; 01E0: FF A8 49 92      
ROL byte ptr [BX+SI], 1                 ; 01E4: D0 00            
ROR DX, 1                               ; 01E6: D1 CA            
RCL byte ptr [BP+111o], CL              ; 01E8: D2 56 49         
RCR word ptr [BP+DI+111111o], CL        ; 01EB: D3 9B 49 92      
SHL AL, 1                               ; 01EF: D0 E0            
SHR BP, 1                               ; 01F1: D1 ED            
SAR word ptr DS:[111111o], CL           ; 01F3: D3 3E 49 92      
MOV word ptr [BX+SI], CS                ; 01F7: 8C 08            
MOV SS, DX                              ; 01F9: 8E D2            
LEA SI, dword ptr [BP+DI+111111o]       ; 01FB: 8D B3 49 92      
LES SI, dword ptr [BP+DI+111111o]       ; 01FF: C4 B3 49 92      
LDS DI, dword ptr [BP+111o]             ; 0203: C5 7E 49         
POP word ptr [BX+SI]                    ; 0206: 8F 00            
INC byte ptr DS:[111111o]               ; 0208: FE 06 49 92      
INC word ptr [BP+DI+111111o]            ; 020C: FF 83 49 92      
DEC AL                                  ; 0210: FE C8            
DEC DX                                  ; 0212: 4A               
PUSH word ptr DS:[111111o]              ; 0213: FF 36 49 92      
PUSH word ptr [BP+DI+111111o]           ; 0217: FF B3 49 92      
PUSH BP                                 ; 021B: 55               
TEST byte ptr [SI+177622o], 333o        ; 021C: F6 44 92 DB      
TEST byte ptr [BX+DI], 333o             ; 0220: F6 01 DB         
MOV word ptr [SI+111111o], 162333o      ; 0223: C7 84 49 92 DB E4
MOV SP, 111111o                         ; 0229: BC 49 92         
NOT byte ptr DS:[111111o]               ; 022C: F6 16 49 92      
NEG BP                                  ; 0230: F7 DD            
MUL byte ptr DS:[111111o]               ; 0232: F6 26 49 92      
IMUL BP                                 ; 0236: F7 ED            
DIV byte ptr DS:[111111o]               ; 0238: F6 36 49 92      
IDIV BP                                 ; 023C: F7 FD            
TEST BL, byte ptr DS:[111111o]          ; 023E: 84 1E 49 92      
TEST DX, word ptr [SI]                  ; 0242: 85 14            
XCHG AL, byte ptr [BP+DI+111111o]       ; 0244: 86 83 49 92      
XCHG CX, SP                             ; 0248: 87 CC            
ADD byte ptr [BX+SI], DL                ; 024A: 00 10            
ADD word ptr [BX+SI], DX                ; 024C: 01 10            
ADD byte ptr [SI], DL                   ; 024E: 00 14            
ADD word ptr [SI], DX                   ; 0250: 01 14            
ADD AL, CL                              ; 0252: 02 C1            
OR AX, CX                               ; 0254: 0B C1            
ADD byte ptr DS:[111111o], BL           ; 0256: 00 1E 49 92      
ADD word ptr DS:[111111o], BX           ; 025A: 01 1E 49 92      
ADD CL, AL                              ; 025E: 02 C8            
ADD CX, AX                              ; 0260: 03 C8            
ADD DL, byte ptr [SI+111o]              ; 0262: 02 54 49         
ADD DX, word ptr [SI+111o]              ; 0265: 03 54 49         
ADD DL, byte ptr [SI+111111o]           ; 0268: 02 94 49 92      
ADD DX, word ptr [SI+111111o]           ; 026C: 03 94 49 92      
OR BL, byte ptr DS:[111111o]            ; 0270: 0A 1E 49 92      
ADD BX, word ptr DS:[111111o]           ; 0274: 03 1E 49 92      
ADC byte ptr [SI+111o], DL              ; 0278: 10 54 49         
SBB word ptr [SI+111o], DX              ; 027B: 19 54 49         
SBB DL, byte ptr [BX+SI]                ; 027E: 1A 10            
ADC DX, word ptr [BX+SI]                ; 0280: 13 10            
AND byte ptr [SI+111111o], DL           ; 0282: 20 94 49 92      
SUB word ptr [SI+111111o], DX           ; 0286: 29 94 49 92      
SUB DL, byte ptr [SI]                   ; 028A: 2A 14            
AND DX, word ptr [SI]                   ; 028C: 23 14            
XOR byte ptr [BP+DI+111o], AL           ; 028E: 30 43 49         
CMP word ptr [BP+DI+111o], AX           ; 0291: 39 43 49         
CMP AL, byte ptr [BP+DI+111111o]        ; 0294: 3A 83 49 92      
XOR AX, word ptr [BP+DI+111111o]        ; 0298: 33 83 49 92      
ADD byte ptr [SI+177622o], 333o         ; 029C: 80 44 92 DB      
ADD word ptr [SI+111111o], 177733o      ; 02A0: 83 84 49 92 DB   
OR byte ptr [SI+177622o], 333o          ; 02A5: 80 4C 92 DB      
ADC word ptr [SI+111111o], 177733o      ; 02A9: 83 94 49 92 DB   
ADD word ptr [SI+111111o], 162333o      ; 02AE: 81 84 49 92 DB E4
ADD byte ptr [SI+111111o], 333o         ; 02B4: 80 84 49 92 DB   
ADD byte ptr DS:[111111o], 333o         ; 02B9: 80 06 49 92 DB   
SBB byte ptr [SI+177622o], 333o         ; 02BE: 80 5C 92 DB      
AND word ptr [SI+111111o], 177733o      ; 02C2: 83 A4 49 92 DB   
SUB byte ptr [SI+177622o], 333o         ; 02C7: 80 6C 92 DB      
XOR byte ptr [SI+177622o], 333o         ; 02CB: 80 74 92 DB      
CMP word ptr [SI+111111o], 177733o      ; 02CF: 83 BC 49 92 DB   
MOV byte ptr [BP+DI+111111o], AL        ; 02D4: 88 83 49 92      
MOV word ptr [BP+DI+111111o], AX        ; 02D8: 89 83 49 92      
MOV AL, byte ptr [BP+DI+111o]           ; 02DC: 8A 43 49         
MOV AX, word ptr [BP+DI+111o]           ; 02DF: 8B 43 49         
ADD AL, 111o                            ; 02E2: 04 49            
ADD AX, 111111o                         ; 02E4: 05 49 92         
POP ES                                  ; 02E7: 07               
OR AX, CX                               ; 02E8: 0B C1            
OR AL, 111o                             ; 02EA: 0C 49            
OR AX, 111111o                          ; 02EC: 0D 49 92         
PUSH CS                                 ; 02EF: 0E               
ADC AL, 111o                            ; 02F0: 14 49            
ADC AX, 111111o                         ; 02F2: 15 49 92         
POP SS                                  ; 02F5: 17               
PUSH DS                                 ; 02F6: 1E               
DAA                                     ; 02F7: 27               
SUB AL, 111o                            ; 02F8: 2C 49            
SUB AX, 111111o                         ; 02FA: 2D 49 92         
CMP AL, 111o                            ; 02FD: 3C 49            
CMP AX, 111111o                         ; 02FF: 3D 49 92         
AAS                                     ; 0302: 3F               
INC SI                                  ; 0303: 46               
DEC BX                                  ; 0304: 4B               
PUSH AX                                 ; 0305: 50               
POP CX                                  ; 0306: 59               
NOP                                     ; 0307: 90               
XCHG BP, AX                             ; 0308: 95               
CBW                                     ; 0309: 98               
WAIT                                    ; 030A: 9B               
LAHF                                    ; 030B: 9F               
MOV AL, byte ptr DS:[111111o]           ; 030C: A0 49 92         
MOV AL, byte ptr ES:[111111o]           ; 030F: 26 A0 49 92      
MOV AX, word ptr DS:[111111o]           ; 0313: A1 49 92         
MOV byte ptr SS:[111111o], AL           ; 0316: 36 A2 49 92      
MOV word ptr DS:[111111o], AX           ; 031A: A3 49 92         
MOVSB                                   ; 031D: A4               
CMPSW                                   ; 031E: A7               
TEST AL, 111o                           ; 031F: A8 49            
TEST AX, 111111o                        ; 0321: A9 49 92         
STOSB                                   ; 0324: AA               
LODSW                                   ; 0325: AD               
SCASW                                   ; 0326: AF               
MOV AH, 11o                             ; 0327: B4 09            
MOV DX, 736o                            ; 0329: BA DE 01         
RET 111111o                             ; 032C: C2 49 92         
RET                                     ; 032F: C3               
RETF 111111o                            ; 0330: CA 49 92         
RETF                                    ; 0333: CB               
INT 41o                                 ; 0334: CD 21            
INTO                                    ; 0336: CE               
AAM                                     ; 0337: D4 0A            
XLAT                                    ; 0339: D7               
IN AL, 111o                             ; 033A: E4 49            
OUT 1o, AX                              ; 033C: E7 01            
IN AX, DX                               ; 033E: ED               
OUT DX, AL                              ; 033F: EE               
LOCK                                    ; 0340: F0               
REP                                     ; 0341: F3               
HLT                                     ; 0342: F4               
STC                                     ; 0343: F9               
CLI                                     ; 0344: FA               
CLD                                     ; 0345: FC               
end start
