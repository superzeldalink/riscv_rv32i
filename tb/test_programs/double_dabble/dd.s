.data
input:  .word 0x12345678   # Input binary number (32 bits)
LEDR: .word 0x880           # Output LEDR number

.text
.globl main

main:
  lw  t0, input           # Load the input binary number
  li  t1, 0               # Initialize the BCD result to 0
  li  t2, 9               # Set the loop counter to 9

convert_loop:
  slli  t0, t0, 1         # Shift the input left (like a double dabble operation)
  li   t3, 10             # Load 10 into t3 (to compare with input)
  sub  t0, t0, t3         # Compare and subtract 10
  bge  t0, zero, shift   # If t0 >= 10, shift the BCD result
  addi t1, t1, 1          # Increment BCD result
  j    convert_loop

shift:
  slli  t1, t1, 4         # Shift the BCD result left by 4 bits
  addi t2, t2, -1        # Decrement the loop counter
  bnez t2, convert_loop  # Continue the loop if t2 is not zero

  lw t0, LEDR
  sw   t1, 0(t0)         # Store the BCD result in the output variable

halt:
  j    halt
