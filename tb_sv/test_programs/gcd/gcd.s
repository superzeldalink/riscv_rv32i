.data
num1: .word 68     # The first number
num2: .word 119    # The second number
LEDR: .word 0x880  # The result will be stored here

.text
.globl _start
_start:
    # Load the numbers into x5 and x6
    lw x5, num1
    lw x6, num2

gcd_loop:
    # If x6 is zero, we're done
    beqz x6, end_gcd

    # If x5 > x6, subtract x6 from x5
    blt x6, x5, subtract

    # Else, subtract x5 from x6
    sub x6, x6, x5
    j gcd_loop

subtract:
    sub x5, x5, x6

    # Jump back to the start of the loop
    j gcd_loop

end_gcd:
    lw t1, LEDR
    sw t0, 0(t1)
halt:
    j halt
