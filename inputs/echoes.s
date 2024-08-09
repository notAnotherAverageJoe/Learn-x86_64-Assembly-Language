section .bss
    buffer resb 128  ; reserves a buffer for the input!

section .text
    global _start

_start: 
    ; read inputs from stdin
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer 
    mov rdx, 128
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 128
    syscall


    ; Exit the program
    mov rax, 60         ; syscall number for sys_exit
    xor rdi, rdi        ; exit code 0
    syscall             ; make the system call




; --------------
; nasm -f elf64 -o echoes.o echoes.s
 ; ld -o echoes echoes.o
 ; ./echoes to run
 ; from there it will repeat the input!