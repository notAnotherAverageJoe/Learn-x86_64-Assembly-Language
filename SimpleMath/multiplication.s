.global _start
.intel_syntax noprefix


.section .data
    num1: .quad 1111
    num2: .quad 2222
    result: .quad  0

.section .text

_start:
    mov rax, [num1]
    mov rbx, [num2]

    imul rax, rbx

    mov [result], rax

    mov rax, 60
    xor rdi, rdi 
    syscall


# as -o multiplication.o multiplication.s
# ld -o multi multiplication.o
# ./multi
