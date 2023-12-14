# Assume an array of integers is stored in memory starting at address array_addr
# The number of elements in the array is stored at address num_elements

.data
array_addr: .word 5, 2, 9, 1, 5  # Example array data
num_elements: .word 5            

.text
.globl _start

_start:
    # Load the address of the array and the number of elements into registers
    la x10, array_addr  # Load address of the array into register x10
    lw x11, num_elements # Load the number of elements into register x11
    addi x11, x11, -1

    # Loop through the array for bubble sort
outer_loop:
    li x12, 1            # Set flag to 1 to indicate no swaps yet
    li x13, 0            # Initialize outer loop counter

inner_loop:
    bge x13, x11, end_outer # Exit inner loop if outer loop counter >= number of elements

    # Calculate array indices: (x10 = array base address)
    slli x14, x13, 2      # Multiply loop counter by 4 (each integer is 4 bytes)
    add x15, x10, x14     # Calculate address of array element i
    lw x16, 0(x15)        # Load array[i]
    lw x17, 4(x15)        # Load array[i+1]

    # Compare and swap if necessary
    ble x16, x17, no_swap
    sw x17, 0(x15)        # Swap: store array[i+1] at array[i]
    sw x16, 4(x15)        # Swap: store array[i] at array[i+1]
    li x12, 0             # Set flag to 0 to indicate a swap occurred

no_swap:
    addi x13, x13, 1      # Increment inner loop counter
    j inner_loop           # Jump back to inner loop

end_outer:
    beqz x12, outer_loop  # If a swap occurred in the last pass, repeat outer loop
end:
    li t0, 0x880
    li x10, 1
    sw x10, 0(t0)
