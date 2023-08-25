.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
   bge x0, a0, error75

   bge x0, a1, error75
    # Prologue

   bge x0, a3, error75

   bge x0, a4, error75
   addi sp, sp, -8
   sw s1, 0(sp)
   sw s2, 4(sp)
   add s1, x0, x0
   add s2, x0, x0
   addi t1, x0,4
   mul a3, a3, t1
   mul a4, a4, t1
   j loop_start
   
loop_start:

   bge s1, a2, loop_end
   lw t0, 0(a0)
   lw t1, 0(a1)
   mul t2, t0, t1
   add s2, s2, t2
   addi s1, s1, 1
   add a0, a3, a0
   add a1, a4, a1
   j loop_start
loop_end:
   add a0, x0, s2

   lw s1, 0(sp)
   lw s2, 4(sp)
   addi sp, sp, 8
    # Epilogue

    
    ret
error75:
   addi a0, x0, 75
    j exit
error76:
    addi a0, x0, 76
    j exit
