.data
    n: .word 5
    LEDR: .word 0x880
    SW: .word 0x900
    
.text
    li a2, 10
main:
    addi a2, a2, -1
    bltz a2, loop_done

_start:
    # Initialize variables
    lw  a0, SW
    lw a0, 0(a0)
    li  t0, 1      # Set t0 to 1 (accumulator for the factorial)
    li a1, 10
    
loop:
    beqz a0, done  # Branch to done if a0 is 0
    jal mult
    addi a0, a0, -1  # Decrement a0 by 1
    j    loop     # Jump back to the loop
    
done:
    j main

loop_done:
    lw t1, LEDR
    sw t0, 0(t1)
halt:
    j halt

# t0 = t0 * a0
mult:
    mv t1, a0
    mv t2, t0
mult_loop:
    addi t1, t1, -1
    beqz t1, mult_done
    add t0, t0, t2
    j mult_loop
mult_done:
    ret