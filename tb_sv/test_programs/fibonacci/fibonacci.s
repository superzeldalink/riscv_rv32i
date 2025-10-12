.data
n: .word 46
LEDR: .word 0x880

.text
main:
    lw s0, LEDR
    li t0, 0 # curr_fib = 0
    li t1, 1 # next_fib = 1
    lw t3, n # get the value that is stored at the adddress denoted by the label n
fib:
    beq t3, x0, halt # exit loop once we have completed n iterations
    add t2, t1, t0 # new_fib = curr_fib + next_fib;
    mv t0, t1 # curr_fib = next_fib;
    mv t1, t2 # next_fib = new_fib;
    sw t0, 0(s0)
    addi t3, t3, -1 # decrement counter
    j fib # loop
halt:
    j halt