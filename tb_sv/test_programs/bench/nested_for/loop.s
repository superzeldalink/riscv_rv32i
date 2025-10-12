.text

_start:
    li x5, 0  # Initialize sum to 0

    # Outermost loop: i loop
    li x1, 0       # i = 0
i_loop:
    li x10, 5      # Load constant 5 for comparison
    blt x1, x10, continue_i_loop  # Branch if i < 5

    j end_i_loop   # Exit i loop if i >= 5

continue_i_loop:
    # Second loop: j loop
    li x2, 0       # j = 0
j_loop:
    li x11, 4      # Load constant 4 for comparison
    blt x2, x11, continue_j_loop  # Branch if j < 4

    j end_j_loop   # Exit j loop if j >= 4

continue_j_loop:
    # Third loop: k loop
    li x3, 0       # k = 0
k_loop:
    li x12, 3      # Load constant 3 for comparison
    blt x3, x12, continue_k_loop  # Branch if k < 3

    j end_k_loop   # Exit k loop if k >= 3

continue_k_loop:
    # Fourth loop: l loop
    li x4, 0       # l = 0
l_loop:
    li x13, 2      # Load constant 2 for comparison
    blt x4, x13, continue_l_loop  # Branch if l < 2

    j end_l_loop   # Exit l loop if l >= 2

continue_l_loop:
    # Calculate sum = sum + (i + j + k + l)
    add x6, x1, x2  # i + j
    add x6, x6, x3  # i + j + k
    add x6, x6, x4  # i + j + k + l
    add x5, x5, x6  # sum += (i + j + k + l)

    addi x4, x4, 1  # Increment l
    j l_loop        # Jump back to l loop

end_l_loop:
    addi x3, x3, 1  # Increment k
    j k_loop        # Jump back to k loop

end_k_loop:
    addi x2, x2, 1  # Increment j
    j j_loop        # Jump back to j loop

end_j_loop:
    addi x1, x1, 1  # Increment i
    j i_loop        # Jump back to i loop

end_i_loop:
  # At this point, the sum is stored in register x5
  li t1, 0x880
  sw x5, 0(t1)
