.section .data
    room1_msg:    .asciz "You are in a dark room. There is a door to the north.\n"
    room2_msg:    .asciz "You have entered a bright room with a chest in the corner.\n"
    invalid_msg:  .asciz "Invalid choice. Try again.\n"
    action_prompt:.asciz "What do you want to do?\n1. Go North\n2. Open Chest\n"

.section .bss
    input_buf:    .skip 4        # Buffer for storing user input
    current_room: .skip 1        # Store the player's current room

.section .text
.global _start
_start:
    # Initialize player's starting room (room 1)
    mov byte [current_room], 1

main_loop:
    # Check current room and display the appropriate message
    movzx rax, byte [current_room]
    cmp rax, 1
    je room1
    cmp rax, 2
    je room2

    # If no valid room, exit
    jmp game_exit

room1:
    # Print room 1 description
    mov rdi, room1_msg
    call print_string

    # Prompt player for action
    mov rdi, action_prompt
    call print_string

    # Get user input
    call get_input

    # Process input
    movzx rax, byte [input_buf]
    cmp rax, '1'
    je go_north
    cmp rax, '2'
    je invalid_choice

go_north:
    # Move to room 2
    mov byte [current_room], 2
    jmp main_loop

room2:
    # Print room 2 description
    mov rdi, room2_msg
    call print_string

    # Exit the game
    jmp game_exit

invalid_choice:
    # Print invalid choice message
    mov rdi, invalid_msg
    call print_string
    jmp main_loop

game_exit:
    mov rax, 60     # syscall: exit
    xor rdi, rdi    # exit code 0
    syscall

# Helper function to print a string
print_string:
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, rdi        # pointer to the string (rdi holds the string address)
    call string_length  # find the string length
    mov rdx, rax        # rax now has the length
    syscall
    ret

# Helper function to get the length of a string
string_length:
    mov rcx, -1
    xor al, al
    repnz scasb
    not rcx
    dec rcx
    mov rax, rcx
    ret

# Helper function to get user input
get_input:
    mov rax, 0          # syscall: read
    mov rdi, 0          # file descriptor: stdin
    mov rsi, input_buf  # buffer to store input
    mov rdx, 4          # max number of bytes to read
    syscall
    ret
