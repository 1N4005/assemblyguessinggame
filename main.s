; number guessing game
; written in x86_64 asssembly
; probably only works on ubuntu idk
; only works with single digit numbers because assembly hard

; also the number is always 5

section .data
prompt: db "input a number", 10
prompt_len: equ $-prompt

less_prompt: db "too small!", 10, "input a number", 10
less_prompt_len: equ $-less_prompt

more_prompt: db "too big!", 10, "input a number", 10
more_prompt_len: equ $-more_prompt

not_a_number_prompt: db "not a number!", 10, "input a number", 10
not_a_number_prompt_len: equ $-not_a_number_prompt

equal: db "correct!", 10

number: equ '5'

newline: db 10

section .bss
out: db ?

section .text
global _start
_start:
    ; prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    jmp main
main:
    ; input
    mov rax, 0
    mov rdi, 0
    mov rsi, out
    mov rdx, 1
    syscall

    cmp byte [out], 0xa ; newline check
    je main

    ; check that character is a number
    cmp byte [out], 0x30 ; /
    jle not_a_number

    cmp byte [out], 0x58 ; :
    jge not_a_number
    
    ; check for correct, less, or more
    cmp byte [out], number
    je print
    jl less
    jg more
not_a_number:
    mov rax, 1
    mov rdi, 1
    mov rsi, not_a_number_prompt
    mov rdx, not_a_number_prompt_len
    syscall

    jmp main
less:
    mov rax, 1
    mov rdi, 1
    mov rsi, less_prompt
    mov rdx, less_prompt_len
    syscall

    jmp main
more:
    mov rax, 1
    mov rdi, 1
    mov rsi, more_prompt
    mov rdx, more_prompt_len
    syscall

    jmp main
print:
    ; print out
    mov rax, 1
    mov rdi, 1
    mov rsi, equal
    mov rdx, 9
    syscall

    jmp end
end:
    mov rax, 60
    mov rdi, 0
    syscall
