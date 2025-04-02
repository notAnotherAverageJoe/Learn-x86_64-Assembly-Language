.section .data
welcome_msg: .asciz "Great treasure awaits you... if you can survive\n how will you proceed?\n 1. Take the path on the left.\n 2. Take the path on the right.\n "


.section .bss
input_buf .skip 1

.section .text
.global _start
_start:

    mov $1, %rax # write 
    mov $1, %rdi # stdout
    lea welcome_msg(%rip), %rsi
