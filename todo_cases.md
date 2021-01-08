# Notes

CASE_1 (todo)
row: 0x  column: xF
  POP CS - cannot write to CS

CASE_2 (todo)
row: 82 *_ALU1 r/m8,d8  columns: ALL
  ADD, OR, ADC, SBB, AND, SUB, XOR, CMP - if 'w' = 0, then 's' is also set to 0.
  Trying to disassemble machine code where 'w'=0, 's'=1 will not work

CASE_3 (liko tik comment)
row: 8C _MOV r/m16,sr columns: 20, 28, 30, 38
row: 8E _MOV r/m16,sr columns: 20, 28, 30, 38
  in 'MOV segreg, r/m', or 'MOV r/m, segreg' machine code's 3 bits between 
  mod and r/m cannot start with '1'. Dissasembling such code will not work.

CASE_4 (todo)
  row: C6 _MOV r/m8,d8    columns: 08, 10, 18, 20, 28, 30, 38
  row: C7 _MOV r/m16,d16  columns: 08, 10, 18, 20, 28, 30, 38
    MOV rm, immediate - it's machine code's 3 bits between mod and r/m
    cannot be other than '000', or else the disassembling will not work

CASE_5 (liko tik comment)
row: D0 _ROT r/m8,1  column: 30
row: D1 _ROT r/m16,1  column: 30
row: D2 _ROT r/m8,CL  column: 30
row: D3 _ROT r/m16,CL column: 30
  SHL/SAL - appearing for the second time, first time - in column 20. 
  TASM does not distinguish between these two, assembles using the machine code of the first one,
  so dissasembly of the second one's machine code will not occur.

CASE_6 (liko tik comment)
row: F6 _ALU2 r/m8,d8    column: 08
row: F7 _ALU2 r/m16,d16  column: 08
  There is no such instruction starting with F6 or F7 which would have '001' as the
  3 bits between mod and r/m

CASE_7 (liko tik comment)
row: Dx  column: x6
  SALC - Available beginning with 8086, but only documented since Pentium Pro. TASM does not recognize it.
