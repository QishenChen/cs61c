.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
   
    bge x0, a1, error
    addi sp, sp, -4
    sw ra, 0(sp)
    addi t0, x0, 0
    jal ra, loop_start
loop_start:
  
    
    j loop_continue





loop_continue:
    addi sp, sp, -4
    sw a0, 0(sp)
    lw a0, 0(a0)
   jal ra, func
   lw t1, 0(sp)
   sw a0, 0(t1)
   addi sp, sp, -8
   sw a1, 0(sp)
   sw t0, 4(sp)
   add a1, x0, a0
   #jal ra, print_int

   lw a1, 0(sp)
   lw t0, 4(sp)
   addi sp, sp, 8
   lw a0, 0(sp)
   addi a0, a0, 4

   addi t0,t0, 1
   addi sp, sp, 4
   bge t0, a1, loop_end
   
   j loop_start


loop_end:
    

    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4
    
	ret
func:
    bge x0, a0, change
    jr ra
change:
    add a0, x0, x0
    jr ra
error:
    addi a1, x0, 78
    j exit
