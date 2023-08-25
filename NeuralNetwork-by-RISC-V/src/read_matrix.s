.globl read_matrix
.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

    # Prologue

   

   addi sp, sp, -40
   sw a0, 0(sp)
   sw a1, 4(sp)
   sw a2, 8(sp)
   sw s0, 16(sp)
   sw s1, 20(sp)
   sw s2, 24(sp)
   sw s3, 28(sp)
   sw s4, 32(sp)
   sw s5, 36(sp)
   add s4, a1, x0
   add s5, a2, x0
   add s2, x0, ra
   add a1, a0, x0
   add a2, x0, x0
   jal ra, fopen #file descriptor
   add s1, a0, x0
   addi t3, x0, -1
   beq a0, t3, error90

   add a2, s4, x0
   add a1, s1, x0
   addi a3, x0, 4
   jal ra, fread
   addi t3, x0, -1
   beq a0, t3, error91

   add a1, s1, x0
   add a2, s5, x0
   addi a3, x0, 4
   jal ra, fread
   addi t3, x0, -1
   beq a0, t3, error91

   lw a1, 0(s4)
   lw a2, 0(s5)
   mul t0, a1, a2
   add t1, t0, x0
   slli t0, t0, 2
   add a0,x0, t0
   jal ra,malloc 
   add s0, a0, x0 # pointer to the buffer
   beq a0, x0, error88
   add s3, a0, x0 
   add t0, x0, x0 #the words that have been read
   lw a1, 0(s4)
   lw a2, 0(s5)
   mul t1, a1, a2
   add a0, t1, x0
   #jal ra, print_int
   j read
   
read:
   addi sp, sp, -8
   sw t1, 0(sp)
   sw t0, 4(sp)
   add a1, s1, x0
   add a2, s0, x0
   addi a3, x0, 4
   jal ra, fread
   
   lw t1, 0(sp)
   lw t0, 4(sp)
   addi sp, sp, 8
   addi t3, x0, 4
   bne a0, t3, error91
   addi t0, t0, 1
   addi s0, s0, 4
   bge t0, t1,end_read
   j read


end_read:

    
   add a1, s1, x0
   sw t1, 0(sp)
   sw t0, 4(sp)
   jal ra, fclose
   lw t1, 0(sp)
   lw t0, 4(sp)
   addi t3, x0, -1
   beq a0, t3, error92
   add a2, s5, x0
   lw a1, 0(s4)
   #jal ra, print_int
   add a1, s4, x0
   slli t3, t3, 2
   mul t1, t1, t3
   add a0, x0, s3
 
   lw s0, 16(sp)
   lw s1, 20(sp)
   lw s3, 28(sp)
   lw s4, 32(sp)
   lw s5, 36(sp)
   add ra, x0, s2
   lw s2, 24(sp)
    # Epilogue
   addi sp, sp, 40
    ret
error88:
    addi a1, x0, 88
    j exit2
error90:

    addi a1, x0, 90
    j exit2
error92:
    addi a1, x0, 92
    j exit2
error91:
    addi a1, x0, 91
    j exit2

