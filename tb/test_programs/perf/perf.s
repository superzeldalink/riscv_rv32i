.data
    timer: .word 0x8d0
    LEDG: .word 0x890
    LEDR: .word 0x880

.text
    lw t0, LEDG
    li t1, 0x123456
    sw t1, 0(t0)

    lw t0, LEDR
    li t1, 0x123456
    sw t1, 0(t0)

halt:
    j halt