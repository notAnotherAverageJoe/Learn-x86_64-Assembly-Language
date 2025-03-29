section .bss
    buffer resb 2

section .text
    global _start

_start:
    mov ecx, 5         ; Set loop counter

loop_start:
    ; Do something

    dec ecx            ; Decrease counter
    cmp ecx, 0         ; Compare with zero
    jne loop_start     ; Jump if not zero

    ; Exit program
    mov eax, 60        ; syscall: exit
    xor edi, edi
    syscall
