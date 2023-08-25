.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>






	# =====================================
    # LOAD MATRICES
    # =====================================
   addi sp, sp, -28 #prelogue
   sw ra, 0(sp)
   sw s0, 4(sp)
   sw s1, 8(sp)
   sw s2, 12(sp)
   sw s3, 16(sp)
   sw s4, 20(sp)
   addi t0, x0, 4
   beq t0, a0, error89
   lw s0, 4(a1)
   lw s1, 8(a1)
   lw s2, 12(a1)
   lw s4, 16(a1)
   addi a0, x0, 24
   jal ra, malloc
   bge x0, a0, error90
   add s3, x0, a0
    # Load pretrained m0


   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   addi sp, sp, -8
   sw a0, 0(sp)
   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   sw a0, 4(sp)
   lw a1, 0(sp)
   lw a2, 4(sp)
   add a0, s0, x0
   jal ra, read_matrix
   add s0, a0, x0
   lw t0, 0(sp)
   lw t0, 0(t0)
   add a1, t0, x0
   
   lw t0, 4(sp)
   lw t0, 0(t0)
   add a2, t0, x0
   #jal ra, print_int_array
   lw t0, 0(sp)
   lw t0, 0(sp)
   lw t0, 0(t0)
   sw t0, 0(s3)
   add a1, x0, t0
   #jal ra, print_int
   li a1, '\n'
   #jal ra, print_str
   lw t0, 4(sp)
   lw t0, 0(t0)
   sw t0, 4(s3)
   add a1, x0, t0
   #jal ra, print_int
   li a1, '\n'
   #jal ra, print_str

    # Load pretrained m1

   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   addi sp, sp, -8
   sw a0, 0(sp)
   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   sw a0, 4(sp)
   lw a1, 0(sp)
   lw a2, 4(sp)
   add a0, s1, x0
jal ra, read_matrix
   lw t0, 0(sp)
   lw t0, 0(t0)
   add s1, a0, x0
   sw t0, 8(s3)
   add a1, x0, t0
   #   jal ra, print_int
   li a1, '\n'
   # jal ra, print_str
   lw t0, 4(sp)
   lw t0, 0(t0)
   sw t0, 12(s3)
   add a1, x0, t0
   #jal ra, print_int
   li a1, '\n'
   #jal ra, print_str


   # Load input matrix

   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   addi sp, sp, -8
   sw a0, 0(sp)
   addi t0, x0, 4
   add a0, x0, t0
   jal ra, malloc
   addi t0, x0, 4
   beq, a0, t0, error90 
   sw a0, 4(sp)
   lw a1, 0(sp)
   lw a2, 4(sp)
   add a0, s2, x0
   jal ra, read_matrix
   
   lw t0, 0(sp)
   lw t0, 0(t0)
   add a1, t0, x0
   
   lw t0, 4(sp)
   lw t0, 0(t0)
   add a2, t0, x0
   #jal ra, print_int_array
   lw t0, 0(sp)
   lw t0, 0(t0)
   add s2, a0, x0
   sw t0, 16(s3)
   add a1, x0, t0
   #jal ra, print_int
   li a1, '\n'
   #jal ra, print_str
   lw t0, 4(sp)
   lw t0, 0(t0)
   sw t0, 20(s3)
   add a1, x0, t0
   #jal ra, print_int

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
   
   lw a1, 0(s3)
   lw a2, 4(s3)
   add a0, s0, x0
   #jal ra, print_int_array
   lw a1, 16(s3)
   lw a2, 20(s3)
   add a0, s2, x0
   #jal ra, print_int_array
   lw a4, 16(s3)
   lw a5, 20(s3)
   lw a1, 0(s3)
   mul a0,a1, a5
   slli a0, a0, 2
   add a1, x0, a0
   #jal ra, print_int

   lw a1, 0(s3)
   lw a5, 20(s3)
   mul a0,a1, a5
   slli a0, a0, 2
   jal ra, malloc
   bge x0,a0, error90
   lw a1, 0(s3)
   lw a2, 4(s3)
   lw a4, 16(s3)
   lw a5, 20(s3)
   add a6, a0, x0
   add a0, s0, x0
   add a3, s2, x0
   addi sp, sp, -4
   sw a6, 0(sp)
   jal ra, matmul
   lw a6, 0(sp)
   addi sp, sp, 4
   
   #   jal ra, print_int_array

   lw a1, 0(s3)
   lw a2, 20(s3)
   mul a1, a1, a2
   #jal ra, print_int
   add a0, x0, a6
   addi sp, sp, -4
   sw a0, 0(sp)
   jal ra, relu
   lw a0, 0(sp)
   lw a1, 0(s3)
   lw a2, 20(s3)
   #jal ra, print_int_array
   
   lw a1, 8(s3)
   lw a4, 0(s3)
   lw a5, 20(s3)
   mul a0, a1, a5
   slli a0, a0, 2
   jal ra, malloc
   add a6, a0, x0
   lw a1, 8(s3)
   lw a4, 0(s3)
   lw a5, 20(s3)
   add a0, x0, s1
   lw a2, 12(s3)
   lw a3, 0(sp)
   addi sp, sp, 4
   addi sp, sp, -4
   sw a6, 0(sp)
   jal ra, matmul
   lw a0, 0(sp)

   lw a1, 8(s3)
   lw a2, 20(s3)
   
   #jal ra, print_int_array


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
   lw a0, 0(sp)
   addi sp, sp, 4
   add a1, x0, a0
   addi sp, sp, -4
   sw a0, 0(sp)
   add  a0, s4,x0
   lw a2, 8(s3)
   lw a3, 20(s3)
   jal ra, write_matrix


    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
   lw a0, 0(sp)
   addi sp, sp, 4
   
   lw a2, 8(s3)
   lw a3, 20(s3)
   mul a1, a2, a3
   jal ra, argmax


    # Print classification
   li a1, '\n'
   add a1, x0, a0
   jal ra, print_int


    # Print newline afterwards for clarity
   li a1, '\n'
   jal ra, print_char



   lw ra, 0(sp)
   addi sp, sp, 28
    ret
error89:
    addi a0, x0, 89
    j exit2
error90:

    addi a0, x0, 90
    j exit2
