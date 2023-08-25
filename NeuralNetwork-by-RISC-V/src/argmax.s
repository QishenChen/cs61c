.globl argmax

# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================

.text
argmax:
    bge x0, a1, err
    addi a1, a1, -1
    lw t1, 0(a0)
    add t3, x0, t1 # value of max element
    add t2, x0, x0 # index of max element
    
    add  t0, x0, x0
    j loop_start
loop_start:
    bge t0,a1, loop_end
    addi a0, a0, 4
    addi t0, t0, 1
    lw t1, 0(a0)
    bge t3, t1, loop_continue
    add t3, x0, t1
    add t2, t0, x0
loop_continue:
    j loop_start
loop_end:
    add  a0, t2, x0
    ret
err:
   addi a0, x0, 77
   
   


