# int sum = 0;
# for(int i = 0; i < 100; i++)
#   for(int j = 0; j < 3 ; j++)
#     sum += (i-j);

# Assuming the assembly is written for the RISC-V architecture (RV32I)

# Initializing loop bounds
li x10, 0      # x10 will hold the sum (initialize sum to 0)
li x11, 0      # x11 will be the outer loop counter (initialize i to 0)
li x13, 100    # x13 will hold the outer loop bound (initialize to 100)
li x14, 3      # x14 will hold the inner loop bound (initialize to 3)

# Beginning of the outer loop
outer_loop_start:
  bge x11, x13, outer_loop_exit   # Exit the outer loop if i >= 100
  
  li x12, 0      # x12 will be the inner loop counter (initialize j to 0)
  
  # Beginning of the inner loop
  inner_loop_start:
    bge x12, x14, inner_loop_exit   # Exit the inner loop if j >= 3
    
    sub x15, x11, x12  # Calculate (i - j)
    add x10, x10, x15  # sum += (i - j)
    addi x12, x12, 1   # Increment j by 1
    j inner_loop_start  # Jump back to the beginning of the inner loop
  
  # End of the inner loop
  inner_loop_exit:
  
  addi x11, x11, 1   # Increment i by 1
  j outer_loop_start  # Jump back to the beginning of the outer loop

# Exit point
outer_loop_exit:
  # At this point, the sum is stored in register x10
  li t0, 0x880
  sw x10, 0(t0)

