.data
n: .word 46
LEDR: .word 0x880
BCD: .word 0xA00
HEX2HEX: .word 0x8B0

.text
main:
    lw s0, LEDR
    lw s1, BCD
    lw s2, HEX2HEX
    li t0, 0 # curr_fib = 0
    li t1, 1 # next_fib = 1
    lw t3, n # get the value that is stored at the adddress denoted by the label n
fib:
    beq t3, x0, done # exit loop once we have completed n iterations
    add t2, t1, t0 # new_fib = curr_fib + next_fib;
    mv t0, t1 # curr_fib = next_fib;
    mv t1, t2 # next_fib = new_fib;
    addi t3, t3, -1 # decrement counter
    j fib # loop
done:
    sw t0, 0(s0)
    sw t0, 0(s1)
    lw t0, 0(s1)
    sw t0, 0(s2)
halt:
    j halt