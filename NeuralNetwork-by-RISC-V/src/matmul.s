
.globl matmul
.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:
    bge x0, a1, error73
    bge x0, a2, error73
    bge x0, a5, error74
    bge x0, a4, error74
    bne a2, a4, error75
    # Error checks
    addi sp, sp, -4
    sw ra, 0(sp)
    addi t1, x0, 4
    mul a2, a2, t1
    li t1, 0
    #addi sp, sp, -32
    #sw a0, 0(sp)
    #sw a1, 4(sp)
    #sw a2, 8(sp)
    #sw a3, 12(sp)
    #sw a4, 16(sp)
    #sw a5, 20(sp)
    #sw a6, 24(sp)
    #lw t1, 28(sp)
    #add a0, a3, x0
    #add a1, a4, x0
    #add a2, a5, x0
    #jal ra, print_int_array

    #lw a0, 0(sp)
    #lw a1, 4(sp)
    #lw a2, 8(sp)
    #lw a3, 12(sp)
    #lw a4, 16(sp)
    #lw a5, 20(sp)
    #lw a6, 24(sp)
    #lw t1, 28(sp)
    #addi sp, sp, 32
    j outer_loop_start
    # Prologue


outer_loop_start:
    li t0, 0
    blt t1, a1, inner_loop_start
    
    j outer_loop_end
inner_loop_start:


    addi sp, sp, -36
    sw a0, 0(sp)
    sw a1, 4(sp)
   sw a2, 8(sp)
   sw a3, 12(sp)
   sw a4, 16(sp)
   sw a5, 28(sp)

   sw a6, 32(sp)
   sw t0, 20(sp)
   sw t1, 24(sp)
   add a1, a3, x0
   addi a3, x0, 1
   add a2, a4, x0
   add a4, a5, x0
   jal ra, dot
   add a1, a0, x0
   
      
  lw a6, 32(sp)
   sw a0,0(a6)
   add a1, x0, a0
   #jal ra, print_int
   #li a1, ' '
   #jal ra, print_str
  lw a0, 0(sp)
  lw a1, 4(sp)
  lw a2, 8(sp)
  lw a3, 12(sp)
  lw a4, 16(sp)
  lw a5,28(sp)
  lw a6, 32(sp)
  lw t0, 20(sp)
  lw t1, 24(sp)
   addi sp, sp, 36

    addi t0, t0, 1
    addi a6, a6, 4
    addi a3, a3, 4
    bge t0, a5, inner_loop_end
    j inner_loop_start
inner_loop_end:
    add a0, a0, a2
    addi t1, t1, 1
    addi t3, x0, -4
    mul t2, t3, a5
    add a3, a3, t2
    j outer_loop_start

outer_loop_end:

    
    lw ra, 0(sp)
    addi sp, sp, 4
    # Epilogue
    
    
    ret
error73:
    addi a1, x0, 73
    j exit2

error74:
    addi a1, x0, 74
    j exit2
error75:
    addi a1, x0, 75
    j exit2
