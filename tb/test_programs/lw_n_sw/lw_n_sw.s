# .data
#     SW:   .word 0x900
#     LEDR: .word 0x880
#     LEDG: .word 0x890
# .text
#     lw t1, SW
#     lw t1, 0(t1)
#     lw t2, LEDR
#     sw t1, 0(t2)

#     addi t1, t1, 10
#     lw t2, LEDG
#     sw t1, 0(t2)
# halt:
#     j halt

.data
    SW:     .word 0x900
    LEDR:   .word 0x880
    Number: .word 0x003
.text   
    lw t1, SW
    lw t1, 0(t1)
    lw t3, Number
    lw t3, 0(t3)
    sub t1, t1, t3

    lw t2, LEDR
    sw t1, 0(t2)
halt: 
    j halt