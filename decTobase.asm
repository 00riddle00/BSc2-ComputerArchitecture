; ============================================================
;  DESCRIPTION
; ============================================================
; Programa: Nr. 32
; Uzduoties salyga: 
    ; Parasykite programa, kuri iveda skaiciu desimtaineje 
    ; sistemoje. Tuomet ivedamas skaicius, kuris simbolizuoja 
    ; sistema. Isspausdina pirmaji skaicių ivestoje sistemoje. 
    ; Pavyzdziui: Jei skaičiai 5 ir 2 isvesti turi 101, jei 
    ; skaiciai 20 ir 16 tai atspausdina 14.
; Atliko: Tomas Giedraitis
; ============================================================

; ============================================================
;  MACROS
; ============================================================
; print string
print macro string               
    push dx
    push ax
    mov ah, 09                      
    mov dx, offset string
    int 21h
    pop ax
    pop dx
endm

; print newline
print_nl macro
    push dx
    push ax
    mov ah, 02
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    pop ax
    pop dx
endm

; print string with newline
printl macro string               
    print string
    print_nl
endm

; print char
putchar macro char
   push dx
   push ax
   mov dl, offset char
   mov ah, 02
   int 21h
   pop ax
   pop dx
endm

exit macro
    MOV ax, 4c00h                   
    INT 21h                         
endm
     
; ============================================================
;  SETTINGS
; ============================================================
.model small     ; one code segment one data segment
.stack 100h
jumps

; ============================================================
;  CONSTANTS
; ============================================================

MAX_INPUT_LEN = 6 ; 5 + <CR>
MAX_BASE_LEN = 3  ; 2 + <CR>
MAX_UNARY_NUM = 1000 

; ============================================================
;  DATA
; ============================================================

.data
    op_input	       dw 0
    op_to_base	       dw 0

    capacity_input     db MAX_INPUT_LEN
    size_input         db ?
    number_input       db MAX_INPUT_LEN dup (?)

    capacity_to_base   db MAX_BASE_LEN
    size_to_base       db ?
    number_to_base     db MAX_BASE_LEN dup (?)

    base10_multiplier    dw 000Ah
    spacing              dw 0004

    sep1                 db '=============================================================================$'
    sep2                 db '-----------------------------------------------------------------------------$'
    desc                 db 'Programa konvertuoja desimtaini skaiciu i jusu pasirinkta skaiciavimo sistema$'
    prompt1_msg          db 'Iveskite skaiciu (max=65535):', 13, 10, '> $'
    prompt2_msg          db 'Iveskite pasirinktos skaiciavimo sistemos pagrinda (min=1, max=62):', 13, 10, '> $'
    errmsg_no_input      db '[ERROR] Iveskite bent viena simboli!$'
    errmsg_nan           db '[ERROR] Kiekvienas ivestas simbolis turi buti skaitmuo!$'
    errmsg_num_max       db '[ERROR] Ivestas skaicius per didelis! (netelpa zodyje)$'
    errmsg_base_zero     db '[ERROR] Ivestas pagrindas mazesnis uz 1!$'
    errmsg_base_max      db '[ERROR] Ivestas pagrindas didesnis uz 62!$'
    errmsg_unary_max     db '[ERROR] Skaicius per didelis vienetainei sistemai!$'
    result_msg           db 'Rezultatas: $'

; ============================================================
;  CODE
; ============================================================

.code

; ------------------------------------------------
; PROCEDURES
; ------------------------------------------------

; this proc takes a decimal number in ASCII chars 
; and saves the numeric value in one word
;
; params[0]: ptr to str (source) (must have a '$' char at the end)
; params[1]: ptr to int (destination)
;
; a user has to handle these error labels:
;    err_nan
;    err_num_max
; including cleaning the stack after error occurs
proc store_number_in_word
    ; preparing the stack
    push bp
    mov bp, sp
    ; reading arguments
    mov si, [bp+6]
    mov di, [bp+4]

    ; procedure body
    xor ax, ax  
    xor bx, bx

    read_chr:
        xchg ax, bx         ; store current number in bx
        lodsb               ; put current digit symbol from ds:[si] to al
        cmp al, '$'
       je short end_of_input
        sub al, '0'
       jc short e1_err_nan
        cmp al, 9
       ja short e1_err_nan

        xchg ax, bx         ; put current number in ax for multiplication
        mul [base10_multiplier]
        add ax, bx          ; update the current number (which is in ax for now)
       jc short e2_err_num_max

       jmp short read_chr

    end_of_input:
        xchg ax, bx
        stosw				; saugome skaiciu zodyje adresu es:[di]
    
    ; clearing the stack
        pop bp
    ; return
        ret 4

    e1_err_nan:
        call err_nan
    e2_err_num_max:
        call err_num_max

store_number_in_word ENDP	

; ------------------------------------------------/

start:
    MOV ax, @data                   ; perkelti data i registra ax
    MOV ds, ax                      ; perkelti ax (data) i data segmenta
    MOV es, ax                      ; perkelti ax (data) i data segmenta

    ; Isvesti programos aprasa
    printl sep1
    printl desc
    printl sep1
    
prompt1:
    ; Isvesti uzklausa nr.1
    print prompt1_msg

    ; skaityti eilute
    MOV dx, offset capacity_input      ; skaityti i buferio offseta 
    MOV ah, 0Ah                        ; eilutes skaitymo subprograma
    INT 21h                            ; dos'o INTeruptas
    print_nl ; cia reikia print newline, nes paskutinis char isvedime buvo
             ; <CR>, kuris grazina BIOS kursoriu atgal i eilutes pradzia, ir kadangi 
             ; po jo nera <LF>, kursorius nepasislenka viena eilute zemyn. Taigi sekantis
             ; outputas uzrasys ant virsaus eilutes pradzioje, panaikindamas senaji output'a

    ; ivesties ilgis
    xor bx, bx
    MOV bl, size_input              ; idedam i bl kiek simboliu is viso
    cmp bl, 0                       ; ivesties ilgio validacija
    je err_no_input

    mov byte ptr [number_input+bx], '$' ; write '$' instead of 'CR' symbol

    ; passing arguments to the procedure
    mov bp, sp
    push offset number_input
    push offset op_input

    call store_number_in_word

prompt2:
    ; Isvesti uzklausa nr.2
    printl sep2
    print prompt2_msg

    ; skaityti eilute
    MOV dx, offset capacity_to_base    ; skaityti i buferio offseta 
    MOV ah, 0Ah                        ; eilutes skaitymo subprograma
    INT 21h                            ; dos'o INTeruptas
    print_nl

    ; ivesties ilgis
    xor bx, bx
    mov bl, size_to_base            ; idedam i bl kiek simboliu is viso
    cmp bl, 0                       ; ivesties ilgio validacija
    je err_no_input

    printl sep2

    mov byte ptr [number_to_base+bx], '$' ; write '$' instead of 'CR' symbol

    ; passing arguments to the procedure
    mov bp, sp
    push offset number_to_base
    push offset op_to_base

    call store_number_in_word

    cmp [op_to_base], 0
    je err_base_zero
    cmp [op_to_base], 62
    ja err_base_max

    xor cx, cx
    mov ax, [op_input]
    mov bx, [op_to_base]

    cmp bx, 1
    jne short conversion

unary_conversion:
    cmp [op_input], MAX_UNARY_NUM
    ja err_unary_max

    mov cx, [op_input]
    inc cx
    mov ah, 2
print_one:
    mov dl, '1'
    mov al, cl
    div byte ptr spacing
    cmp ah, 0
    je short print_space
    mov ah, 2
    int 21h
    loop print_one
    jmp short exit_program
print_one_no_space:
    mov dl, '1'
    int 21h
    loop print_one
    jmp short exit_program
print_space:
    mov ah, 2
    mov dl, 20h
    int 21h
    jmp short print_one_no_space
 
jmp short exit_program

conversion:
	inc	cl
	
	xor	dx, dx		    ; isvalyti dx, nes cia bus liekana po div
	div	bx              ; div ax/bx, ir liekana padedama dx
	push dx		        ; padeti skaitmeni
	
	cmp	ax, 0		    ; jei jau skaicius isdalintas
    jz short  converted  	; tai eiti i pabaiga

    xchg ax, dx
    mov al, cl
    div byte ptr spacing
    cmp ah, 0
    jne short convert

    push 99
    jmp short convert      ; kitu atveju imti kita skaitmeni

convert:
    xchg ax, dx
    jmp short conversion

converted:
    print result_msg

print_result:
    mov	ah, 2            ; atspausdinti skaitmenis
    pop	dx
    cmp dx, 99
    je short process_space

    cmp dx, 10
    jb short process_number
    cmp dx, 36
    jb short process_uppercase

    process_lowercase:
        sub dx, 35
        add	dx, 60h
        jmp short short print_symbol

    process_uppercase:
        sub	dx, 9
        add dx, 40h
        jmp short print_symbol

    process_number:
        add	dx, '0'
        jmp short print_symbol

    process_space:
        mov dx, 20h
        inc cl
        jmp short print_symbol

    print_symbol:
        int	21h
        ;loop print_result
        dec	cl
        jnz print_result

exit_program:
    exit

err_no_input:
    printl sep2
    printl errmsg_no_input
    printl sep2
    jmp prompt1

err_base_zero:
    printl sep2
    printl errmsg_base_zero
    printl sep2
    jmp prompt1

err_base_max:
    printl sep2
    printl errmsg_base_max
    printl sep2
    jmp prompt1

err_unary_max:
    printl sep2
    printl errmsg_unary_max
    printl sep2
    jmp prompt1

; Handling labels of the procedure
err_nan:
    printl sep2
    printl errmsg_nan
    printl sep2
    jmp prompt1

err_num_max:
    printl sep2
    printl errmsg_num_max
    printl sep2
    jmp prompt1

end start
