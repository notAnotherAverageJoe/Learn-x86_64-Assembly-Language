.global _start
.intel_syntax noprefix

_start:

    # sys_write
    mov rax, 1                # syscall number for sys_write
    mov rdi, 1                # file descriptor (stdout)
    lea rsi, [rip + hello_world]  # pointer to the string
    mov rdx, 14               # length of the string
    syscall                   # invoke syscall

    # sys_exit
    mov rax, 60               # syscall number for sys_exit
    mov rdi, 69               # exit code 69
    syscall                   # invoke syscall

hello_world:
    .asciz "Hello, World!\n"
