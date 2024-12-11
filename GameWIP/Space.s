.section .data
welcome_msg:     .asciz "Welcome to the Space Game! Choose an option:\n1. Go to space\n2. Wait\n"
go_space_msg:    .asciz "You have chosen to go to space! Blast off!\n"
wait_msg:        .asciz "You have chosen to wait. Time is passing...\n"
invalid_choice:  .asciz "Invalid choice. Please select 1 or 2.\n"

.section .bss
input_buf:       .skip 1        # Buffer to store user input (1 byte)

.section .text
.global _start

_start:
    # Print welcome message
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea welcome_msg(%rip), %rsi # pointer to message
    mov $77, %rdx         # message length
    syscall

    # Get user input (1 byte for choice)
    mov $0, %rax          # syscall: read
    mov $0, %rdi          # file descriptor: stdin
    lea input_buf(%rip), %rsi # buffer to store input
    mov $1, %rdx          # read 1 byte (one character)
    syscall

    # Process input
    movzbl input_buf(%rip), %eax # Load user input into rax
    cmp $49, %al          # Compare input with '1' (ASCII 49)
    je go_to_space        # If '1', go to space

    cmp $50, %al          # Compare input with '2' (ASCII 50)
    je wait_for_time      # If '2', wait

    # Invalid input
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea invalid_choice(%rip), %rsi # pointer to message
    mov $34, %rdx         # message length
    syscall
    jmp _start            # Restart the game

go_to_space:
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea go_space_msg(%rip), %rsi # pointer to message
    mov $43, %rdx         # message length
    syscall
    jmp _exit_game

wait_for_time:
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea wait_msg(%rip), %rsi # pointer to message
    mov $43, %rdx         # message length
    syscall
    jmp _exit_game

_exit_game:
    mov $60, %rax         # syscall: exit
    xor %rdi, %rdi        # exit code 0
    syscall


# as -o Space.o Space.s
# ld -o Space Space.o
