.data
n: .word 46
LEDR: .word 0x880

.text
main:
    lw s0, 4(x0)
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0

    lw t3, 0(x0) # get the value that is stored at the adddress denoted by the label n
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0

    sw t3, 0(s0)

    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0
    add x0, x0, x0


halt:
    j halt