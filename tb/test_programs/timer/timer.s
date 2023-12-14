.data
    timer: .word 0xa10
    HEX: .word 0x8B0
    BCD: .word 0xa00

# s0: timer
# s1: HEX
# s2: BCD
# s3: counter
# 
.text
    lw s0, timer
    lw s1, HEX
    lw s2, BCD
    li s3, 0
# prescaler
    lw s0, timer
    li a0, 0x00000004   # 4
    sw a0, 4(s0)

# start
    li a0, 31250           # start value: 31250 = 0.01s
    # li a0, 20
    sw a0, 0(s0)

start:
# enable
    li a0, 1
    sw a0, 8(s0)

# wait for done
wait_timer:
    lw a0, 12(s0)
    beqz a0, wait_timer

# add s3, s3 to bcd and show
    addi s3, s3, 1
    sw s3, 0(s2)
    lw t0, 4(s2)
    sw t0, 0(s1)

# enable again
    li a0, 0
    sw a0, 8(s0)
    li a0, 1
    sw a0, 8(s0)

    j start

halt:
    j halt