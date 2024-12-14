section .data
    welcome_msg db "Welcome to the Space Game! Choose an option:", 10, \
                 "1. Go to space", 10, "2. Wait", 10, "3. Reload", 10, 0
    go_space_msg db "You have chosen to go to space! Blast off!", 10, 0
    wait_msg db "You have chosen to wait. Time is passing...", 10, 0
    reload_msg db "You choose to stay in town and reload your munitions...", 10, 0
    merchant_msg db "You sell the few scraps you had collected around space", 10, 0
    invalid_choice db "Invalid choice. Please select 1, 2, or 3.", 10, 0

section .bss
    input_buf resb 1 ; Reserve 1 byte for user input

section .text
    global _start

_start:
    ; Print welcome message
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    lea rsi, [rel welcome_msg] ; pointer to message
    mov rdx, 78           ; message length
    syscall

    ; Get user input (1 byte for choice)
    mov rax, 0            ; syscall: read
    mov rdi, 0            ; file descriptor: stdin
    lea rsi, [rel input_buf] ; buffer to store input
    mov rdx, 1            ; read 1 byte
    syscall

    ; Process input
    movzx eax, byte [input_buf] ; Load user input into rax (zero-extend)
    cmp al, '1'           ; Compare input with '1'
    je go_to_space        ; If '1', go to space

    cmp al, '2'           ; Compare input with '2'
    je wait_for_time      ; If '2', wait

    cmp al, '3'           ; Compare input with '3'
    je reloading          ; If '3', reload

    ; Invalid input
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    lea rsi, [rel invalid_choice] ; pointer to message
    mov rdx, 37           ; message length
    syscall
    jmp _start            ; Restart the game

go_to_space:
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    lea rsi, [rel go_space_msg] ; pointer to message
    mov rdx, 40           ; message length
    syscall
    jmp _exit_game

wait_for_time:
    mov rax, 1            ; syscall: write
    mov rdi, 1            
    lea rsi, [rel wait_msg] ; pointer to message
    mov rdx, 41           
    syscall
    jmp _exit_game

reloading:
    mov rax, 1            
    mov rdi, 1            
    lea rsi, [rel reload_msg] 
    mov rdx, 55           
    syscall
    jmp merchant

merchant:
    mov rax, 1            
    mov rdi, 1            
    lea rsi, [rel merchant_msg] 
    mov rdx, 80           
    syscall
    jmp _exit_game

_exit_game:
    mov rax, 60           ; syscall: exit
    xor rdi, rdi          ; exit code 0
    syscall


; this is the Intel Syntax version of the game

; nasm -f elf64 IntelSpace.asm -o IntelSpace.o
; ld IntelSpace.o -o IntelSpace

