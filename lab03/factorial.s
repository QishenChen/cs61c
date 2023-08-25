.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    addi a0, a0, 3
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    addi t0, x0, 1
     beq t0, a0, finish
     addi sp, sp, -8
     sw ra, 0(sp)
     sw a0, 4(sp)
     addi a0, a0, -1
     jal ra, factorial
     add t0, a0, x0
     lw a0, 4(sp)
     mul a0, a0, t0
     lw ra, 0(sp)
     addi sp, sp, 8
     jr ra
     
finish:
     ret
