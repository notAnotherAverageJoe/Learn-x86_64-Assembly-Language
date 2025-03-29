.section .bss
    age: .skip 20

.section .data
    prompt: .asciz "Enter your age: "
    message: .asciz "You are "
    years: .asciz " years old"

.section .text

_start:
    ; print the prompt for age
    mov rax, 1 ;sys call for stout
    mov rdi, 1 ;file descriptor for stdout
    lea rsi,[prompt] ; pointer to prompt string
    mov rdx, 20
    syscall
    ; read the age entered
    mov rax, 0
    mov rdi, 0
    lea rsi, [age]
    mov rdx, 20
    syscall
    ; print the message for age start
    mov rax, 1
    mov rdi, 1
    lea rsi, [message]
    mov rdx, 20
    syscall
    ; print out age
    mov rax, 1
    mov rdi, 1
    lea rsi, [age]
    mov rdx, 20
    syscall
     ; print the message for age end
    mov rax, 1
    mov rdi, 1
    lea rsi, [years]
    mov rdx, 20
    syscall

