.section .data
welcome_msg:     .asciz "Welcome to the Space Game! Choose an option:\n1. Go to space\n2. Wait\n3. Sell Wares\n"
go_space_msg:    .asciz "You have chosen to go to space! Blast off!\n"
wait_msg:        .asciz "You have chosen to wait. Time is passing...\n"
sales_msg:       .asciz "You choose to stay in town and sell your wares...\n"
merchant_msg:    .asciz "You sell the few scraps you had collected around space.\n"
invalid_choice:  .asciz "Invalid choice. Please select 1, 2, or 3.\n"
money_msg:       .asciz "Money: $100\n"
ship_status_msg: .asciz "Ship Status: Operational\n"

.extern money    # Declare 'money' as external

.section .bss
input_buf:       .skip 1        # Buffer to store user input (1 byte)

.section .text
.global _start

_start:

    # Print welcome message
    mov $1, %rax          # syscall: write
    mov $1, %rdi          # file descriptor: stdout
    lea welcome_msg(%rip), %rsi # pointer to message
    mov $82, %rdx         # message length
    syscall
        # Print money
    mov $1, %rax           # syscall: write
    mov $1, %rdi           # stdout
    lea money_msg(%rip), %rsi  # Message pointer
    mov $15, %rdx          # Length of the message
    syscall

    # Print ship status
    mov $1, %rax           # syscall: write
    mov $1, %rdi           # stdout
    lea ship_status_msg(%rip), %rsi  # Message pointer
    mov $20, %rdx          # Length of the message
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

    cmp $51, %al          # Compare input with '3' (ASCII 51)
    je sales              # If '3', sell wares

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
    mov $43, %rdx         
    syscall
    jmp _exit_game        # Exit the game

wait_for_time:
    mov $1, %rax      
    mov $1, %rdi          
    lea wait_msg(%rip), %rsi 
    mov $43, %rdx         
    syscall
    jmp _exit_game        # Exit the game

sales:
    # Add 50 to money
    mov money(%rip), %eax     # Load current money
    add $50, %eax             # Add 50 to it
    mov %eax, money(%rip)     # Store updated money

    # Print sales message
    mov $1, %rax         
    mov $1, %rdi          
    lea sales_msg(%rip), %rsi  
    mov $50, %rdx         
    syscall
    jmp _exit_game

    


_exit_game:
    mov $60, %rax         # syscall: exit
    xor %rdi, %rdi        # exit code 0
    syscall


# AT&T syntax
# as -o Space.o Space.s
# ld -o Space Space.o

# new compile with globals
# as -o Space.o Space.s
# as -o globals.o globals.s
# ld -o Space Space.o globals.o
