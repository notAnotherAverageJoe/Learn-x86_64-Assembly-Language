.section .data
newline:
    .byte 10              # ASCII newline character

.section .bss
num:
    .space 1              # Reserve 1 byte for storing the number

.section .text
.global _start

_start:
    movl $0, %ecx         # Initialize counter to 0

loop_start:
    cmpl $5, %ecx         # Compare counter with 5
    jge loop_end          # Exit loop if ecx >= 5

    # Convert ECX to ASCII and store in `num`
    movl %ecx, %eax       # Move counter value to eax
    addb $'0', %al        # Add ASCII '0' to convert to ASCII digit
    movb %al, num         # Store ASCII digit in `num`

    # Write the number to stdout
    movl $1, %eax         # syscall: write
    movl $1, %edi         # file descriptor: stdout
    leaq num(%rip), %rsi  # Load address of `num` into RSI
    movl $1, %edx         # length of output (1 byte)
    syscall               # Invoke write syscall

    # Write newline
    movl $1, %eax         # syscall: write
    movl $1, %edi         # file descriptor: stdout
    leaq newline(%rip), %rsi  # Load address of `newline` into RSI
    movl $1, %edx         # length of output (1 byte)
    syscall               # Invoke write syscall

    # Increment counter
    incl %ecx             # Increment ECX
    jmp loop_start        # Jump back to start of the loop

loop_end:
    # Exit syscall
    movl $60, %eax        # syscall: exit
    xorl %edi, %edi       # Return code 0
    syscall               # Invoke exit syscall
