.global _start
.intel_syntax noprefix

.section .data
    num1:   .quad 1000
    num2:   .quad 4000
    result: .quad 0

.section .text
_start:
    # Load the first number into the RAX register
    mov rax, [num1]
    # Add the second number to the value in RAX
    add rax, [num2]

    # Store the result in the 'result' variable
    mov [result], rax

    # Now we exit the program 
    mov rax, 60     # syscall:exit
    xor rdi, rdi    # exit code 0
    syscall


# as -o adding.o adding.s
# ld -o add adding.o
# ./add
