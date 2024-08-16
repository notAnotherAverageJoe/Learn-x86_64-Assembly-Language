.global _start
.intel_syntax noprefix

.section .data
    room1_msg:    .asciz "You are in a dark room. There is a door to the north.\n"
    room2_msg:    .asciz "You have entered a bright room with a chest in the corner.\n"
    invalid_msg:  .asciz "Invalid choice. Try again.\n"
    action_prompt:.asciz "What do you want to do?\n1. Go North\n2. Open Chest\n"
    prompt_len:   .quad 37

.section .bss
    input_buf:    .skip 4        # Buffer for storing user input
    current_room: .skip 1        # Store the player's current room

.section .text
.global _start

_start:
    # Initialize player's starting room (room 1)
    mov byte ptr [current_room], 1
    
main_loop:
    # Check current room and display the appropriate message
    movzx rax, byte ptr [current_room]
    cmp rax, 1
    je room1
    cmp rax, 2
    je room2

    # If no valid room, exit
    jmp game_exit

room1:
    # Print room1 message
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, room1_msg  # address of room1_msg
    mov rdx, 44         # number of bytes
    syscall
    jmp prompt_action

room2:
    # Print room2 message
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, room2_msg  # address of room2_msg
    mov rdx, 55         # number of bytes
    syscall
    jmp prompt_action

prompt_action:
    # Print action prompt
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, action_prompt  # address of action_prompt
    mov rdx, [prompt_len]   # number of bytes
    syscall

    # Read user input
    mov rax, 0          # syscall: read
    mov rdi, 0          # file descriptor: stdin
    mov rsi, input_buf  # address of input_buf
    mov rdx, 4          # number of bytes
    syscall

    # Process user input
    movzx rax, byte ptr [input_buf]
    cmp rax, '1'
    je go_north
    cmp rax, '2'
    je open_chest

    # Invalid choice
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, invalid_msg  # address of invalid_msg
    mov rdx, 26         # number of bytes
    syscall
    jmp main_loop

go_north:
    # Move to room 2
    mov byte ptr [current_room], 2
    jmp main_loop

open_chest:
    # Handle opening chest (currently does nothing)
    jmp main_loop

game_exit:
    # Exit the program
    mov rax, 60         # syscall: exit
    xor rdi, rdi        # exit code 0
    syscall
