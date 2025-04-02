.section .data
welcome_msg: .asciz "Great treasure awaits you... if you can survive\n how will you proceed?\n 1. Take the path on the right.\n 2. Take the path on the left.\n "
first_right_msg: .asciz "You take the first right... seems safe, you wander into the dragons lair, unimpeded and safe for now\n."
first_left_msg: .asciz "You take the first left... you hear a strange gutter growl coming from behind you... you should Ru.... You died.\n"

.section .bss
input_buf: .skip 1

.section .text
.global _start
_start:

    mov $1, %rax # write 
    mov $1, %rdi # stdout
    lea welcome_msg(%rip), %rsi # pointer to welcome msg
    mov $136, %rdx
    syscall

    mov $0, %rax
    mov $0, %rdi
    lea input_buf(%rip), %rsi
    mov $1, %rdx # its only 1 bye for the input
    syscall

    # process the input we receive
    movzbl input_buf(%rip), %eax
    cmp $49, %al
    je first_right



first_right:
    mov $1, %rax
    mov $1, %rdi
    lea first_right_msg(%rip), %rsi
    mov $101, %rdx
    syscall
    je _exit_game

first_left:
    mov $1, %rax
    mov $1, %rdi
    lea first_left_msg(%rip), %rsi
    mov $120, %rdi
    syscall
    je _exit_game


_exit_game:
    mov $60, %rax         # syscall: exit
    xor %rdi, %rdi        # exit code 0
    syscall

# AT&T syntax
# as -o main.o main.s
# ld -o main main.o

