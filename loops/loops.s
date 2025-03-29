section .text
    global _start

_start:
    mov ecx, 5         ; Set loop counter to 5

loop_start:
    ; Do something (e.g., print, increment a value, etc.)
    
    loop loop_start    ; Decrements ECX and jumps if ECX != 0

    ; Exit program
    mov eax, 60        ; syscall: exit
    xor edi, edi       ; exit code 0
    syscall

; nasm -f elf64 -o loops.o loops.s
 ; ld -o loop loops.o