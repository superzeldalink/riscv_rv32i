# int sum = 0;
# for(int i = 0; i < 1000; i++)
#   if(i % 2)
#     sum += i;

# Assuming the assembly is written for the RISC-V architecture (RV32I)

# Initializing registers
li x10, 0      # x10 will hold the sum (initialize sum to 0)
li x11, 0      # x11 will be the loop counter (initialize i to 0)
li x12, 1000   # x12 will hold the loop bound (initialize to 1000)

# Beginning of the loop
loop_start:
  bge x11, x12, loop_exit   # Exit the loop if i >= 1000
  
  andi x13, x11, 1    # Calculate i % 2
  beqz x13, even  # Branch if i % 2 != 0 (even)
  add x10, x10, x11  # sum += i
  
even:
  addi x11, x11, 1   # Increment i by 1
  j loop_start        # Jump back to the beginning of the loop

# Exit point
loop_exit:
  # At this point, the sum is stored in register x10
  li t0, 0x880
  sw x10, 0(t0)

