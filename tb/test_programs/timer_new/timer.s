.data
    timer: .word 0xa10
    HEX: .word 0x8B0
    BCD: .word 0xa00
    KEY: .word 0x910

# s0: timer
# s1: HEX
# s2: BCD
# s3: second
# s4: KEY
# s5: minute
# s6: status
.text
    lw s0, timer
    lw s1, HEX
    lw s2, BCD
    li s3, 0
    lw s4, KEY
    li s5, 0
    li s6, 0

    sw x0, 0(s1)

# prescaler
    lw s0, timer
    li a0, 0x00000004
    sw a0, 4(s0)

# start
    li a0, 31250           # start value: 31250 = 0.01s
    # li a0, 20
    sw a0, 0(s0)

key_polling:
    lw t1, 0(s4)
    andi t2, t1, 1
    beqz t2, key0_pressed
    andi t2, t1, 2
    beqz t2, key1_pressed
    j start
key0_pressed:
    not s6, s6
    j wait_for_key_release
key1_pressed:
    li s3, 0
    li s6, 0
    sw s3, 0(s2)
    lw t0, 0(s2)
    sw t0, 0(s1)
wait_for_key_release:
    lw t1, 0(s4)
    not t1, t1
    bnez t1, wait_for_key_release

start:
beqz s6, key_polling

# enable
    li a0, 1
    sw a0, 8(s0)

# wait for done
wait_timer:
    lw a0, 12(s0)
    beqz a0, wait_timer

# add s3, s3 to bcd and show
    addi s3, s3, 1
    li t0, 6000
    bne s3,t0,disp_time
    addi s5,s5,1
    addi s3,x0,0

 disp_time:  
    sw s3, 0(s2)
    lw t0, 4(s2)
    sw s5, 0(s2)
    lw t1, 4(s2)
    slli t1,t1,16
    or t1, t1, t0
    sw t1, 0(s1)


# enable again
    li a0, 0
    sw a0, 8(s0)

    j key_polling

halt:
    j halt

get_sw_data:
    ret