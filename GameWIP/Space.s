.section .data
welcome_msg:     .asciz "Welcome to the Space Game! Choose an option:\n1. Go to space\n2. Wait\n3. Reload\n"
go_space_msg:    .asciz "You have chosen to go to space! Blast off!\n"
wait_msg:        .asciz "You have chosen to wait. Time is passing...\n"
reload_msg:      .asciz "You choose to stay in town and reload your munitions...\n"
merchant_msg:    .asciz "As you wait for your ships reload to complete, you begin seeing a few merchants heading your way\n"
invalid_choice:  .asciz "Invalid choice. Please select 1, 2, or 3.\n"

.section .bss
input_buf:       .skip 1        # Buffer to store user input (1 byte)

.section .text
.global _start

_start:
    # Print welcome message
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea welcome_msg(%rip), %rsi # poinnter to message
    mov $78, %rdx         # message length
    syscall

    # Get user input (1 byte for choice)
    mov $0, %rax          # syscall: read
    mov $0, %rdi          # file descriptor: stdin
    lea input_buf(%rip), %rsi # bbuffer to store input
    mov $1, %rdx          # read 1 byte (one character)
    syscall

    # Process input
    movzbl input_buf(%rip), %eax # Load user input into rax
    cmp $49, %al          # Compare input with '1' (ASCII 49)
    je go_to_space        # If '1, go to space

    cmp $50, %al          # Compare input with '2' (ASCII 50)
    je wait_for_time      # If '2', wait

    cmp $51, %al          # Compare input with '3' (ASCII 51)
    je reloading          # If '3', reload

    # Invalid input
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea invalid_choice(%rip), %rsi # pointer to message
    mov $37, %rdx         # message length
    syscall
    jmp _start            # Restart the game

go_to_space:
    mov $1, %rax          
    mov $1, %rdi          
    lea go_space_msg(%rip), %rsi 
    mov $40, %rdx         
    syscall
    jmp _exit_game

wait_for_time:
    mov $1, %rax      
    mov $1, %rdi          
    lea wait_msg(%rip), %rsi 
    mov $41, %rdx    
    syscall
    jmp _exit_game

reloading:
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea reload_msg(%rip), %rsi  # pointer to reload message
    mov $55, %rdx         # reload message length
    syscall
    jmp merchant

merchant:
    mov $1, %rax
    mov $1, %rdi
    lea merchant_msg(%rip), %rsi
    mov $80, %rdx
    syscall
    jmp _exit_game

_exit_game:
    mov $60, %rax         # syscall: exit
    xor %rdi, %rdi        # exit code 0
    syscall

# AT&T syntax
# as -o Space.o Space.s
# ld -o Space Space.o
