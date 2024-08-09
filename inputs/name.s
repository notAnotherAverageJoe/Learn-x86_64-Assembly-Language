.global _start
.intel_syntax noprefix

.section .data
    prompt1: .asciz "Please enter your name: \n"
    greet: .asciz "Hello "
    newline: .asciz "\n"

.section .bss
    name: .skip 20 * 1

.section .text
    # WIP WIP WIP
_start:
    # Write the prompt out
    mov rax, 1          # syscall number for write
    mov rdi, 1          # file descriptor for stdout
    lea rsi, [prompt1]   # address of the prompt string
    mov rdx, 21         # length of the prompt string (including newline)
    syscall

    # Read the name
    mov rax, 0          # syscall number for read
    mov rdi, 0          # file descriptor for stdin
    lea rsi, [name]     # buffer to store the name
    mov rdx, 20         # maximum number of characters to read
    syscall

    # Print greeting and name
    mov rax, 1          # syscall number for write
    mov rdi, 1          # file descriptor for stdout
    lea rsi, [greet]    # address of the greeting string
    mov rdx, 6          # length of the greeting string
    syscall

    mov rax, 1          # syscall number for write
    mov rdi, 1          # file descriptor for stdout
    lea rsi, [name]     # address of the name
    mov rdx, rax        # number of characters read (stored in rax)
    syscall

    # Print newline
    mov rax, 1          # syscall number for write
    mov rdi, 1          # file descriptor for stdout
    lea rsi, [newline]  # address of the newline character
    mov rdx, 1          # length of the newline character
    syscall

    # Exit
    mov rax, 60          # syscall number for exit
    mov rdi, 0           # exit code
    syscall
