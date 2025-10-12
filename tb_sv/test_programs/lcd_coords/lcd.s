.data
    LCD: .word 0x8A0
    KEY: .word 0x910
    timer: .word 0xA10
    SW: .word 0x900
    BCD:.word 0xA00
    ms: .word 50000  # = 1ms
    fiftyms: .word 2500000
    us: .word 50     #(50/3)
    Ax: .word 2
    Ay: .word 5
    Bx: .word 7
    By: .word 3
    Cx: .word 1
    Cy: .word 2

.text
# Registers:
#   s0: address of LCD
#   s1: address of timer
#   s2: address of BCD
main:
    lw s0, LCD
    lw s1, timer
    lw s2, BCD

# enable LCD
    li t0, 0x80000000
    sw t0, 0(s0)

    lw a0, fiftyms
    jal start_n_wait_timer
    
# Init LCD
    addi a0, x0, 0b00000111000
    jal lcd_write
    addi a0, x0, 0b00000001110
    jal lcd_write
    addi a0, x0, 0b00000000110
    jal lcd_write

    # clear display
    addi a0, x0, 0b00000000001
    jal lcd_write

    lw a0, ms
    jal start_n_wait_timer
    
    li a0, 'A'
    jal lcd_print_char
    
    li a0, 40 # '('
    jal lcd_print_char

    lw a0, Ax
    jal lcd_bcd_print

    li a0, ','
    jal lcd_print_char

    lw a0, Ay
    jal lcd_bcd_print

    li a0, 41 # ')'
    jal lcd_print_char

    li a0, 'B'
    jal lcd_print_char
    
    li a0, 40 # '('
    jal lcd_print_char

    lw a0, Bx
    jal lcd_bcd_print

    li a0, ','
    jal lcd_print_char

    lw a0, By
    jal lcd_bcd_print

    li a0, 41 # ')'
    jal lcd_print_char

    li a0, 'C'
    jal lcd_print_char
    
    li a0, 40 # '('
    jal lcd_print_char

    lw a0, Cx
    jal lcd_bcd_print

    li a0, ','
    jal lcd_print_char

    lw a0, Cy
    jal lcd_bcd_print

    li a0, 41 # ')'
    jal lcd_print_char

calculate:
    lw a0, Cx
    lw a1, Ax
    jal diff_n_pow
    mv s10, a0          # s10 = (Cx - Ax)^2
    
    lw a0, Cy
    lw a1, Ay
    jal diff_n_pow
    add s10, s10, a0   # s10 = (Cx - Ax)^2 + (Cy - Ay)^2
    ## ==> s10 = dist(A, C)^2
    
    lw a0, Cx
    lw a1, Bx
    jal diff_n_pow
    mv s11, a0          # s10 = (Cx - Bx)^2
    
    lw a0, Cy
    lw a1, By
    jal diff_n_pow
    add s11, s11, a0   # s10 = (Cx - Bx)^2 + (Cy - By)^2
    ## ==> s11 = dist(B, C)^2

calc_done:
    li a0, ' '
    jal lcd_print_char
    li a0, '='
    jal lcd_print_char
    li a0, '>'
    jal lcd_print_char
    li a0, ' '
    jal lcd_print_char

    bgt s10, s11, AgtB # A < B
    li a0, 'A'
    jal lcd_print_char
    bne s10, s11, halt
AgtB:
    li a0, 'B'
    jal lcd_print_char
    
halt:
    j halt

lcd_bcd_print:
    mv t5, ra

    sw a0, 0(s2)
    lw t1, 4(s2)
    srli t2, t1, 4
    mv a0, t2
    jal lcd_num_print
    mv a0, t1
    jal lcd_num_print

    jr t5

lcd_num_print:
    andi a0, a0, 0xF
    addi a0, a0, '0'
lcd_print_char:
    ori a0, a0, 0b01000000000
lcd_write:
    mv a1, a0   # store args to a1
    mv t6, ra   # store ra, to t6
    ori t0, a1, 0b10000000000
    sh t0, 0(s0)

    lw a0, ms
    jal start_n_wait_timer

# deassert LCD en
    andi t0, a1, 0b01111111111
    sh t0, 0(s0)
    jr t6

start_n_wait_timer:
# start
    sw a0, 0(s1)

# enable
    li a0, 0x1
    sw a0, 8(s1)

# wait for done
wait_timer:
    lw a0, 12(s1)
    beqz a0, wait_timer
# disable timer
    li a0, 0x0
    sw a0, 8(s1)
    ret # return


# a2 = abs(a2)
abs:
    bgtz a2, abs_done
    not a2, a2
    addi a2, a2, 1
abs_done:
    ret
    
# a0 = pow(a2, a3)
pow:
    mv a0, a2
    mv t1, a2
pow_loop:
    addi a3, a3, -1
    beq a3, x0, pow_done
    mv t0, a2
mul_loop:
    addi t0, t0, -1
    beq t0, x0, mul_done
    add a0, a0, t1
    j mul_loop
mul_done:
    mv t1, a0
    j pow_loop
pow_done:
    ret

diff_n_pow:
    mv t6, ra

    sub a2, a0, a1      # a2 = Cx - Ax
    jal abs
    li a3, 2
    jal pow
    
    jr t6