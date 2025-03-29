section .bss
    buffer resb 128 ; Reserve 128 bytes for input

section .data
    message db "Welcome to Assembly ", 0 ; Message to prepend
    intro db "Enter your name: ", 10, 0 ; intro message
    intro_length equ $ - intro

section .text
    global _start ; Entry point for the program

_start:
    ; Copy the message to the buffer
    mov rsi, message
    mov rdi, buffer
    call copy_message

    mov rax, 1
    mov rdi, 1
    mov rsi, intro
    mov rdx, intro_length
    syscall

    ; Read input from stdin
    mov rax, 0 ; syscall number for sys_read (0)
    mov rdi, 0 ; file descriptor (0 for stdin)
    mov rsi, buffer + 20 ; pointer to the buffer after the message
    mov rdx, 108 ; number of bytes to read (128 - length of message)
    syscall ; invoke the syscall

    ; Store the number of bytes read
    mov rcx, rax

    ; Output the message and input to stdout
    mov rax, 1 ; syscall number for sys_write (1)
    mov rdi, 1 ; file descriptor (1 for stdout)
    mov rsi, buffer ; pointer to the buffer
    add rdx, 20 ; length of the message + number of bytes read
    syscall ; invoke the syscall

    ; Exit the program
    mov rax, 60 ; syscall number for sys_exit (60)
    xor rdi, rdi ; exit code 0
    syscall ; invoke the syscall

copy_message:
    ; Copy the message to the buffer
    mov rcx, 20 ; length of the message
.copy_loop:
    lodsb ; load byte from message
    stosb ; store byte in buffer
    loop .copy_loop
    ret



; nasm -f elf64 name.s
; ld -o name name.o