.global _start
.intel_syntax noprefix

.section .bss
    num1:   .skip 20           # Reserve space for the first number (input as string)
    num2:   .skip 20           # Reserve space for the second number (input as string)
    result: .skip 20           # Reserve space for the result

.section .data
    prompt1: .asciz "Enter the first number: "
    prompt2: .asciz "Enter the second number:  "
    prompt3: .asciz "Enter operation (+, -, *, /): "
    newline: .asciz "\n"
    msg_result: .asciz "Result: "

.section .text
_start:
    # Print prompt for first number
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [prompt1]        # pointer to the prompt string
    mov rdx, 23               # length of the prompt string
    syscall

    # Read first number
    mov rax, 0                # syscall number for sys_read
    mov rdi, 0                # file descriptor (stdin)
    lea rsi, [num1]           # buffer for the input
    mov rdx, 20               # number of bytes to read
    syscall

    # Print prompt for second number
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [prompt2]        # pointer to the prompt string
    mov rdx, 24               # length of the prompt string
    syscall

    # Read second number
    mov rax, 0                # syscall number for sys_read
    mov rdi, 0                # file descriptor (stdin)
    lea rsi, [num2]           # buffer for the input
    mov rdx, 20               # number of bytes to read
    syscall

    # Print prompt for operation
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [prompt3]        # pointer to the prompt string
    mov rdx, 30               # length of the prompt string
    syscall

    # Read operation
    mov rax, 0                # syscall number for sys_read
    mov rdi, 0                # file descriptor (stdin)
    lea rsi, [result]         # buffer for the input
    mov rdx, 1                # number of bytes to read
    syscall

    # Convert num1 and num2 from string to integer
    call str_to_int
    mov rbx, rax              # store the first number in rbx
    mov rax, 0
    call str_to_int
    mov rcx, rax              # store the second number in rcx

    # Perform the operation
    mov al, [result]          # load operation
    cmp al, '+'                # check if addition
    je add_numbers
    cmp al, '-'                # check if subtraction
    je sub_numbers
    cmp al, '*'                # check if multiplication
    je mul_numbers
    cmp al, '/'                # check if division
    je div_numbers
    jmp exit_program           # invalid operation

add_numbers:
    add rbx, rcx
    jmp print_result

sub_numbers:
    sub rbx, rcx
    jmp print_result

mul_numbers:
    imul rbx, rcx
    jmp print_result

div_numbers:
    xor rdx, rdx              # clear rdx for division
    div rcx                   # divide rbx by rcx
    mov rbx, rax              # store the result in rbx
    jmp print_result

print_result:
    # Print result message
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [msg_result]     # pointer to the result message
    mov rdx, 8                # length of the result message
    syscall

    # Print result value
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [result]         # buffer for the result
    mov rdx, 20               # length of the result buffer
    syscall

    # Print newline
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [newline]        # pointer to the newline character
    mov rdx, 1                # length of the newline character
    syscall

exit_program:
    mov rax, 60               # syscall number for sys_exit
    xor rdi, rdi              # exit code 0
    syscall

str_to_int:
    xor rax, rax              # clear rax (result)
    xor rcx, rcx              # clear rcx (temporary digit)
.next_digit:
    movzx rcx, byte ptr [rsi] # load next byte, zero-extend to 64 bits
    sub rcx, '0'              # convert ASCII to integer
    cmp rcx, 9
    jae .done                 # if not a digit, we're done
    imul rax, rax, 10         # shift result left
    add rax, rcx              # add digit to result
    inc rsi                   # move to next character
    jmp .next_digit
.done:
    ret
