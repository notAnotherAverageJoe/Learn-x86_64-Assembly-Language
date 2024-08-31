section .data
    hello_message db 'Hello, World!', 0xA  ; The message to print, with a newline character (0xA)
    hello_length equ $ - hello_message     ; Calculate the length of the message

section .text
    global _start

_start:
    ; Write the message to stdout
    mov rax, 1          ; syscall number for sys_write (1)
    mov rdi, 1          ; file descriptor (1 for stdout)
    mov rsi, hello_message ; pointer to the message
    mov rdx, hello_length ; length of the message
    syscall             ; invoke the syscall

    ; Exit the program
    mov rax, 60         ; syscall number for sys_exit (60)
    xor rdi, rdi        ; exit code 0
    syscall             ; invoke the syscall
