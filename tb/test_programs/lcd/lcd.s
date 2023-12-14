.data
    LCD: .word 0x8A0
    fiftyms: .word 1250000
    ms: .word 25000  #(50000/2)
    us: .word 25     #(50/2)
    text: .word 'H', 'e', 'l', 'l', 'o', '!'

.text
.globl _start
_start:
    # enable LCD
    lw s0, LCD
    li t0, 0x80000000
    sw t0, 0(s0)

    lw t1, fiftyms
    jal wait
    
#
    addi a0, x0, 0b00000111000
    jal lcd_write
    addi a0, x0, 0b00000001110
    jal lcd_write
    addi a0, x0, 0b00000000110
    jal lcd_write

    # clear display
    addi a0, x0, 0b00000000001
    jal lcd_write

    lw t1, ms
    jal wait

    addi a0, x0, 0b00000000010
    jal lcd_write

    # addi a0, x0, 0b01001001000
    # jal lcd_write
    
    la a1, text # String
print_text:
    lw a0, 0(a1)
    beqz a0, halt
    addi t0, x0, 10
    beq a0, t0, print_newline
    jal lcd_write_text
    j inc_addr
print_newline:
    li a0, 0b00011000000 # new line
    jal lcd_write
inc_addr:
    addi a1, a1, 4
    j print_text
    
halt:
    j halt

# Take data in a0 and output to LCD
lcd_write_text:
    ori a0, a0, 0b01000000000
lcd_write:
    ori t3, a0, 0b10000000000
    sh t3, 0(s0)
    #wait
    lw t1, ms

wait:
    addi t1, t1, -1
    bnez t1, wait

return:
    andi t3, a0, 0b01111111111
    sh t3, 0(s0)
    ret
