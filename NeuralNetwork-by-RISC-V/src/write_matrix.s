.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 93.
# - If you receive an fwrite error or eof,
#   this function terminates the program with error code 94.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 95.
# ==============================================================================
write_matrix:

   addi sp, sp , -20
   sw s0, 0(sp)
   sw s1, 4(sp)
   sw s2, 8(sp)
   sw ra, 12(sp)
   add s0, a1, x0
    # Prologue
   addi sp, sp, -8 
   sw a3, 0(sp)
   sw a2, 4(sp)
   add a1, a0, x0
   addi a2, x0, 1
   jal ra, fopen
   add s1, a0, x0 #file descriptor
   addi t0, x0, -1
   beq t0, a0, error93
   addi a0, x0, 1
   slli a0, a0, 3
   jal ra, malloc
   lw a3, 0(sp)
   lw a2, 4(sp)
   addi sp, sp, 8
   sw a2, 0(a0)
   sw a3, 4(a0)
   mul a3, a3, a2
   addi sp, sp, -8
   sw a3, 0(sp)
   add a2, a0, x0
   add a1, s1, x0
   addi a3, x0, 2
   addi a4, x0, 4
   jal ra, fwrite
   addi a3, x0, 2
   blt a0, a3, error94
   lw a3, 0(sp)
   add a2, s0, x0
   add a1, s1, x0
   addi a4, x0, 4
   jal ra, fwrite
     addi sp, sp, 8
   #addi sp, sp , 20
     add a1, x0,s1
     jal ra, fclose
     bne a0, x0, error95
   lw s0, 0(sp)
   lw s1, 4(sp)
   lw s2, 8(sp)
   lw ra, 12(sp)

   addi sp, sp, 20


    # Epilogue


    ret
error93:
    addi a1,x0,93
    j exit2
error94:
    addi a1, x0, 94
    j exit2
error95:
    addi a1,x0, 95
    j exit2
