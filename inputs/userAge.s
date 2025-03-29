section .bss
    buffer resb 4

section .data
    prompt db "Enter your age: ", 0
    prompt_len equ $ - prompt
    message db "You are ", 0
    message_len equ $ - message
    years db " years old!", 10 ,0
    years_len equ $ - years

section .text
    global _start

_start:
    ; print the prompt for age
    mov rax, 1                ; sys_write
    mov rdi, 1                ; stdout
    lea rsi, prompt           ; pointer to prompt string
    mov rdx, prompt_len       ; length of prompt
    syscall

    ; read the age entered
    mov rax, 0                ; sys_read
    mov rdi, 0                ; stdin
    lea rsi, buffer           ; buffer for input
    mov rdx, 4               ; max bytes to read
    syscall                   

    ; remove newline from input
    mov rcx, rax              ; store input length
    dec rcx                   ; move back one character
    mov byte [buffer + rcx], 0  ; replace newline with null terminator

    ; print "You are "
    mov rax, 1
    mov rdi, 1
    lea rsi, message
    mov rdx, message_len
    syscall

    ; print age (without newline)
    mov rax, 1
    mov rdi, 1
    lea rsi, buffer
    mov rdx, rcx              
    syscall

    ; print " years old!"
    mov rax, 1
    mov rdi, 1
    lea rsi, years
    mov rdx, years_len
    syscall

    ; exit program
    mov rax, 60
    xor rdi, rdi
    syscall
