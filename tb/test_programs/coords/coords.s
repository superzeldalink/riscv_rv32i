.data
    Ax: .word 2
    Ay: .word 5
    Bx: .word 7
    By: .word 3
    Cx: .word 1
    Cy: .word 2
    KEY_addr: .word 0x910
    SW_addr: .word 0x900
    
.text
    li t2, 6            # Counter
    la t3, Ax           # Address of first data
get_and_store:
    beqz t2, calculate
    addi t2, t2 -1
    lw t0, KEY_addr
key_polling:
    lw t1, 0(t0)
    not t1, t1
    beqz t1, key_polling
wait_for_key_release:
    lw t1, 0(t0)
    not t1, t1
    bnez t1, wait_for_key_release
    
    lw t0, SW_addr
    lw t0, 0(t0)
    sw t0, 0(t3)

    addi t3, t3, 4
    
    j get_and_store

calculate:
    lw t0, Cx
    lw t1, Ax
    sub a2, t0, t1      # a2 = Cx - Ax
    jal abs
    li a3, 2
    jal pow
    mv s10, a0          # s10 = (Cx - Ax)^2
    
    lw t0, Cy
    lw t1, Ay
    sub a2, t0, t1      # a2 = Cy - Ay
    jal abs
    li a3, 2
    jal pow
    add s10, s10, a0   # s10 = (Cx - Ax)^2 + (Cy - Ay)^2
    ## ==> s10 = dist(A, C)^2
    
    lw t0, Cx
    lw t1, Bx
    sub a2, t0, t1      # a2 = Cx - Bx
    jal abs
    li a3, 2
    jal pow
    mv s11, a0          # s10 = (Cx - Bx)^2
    
    lw t0, Cy
    lw t1, By
    sub a2, t0, t1      # a2 = Cy - By
    jal abs
    li a3, 2
    jal pow
    add s11, s11, a0   # s10 = (Cx - Bx)^2 + (Cy - By)^2
    ## ==> s11 = dist(B, C)^2
    
halt:
    j halt

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
    