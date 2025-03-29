.section .bss
    age: .skip 20

.section .data
    prompt: .asciz "Enter your age: "

.section .text

_start:
    mov rax, 1 ;sys call for stout
    mov rdi, 1 ;file descriptor for stdout
    lea rsi,[prompt] ; pointer to prompt string
    mov rdx, 20
    syscall
