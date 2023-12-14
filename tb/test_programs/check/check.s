addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lw x10, 1280(x0)
beq x10, x0, 600
lw x10, 1280(x0)
sw x10, 1024(x0)
lb x10, 1280(x0)
sw x10, 1040(x0)
lbu x10, 1280(x0)
sw x10, 1056(x0)
lh x10, 1280(x0)
sw x10, 1072(x0)
lhu x10, 1280(x0)
sw x10, 1088(x0)
lw x10, 1280(x0)
sw x10, 1104(x0)
sw x10, 1120(x0)
sb x12, 1104(x0)
sh x12, 1120(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lw x10, 1280(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lw x11, 1280(x0)
addi x0, x0, 0
addi x0, x0, 0
add x12, x10, x11
sw x12, 1024(x0)
sub x12, x10, x11
sw x12, 1040(x0)
addi x13, x12, 1999
sw x13, 1056(x0)
addi x14, x12, 463
sw x14, 1072(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
and x12, x10, x11
sw x12, 1024(x0)
add x5, x12, x0
or x13, x10, x11
sw x13, 1040(x0)
add x6, x13, x0
xor x14, x10, x11
sw x14, 1056(x0)
add x7, x14, x0
andi x12, x10, 463
sw x12, 1072(x0)
add x28, x12, x0
ori x13, x10, 463
sw x13, 1088(x0)
xori x14, x10, 463
sw x14, 1104(x0)
andi x12, x10, 1999
sw x12, 1120(x0)
ori x13, x10, 1999
sw x13, 1136(x0)
xori x14, x10, 1999
sw x14, 1152(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
add x10, x0, x0
add x29, x0, x0
slt x29, x7, x6
or x10, x10, x29
slli x10, x10, 1
sltu x29, x7, x6
or x10, x10, x29
slli x10, x10, 1
slt x29, x6, x28
or x10, x10, x29
slli x10, x10, 1
sltu x29, x6, x28
or x10, x10, x29
slli x10, x10, 1
slt x29, x28, x5
or x10, x10, x29
slli x10, x10, 1
sltu x29, x28, x5
or x10, x10, x29
sw x10, 1024(x0)
addi x5, x0, 26
sll x11, x10, x5
srl x12, x11, x5
sra x13, x11, x5
sw x11, 1040(x0)
sw x12, 1056(x0)
sw x13, 1072(x0)
slli x11, x10, 28
srli x12, x11, 28
srai x13, x11, 28
sw x11, 1088(x0)
sw x12, 1104(x0)
sw x13, 1120(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x10, x0, 21
addi x11, x0, 73
addi x12, x0, -21
addi x13, x0, -73
add x14, x0, x11
beq x11, x14, 36
beq x10, x11, 80
bne x10, x11, 40
blt x10, x11, 48
bge x12, x11, 68
bgeu x12, x11, 52
add x6, x0, x1
jalr x1, 0(x1)
bltu x11, x13, 52
addi x5, x0, 12
slli x5, x5, 4
beq x11, x14, -40
addi x5, x5, 10
slli x5, x5, 4
bne x10, x11, -44
addi x5, x5, 14
slli x5, x5, 4
blt x10, x11, -52
addi x5, x5, 14
slli x5, x5, 4
bge x11, x12, -48
slli x5, x5, 8
addi x5, x5, 515
sw x5, 1152(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
jal x1, -88
auipc x10, 0
sub x10, x10, x6
beq x10, x0, 12
add x6, x0, x0
jal x0, 8
sw x6, 1024(x0)
lui x5, -221005
addi x5, x5, 515
sw x5, 1040(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x5, x0, 1
sw x5, 1168(x0)
addi x0, x0, 0
addi x1, x0, 0
addi x2, x0, 1024
addi x3, x0, 0
addi x4, x0, 0
addi x5, x0, 0
addi x6, x0, 0
addi x7, x0, 0
addi x8, x0, 0
addi x10, x0, 0
addi x11, x0, 0
addi x12, x0, 0
addi x19, x0, 0
addi x14, x0, 0
addi x15, x0, 0
addi x16, x0, 0
addi x17, x0, 0
addi x18, x0, 0
addi x19, x0, 0
addi x20, x0, 0
addi x21, x0, 0
addi x22, x0, 0
addi x23, x0, 0
addi x24, x0, 0
addi x25, x0, 0
addi x26, x0, 0
addi x27, x0, 0
addi x28, x0, 0
addi x29, x0, 0
addi x30, x0, 0
addi x31, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -360(x6)
addi x10, x0, 1
auipc x6, 1
jalr x1, -180(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, 380(x6)
addi x10, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x11, x0, 63
sw x11, 0(x0)
addi x11, x0, 6
sw x11, 4(x0)
addi x11, x0, 91
sw x11, 8(x0)
addi x11, x0, 79
sw x11, 12(x0)
addi x11, x0, 102
sw x11, 16(x0)
addi x11, x0, 109
sw x11, 20(x0)
addi x11, x0, 125
sw x11, 24(x0)
addi x11, x0, 7
sw x11, 28(x0)
addi x11, x0, 127
sw x11, 32(x0)
addi x11, x0, 103
sw x11, 36(x0)
addi x11, x0, 119
sw x11, 40(x0)
addi x11, x0, 124
sw x11, 44(x0)
addi x11, x0, 57
sw x11, 48(x0)
addi x11, x0, 94
sw x11, 52(x0)
addi x11, x0, 121
sw x11, 56(x0)
addi x11, x0, 113
sw x11, 60(x0)
addi x11, x0, 64
sw x11, 64(x0)
lui x11, -524288
addi x11, x11, 1584
sw x11, 68(x0)
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
auipc x6, 1
jalr x1, -1764(x6)
sw x10, 1152(x0)
sw x10, 80(x0)
auipc x6, 1
jalr x1, -1332(x6)
sw x10, 1152(x0)
sw x10, 84(x0)
addi x0, x0, 0
addi x0, x0, 0
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -1500(x6)
sw x10, 1152(x0)
sw x10, 88(x0)
auipc x6, 1
jalr x1, -1404(x6)
sw x10, 1152(x0)
sw x10, 92(x0)
addi x0, x0, 0
addi x0, x0, 0
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 0
jalr x1, 724(x6)
sw x10, 1152(x0)
sw x10, 96(x0)
auipc x6, 1
jalr x1, -1476(x6)
sw x10, 1152(x0)
sw x10, 100(x0)
addi x0, x0, 0
addi x0, x0, 0
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 0
jalr x1, 996(x6)
sw x10, 1152(x0)
sw x10, 104(x0)
auipc x6, 1
jalr x1, -1548(x6)
sw x10, 1152(x0)
sw x10, 108(x0)
addi x0, x0, 0
addi x0, x0, 0
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 0
jalr x1, 1640(x6)
sw x10, 1152(x0)
sw x10, 112(x0)
auipc x6, 1
jalr x1, -1620(x6)
sw x10, 1152(x0)
sw x10, 116(x0)
addi x0, x0, 0
addi x0, x0, 0
lw x5, 1168(x0)
slli x5, x5, 1
addi x5, x5, 1
sw x5, 1168(x0)
andi x10, x10, 255
andi x5, x10, 15
slli x5, x5, 2
lw x30, 0(x5)
sw x30, 1120(x0)
andi x5, x10, 240
srli x5, x5, 2
lw x30, 0(x5)
sw x30, 1136(x0)
andi x5, x10, 128
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
lw x5, 84(x0)
sw x5, 1152(x0)
auipc x6, 1
jalr x1, 84(x6)
lw x10, 1280(x0)
lui x5, 12
addi x5, x5, 0
and x10, x10, x5
srli x10, x10, 14
lw x5, 72(x0)
beq x10, x5, -40
sw x10, 72(x0)
beq x10, x0, 24
addi x5, x0, 1
beq x10, x5, 48
addi x5, x0, 2
beq x10, x5, 136
jal x0, 228
addi x10, x0, 1
auipc x6, 1
jalr x1, -864(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -304(x6)
jal x0, -100
addi x10, x0, 1
auipc x6, 1
jalr x1, -896(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -536(x6)
lw x10, 84(x0)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -1276(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -472(x6)
lw x10, 92(x0)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -1312(x6)
addi x0, x0, 0
addi x0, x0, 0
jal x0, -196
addi x10, x0, 1
auipc x6, 1
jalr x1, -992(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -904(x6)
lw x10, 100(x0)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -1372(x6)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -840(x6)
lw x10, 108(x0)
addi x0, x0, 0
addi x0, x0, 0
auipc x6, 1
jalr x1, -1408(x6)
addi x0, x0, 0
addi x0, x0, 0
jal x0, -292
jal x0, -296
addi x0, x0, 0
addi x0, x0, 0
addi x9, x10, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -48
sw x1, 44(x2)
sw x8, 40(x2)
addi x8, x2, 48
sw x10, -36(x8)
sw x11, -40(x8)
lw x14, -36(x8)
lw x15, -40(x8)
bne x14, x15, 16
lw x15, -36(x8)
sw x15, -20(x8)
jal x0, 72
lw x14, -36(x8)
lw x15, -40(x8)
bge x15, x14, 24
lw x14, -36(x8)
lw x15, -40(x8)
sub x15, x14, x15
sw x15, -36(x8)
jal x0, 20
lw x14, -40(x8)
lw x15, -36(x8)
sub x15, x14, x15
sw x15, -40(x8)
lw x11, -40(x8)
lw x10, -36(x8)
auipc x6, 0
jalr x1, -104(x6)
sw x10, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
lw x1, 44(x2)
lw x8, 40(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
lui x15, 36
addi x15, x15, 1920
sw x15, -20(x8)
lui x15, 12
addi x15, x15, -916
sw x15, -24(x8)
lw x11, -24(x8)
lw x10, -20(x8)
auipc x6, 0
jalr x1, -188(x6)
sw x10, -28(x8)
lw x15, -28(x8)
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x1, 0
jalr x1, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -48
sw x1, 44(x2)
sw x8, 40(x2)
addi x8, x2, 48
sw x10, -36(x8)
sw x11, -40(x8)
sw x12, -44(x8)
sw x13, -48(x8)
sw x0, -20(x8)
lw x14, -36(x8)
addi x15, x0, 1
bne x14, x15, 16
addi x15, x0, 1
sw x15, -20(x8)
jal x0, 140
lw x15, -36(x8)
addi x15, x15, -1
lw x13, -44(x8)
lw x12, -48(x8)
lw x11, -40(x8)
addi x10, x15, 0
auipc x6, 0
jalr x1, -84(x6)
addi x14, x10, 0
lw x15, -20(x8)
add x15, x15, x14
sw x15, -20(x8)
lw x13, -48(x8)
lw x12, -44(x8)
lw x11, -40(x8)
addi x10, x0, 1
auipc x6, 0
jalr x1, -124(x6)
addi x14, x10, 0
lw x15, -20(x8)
add x15, x15, x14
sw x15, -20(x8)
lw x15, -36(x8)
addi x15, x15, -1
lw x13, -48(x8)
lw x12, -40(x8)
lw x11, -44(x8)
addi x10, x15, 0
auipc x6, 0
jalr x1, -172(x6)
addi x14, x10, 0
lw x15, -20(x8)
add x15, x15, x14
sw x15, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
lw x1, 44(x2)
lw x8, 40(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x2, x2, -48
sw x1, 44(x2)
sw x8, 40(x2)
addi x8, x2, 48
addi x15, x0, 1
sw x15, -20(x8)
addi x15, x0, 2
sw x15, -24(x8)
addi x15, x0, 3
sw x15, -28(x8)
addi x15, x0, 10
sw x15, -32(x8)
lw x13, -28(x8)
lw x12, -24(x8)
lw x11, -20(x8)
lw x10, -32(x8)
auipc x6, 0
jalr x1, -284(x6)
sw x10, -36(x8)
lw x15, -36(x8)
addi x10, x15, 0
lw x1, 44(x2)
lw x8, 40(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -48
sw x1, 44(x2)
sw x8, 40(x2)
addi x8, x2, 48
sw x10, -36(x8)
sw x11, -40(x8)
sw x12, -44(x8)
sw x13, -48(x8)
lw x14, -48(x8)
lw x15, -44(x8)
sub x15, x14, x15
srli x14, x15, 31
add x15, x14, x15
srai x15, x15, 1
addi x14, x15, 0
lw x15, -44(x8)
add x15, x15, x14
sw x15, -20(x8)
lw x14, -44(x8)
lw x15, -48(x8)
bge x15, x14, 12
addi x15, x0, -1
jal x0, 144
lw x15, -20(x8)
slli x15, x15, 2
lw x14, -36(x8)
add x15, x14, x15
lw x15, 0(x15)
lw x14, -40(x8)
bne x14, x15, 12
lw x15, -20(x8)
jal x0, 108
lw x15, -20(x8)
slli x15, x15, 2
lw x14, -36(x8)
add x15, x14, x15
lw x15, 0(x15)
lw x14, -40(x8)
bge x14, x15, 44
lw x15, -20(x8)
addi x15, x15, -1
addi x13, x15, 0
lw x12, -44(x8)
lw x11, -40(x8)
lw x10, -36(x8)
auipc x6, 0
jalr x1, -180(x6)
addi x15, x10, 0
jal x0, 40
lw x15, -20(x8)
addi x15, x15, 1
lw x13, -48(x8)
addi x12, x15, 0
lw x11, -40(x8)
lw x10, -36(x8)
auipc x6, 0
jalr x1, -220(x6)
addi x15, x10, 0
addi x10, x15, 0
lw x1, 44(x2)
lw x8, 40(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
sw x10, -20(x8)
sw x11, -24(x8)
sw x12, -28(x8)
lw x15, -28(x8)
addi x15, x15, -1
addi x13, x15, 0
addi x12, x0, 0
lw x11, -24(x8)
lw x10, -20(x8)
auipc x6, 0
jalr x1, -304(x6)
addi x15, x10, 0
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -48
sw x8, 44(x2)
addi x8, x2, 48
sw x10, -36(x8)
sw x11, -40(x8)
sw x0, -20(x8)
jal x0, 204
sw x0, -24(x8)
jal x0, 160
lw x15, -24(x8)
addi x15, x15, 1
slli x15, x15, 2
lw x14, -36(x8)
add x15, x14, x15
lw x14, 0(x15)
lw x15, -24(x8)
slli x15, x15, 2
lw x13, -36(x8)
add x15, x13, x15
lw x15, 0(x15)
bge x14, x15, 100
lw x15, -24(x8)
slli x15, x15, 2
lw x14, -36(x8)
add x15, x14, x15
lw x15, 0(x15)
sw x15, -28(x8)
lw x15, -24(x8)
addi x15, x15, 1
slli x15, x15, 2
lw x14, -36(x8)
add x14, x14, x15
lw x15, -24(x8)
slli x15, x15, 2
lw x13, -36(x8)
add x15, x13, x15
lw x14, 0(x14)
sw x14, 0(x15)
lw x15, -24(x8)
addi x15, x15, 1
slli x15, x15, 2
lw x14, -36(x8)
add x15, x14, x15
lw x14, -28(x8)
sw x14, 0(x15)
lw x15, -24(x8)
addi x15, x15, 1
sw x15, -24(x8)
lw x14, -40(x8)
lw x15, -20(x8)
sub x15, x14, x15
addi x15, x15, -1
lw x14, -24(x8)
blt x14, x15, -176
lw x15, -20(x8)
addi x15, x15, 1
sw x15, -20(x8)
lw x15, -40(x8)
addi x15, x15, -1
lw x14, -20(x8)
blt x14, x15, -212
addi x0, x0, 0
addi x10, x15, 0
lw x8, 44(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x2, x2, -92
sw x1, 88(x2)
sw x8, 84(x2)
addi x8, x2, 92
addi x16, x0, 37
sw x16, -80(x8)
addi x10, x0, 2
sw x10, -76(x8)
addi x11, x0, 13
sw x11, -72(x8)
addi x12, x0, 3
sw x12, -68(x8)
addi x13, x0, 19
sw x13, -64(x8)
addi x14, x0, 7
sw x14, -60(x8)
addi x15, x0, 5
sw x15, -56(x8)
addi x17, x0, 11
sw x17, -52(x8)
addi x16, x0, 47
sw x16, -48(x8)
addi x10, x0, 17
sw x10, -44(x8)
addi x11, x0, 29
sw x11, -40(x8)
addi x12, x0, 43
sw x12, -36(x8)
addi x13, x0, 31
sw x13, -32(x8)
addi x14, x0, 23
sw x14, -28(x8)
addi x15, x0, 41
sw x15, -24(x8)
addi x15, x8, -80
addi x11, x0, 15
addi x10, x15, 0
auipc x6, 0
jalr x1, -412(x6)
addi x15, x8, -80
addi x12, x0, 15
addi x11, x0, 31
addi x10, x15, 0
auipc x6, 0
jalr x1, -520(x6)
sw x10, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
lw x1, 88(x2)
lw x8, 84(x2)
addi x2, x2, 82
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x1, 0
jalr x1, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
sw x9, 20(x2)
addi x8, x2, 32
sw x10, -20(x8)
lw x14, -20(x8)
addi x15, x0, 1
blt x15, x14, 12
lw x15, -20(x8)
jal x0, 56
lw x15, -20(x8)
addi x15, x15, -1
addi x10, x15, 0
auipc x6, 0
jalr x1, -56(x6)
addi x9, x10, 0
lw x15, -20(x8)
addi x15, x15, -2
addi x10, x15, 0
auipc x6, 0
jalr x1, -80(x6)
addi x15, x10, 0
add x15, x9, x15
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
lw x9, 20(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -32
sw x8, 28(x2)
addi x8, x2, 32
sw x10, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
lw x8, 28(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x15, x0, 15
sw x15, -20(x8)
lw x10, -20(x8)
auipc x6, 0
jalr x1, -184(x6)
addi x15, x10, 0
addi x10, x15, 0
auipc x6, 0
jalr x1, -80(x6)
sw x10, -24(x8)
lw x15, -24(x8)
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x1, 0
jalr x1, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -48
sw x8, 44(x2)
addi x8, x2, 48
sw x10, -36(x8)
sw x11, -40(x8)
sw x0, -24(x8)
sw x0, -20(x8)
jal x0, 32
lw x14, -24(x8)
lw x15, -36(x8)
add x15, x14, x15
sw x15, -24(x8)
lw x15, -20(x8)
addi x15, x15, 1
sw x15, -20(x8)
lw x14, -20(x8)
lw x15, -40(x8)
bltu x14, x15, -36
lw x15, -24(x8)
addi x10, x15, 0
lw x8, 44(x2)
addi x2, x2, 48
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
sw x10, -20(x8)
lw x15, -20(x8)
bne x15, x0, 12
addi x15, x0, 0
jal x0, 72
lw x14, -20(x8)
addi x15, x0, 1
bne x14, x15, 12
addi x15, x0, 1
jal x0, 52
lw x15, -20(x8)
addi x15, x15, -1
addi x10, x15, 0
auipc x6, 0
jalr x1, -68(x6)
addi x15, x10, 0
addi x11, x15, 0
lw x10, -20(x8)
auipc x6, 0
jalr x1, -180(x6)
sw x10, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x15, x0, 8
sw x15, -20(x8)
lw x15, -20(x8)
addi x10, x15, 0
auipc x6, 0
jalr x1, -156(x6)
addi x15, x10, 0
sw x15, -24(x8)
lw x15, -24(x8)
addi x10, x15, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
auipc x1, 0
jalr x1, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x15, x10, 0
addi x11, x0, 0
lui x12, 2441
addi x12, x12, 1664
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 344(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
lui x12, 244
addi x12, x12, 576
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 296(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
lui x12, 24
addi x12, x12, 1696
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 248(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
lui x12, 2
addi x12, x12, 1808
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 200(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
addi x12, x0, 1000
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 156(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
addi x12, x0, 100
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 112(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
addi x12, x0, 10
addi x2, x2, -32
sw x1, 28(x2)
sw x12, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 68(x6)
slli x11, x11, 4
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
addi x12, x0, 1
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
auipc x6, 0
jalr x1, 24(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jal x0, 24
bge x15, x12, 8
jalr x0, 0(x1)
addi x11, x11, 1
sub x15, x15, x12
jal x0, -16
addi x10, x11, 0
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x5, x0, 6
beq x5, x11, 12
beq x0, x11, 48
jal x0, 100
andi x5, x10, 15
slli x5, x5, 2
lw x11, 0(x5)
sw x11, 1120(x0)
srli x10, x10, 4
andi x5, x10, 15
slli x5, x5, 2
lw x11, 0(x5)
sw x11, 1136(x0)
jal x0, 60
andi x5, x10, 15
slli x5, x5, 2
lw x11, 0(x5)
sw x11, 1024(x0)
srli x10, x10, 4
andi x5, x10, 15
slli x5, x5, 2
lw x11, 0(x5)
sw x11, 1040(x0)
srli x10, x10, 4
andi x5, x10, 15
slli x5, x5, 2
lw x11, 0(x5)
sw x11, 1056(x0)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x12, x0, 8
addi x11, x0, 0
add x15, x0, x10
beq x0, x12, 28
slli x11, x11, 4
andi x6, x15, 15
or x11, x11, x6
srli x15, x15, 4
addi x12, x12, -1
jal x0, -24
andi x5, x11, 15
beq x5, x0, 8
jal x0, 24
srli x11, x11, 4
lui x6, -65536
addi x6, x6, 0
or x11, x11, x6
jal x0, -28
andi x6, x11, 15
addi x7, x0, 10
bge x6, x7, 40
addi x10, x6, 0
addi x10, x10, 48
auipc x6, 0
jalr x1, 132(x6)
srli x11, x11, 4
lui x5, -65536
addi x5, x5, 0
or x11, x11, x5
jal x0, -44
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 56
auipc x6, 0
jalr x1, 172(x6)
addi x10, x0, 15
auipc x6, 0
jalr x1, 160(x6)
addi x10, x0, 6
auipc x6, 0
jalr x1, 148(x6)
addi x10, x0, 1
auipc x6, 0
jalr x1, 136(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
sw x10, 20(x2)
sw x11, 16(x2)
addi x11, x0, 10
lui x12, -524288
addi x12, x12, 1536
or x10, x12, x10
sw x10, 1184(x0)
auipc x6, 0
jalr x1, 1076(x6)
addi x12, x0, 1024
xor x10, x12, x10
sw x10, 1184(x0)
auipc x6, 0
jalr x1, 1056(x6)
lw x10, 20(x2)
lw x11, 16(x2)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
sw x10, 20(x2)
sw x11, 16(x2)
addi x11, x0, 50
lui x12, -524288
addi x12, x12, 1024
or x10, x12, x10
sw x10, 1184(x0)
auipc x6, 0
jalr x1, 972(x6)
addi x12, x0, 1024
xor x10, x12, x10
sw x10, 1184(x0)
auipc x6, 0
jalr x1, 952(x6)
lw x10, 20(x2)
lw x11, 16(x2)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 128
auipc x6, 0
jalr x1, -124(x6)
addi x10, x0, 71
auipc x6, 0
jalr x1, -240(x6)
addi x10, x0, 67
auipc x6, 0
jalr x1, -252(x6)
addi x10, x0, 68
auipc x6, 0
jalr x1, -264(x6)
addi x10, x0, 61
auipc x6, 0
jalr x1, -276(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 192
auipc x6, 0
jalr x1, -224(x6)
addi x10, x0, 84
auipc x6, 0
jalr x1, -340(x6)
addi x10, x0, 111
auipc x6, 0
jalr x1, -352(x6)
addi x10, x0, 119
auipc x6, 0
jalr x1, -364(x6)
addi x10, x0, 101
auipc x6, 0
jalr x1, -376(x6)
addi x10, x0, 114
auipc x6, 0
jalr x1, -388(x6)
addi x10, x0, 40
auipc x6, 0
jalr x1, -400(x6)
addi x10, x0, 49
auipc x6, 0
jalr x1, -412(x6)
addi x10, x0, 54
auipc x6, 0
jalr x1, -424(x6)
addi x10, x0, 41
auipc x6, 0
jalr x1, -436(x6)
addi x10, x0, 61
auipc x6, 0
jalr x1, -448(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 128
auipc x6, 0
jalr x1, -396(x6)
addi x10, x0, 70
auipc x6, 0
jalr x1, -512(x6)
addi x10, x0, 50
auipc x6, 0
jalr x1, -524(x6)
addi x10, x0, 57
auipc x6, 0
jalr x1, -536(x6)
addi x10, x0, 61
auipc x6, 0
jalr x1, -548(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 192
auipc x6, 0
jalr x1, -496(x6)
addi x10, x0, 49
auipc x6, 0
jalr x1, -612(x6)
addi x10, x0, 49
auipc x6, 0
jalr x1, -624(x6)
addi x10, x0, 33
auipc x6, 0
jalr x1, -636(x6)
addi x10, x0, 61
auipc x6, 0
jalr x1, -648(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
addi x10, x0, 132
auipc x6, 0
jalr x1, -596(x6)
addi x10, x0, 67
auipc x6, 0
jalr x1, -712(x6)
addi x10, x0, 111
auipc x6, 0
jalr x1, -724(x6)
addi x10, x0, 109
auipc x6, 0
jalr x1, -736(x6)
addi x10, x0, 112
auipc x6, 0
jalr x1, -748(x6)
addi x10, x0, 117
auipc x6, 0
jalr x1, -760(x6)
addi x10, x0, 116
auipc x6, 0
jalr x1, -772(x6)
addi x10, x0, 101
auipc x6, 0
jalr x1, -784(x6)
addi x10, x0, 114
auipc x6, 0
jalr x1, -796(x6)
addi x10, x0, 194
auipc x6, 0
jalr x1, -704(x6)
addi x10, x0, 65
auipc x6, 0
jalr x1, -820(x6)
addi x10, x0, 114
auipc x6, 0
jalr x1, -832(x6)
addi x10, x0, 99
auipc x6, 0
jalr x1, -844(x6)
addi x10, x0, 104
auipc x6, 0
jalr x1, -856(x6)
addi x10, x0, 105
auipc x6, 0
jalr x1, -868(x6)
addi x10, x0, 116
auipc x6, 0
jalr x1, -880(x6)
addi x10, x0, 101
auipc x6, 0
jalr x1, -892(x6)
addi x10, x0, 99
auipc x6, 0
jalr x1, -904(x6)
addi x10, x0, 116
auipc x6, 0
jalr x1, -916(x6)
addi x10, x0, 117
auipc x6, 0
jalr x1, -928(x6)
addi x10, x0, 114
auipc x6, 0
jalr x1, -940(x6)
addi x10, x0, 101
auipc x6, 0
jalr x1, -952(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
addi x2, x2, -32
sw x1, 28(x2)
sw x8, 24(x2)
addi x8, x2, 32
lw x10, 1280(x0)
andi x10, x10, 255
andi x5, x10, 15
slli x5, x5, 2
lw x30, 0(x5)
sw x30, 1088(x0)
andi x5, x10, 240
srli x5, x5, 2
lw x30, 0(x5)
sw x30, 1104(x0)
andi x5, x10, 128
bne x5, x0, 12
addi x5, x0, 0
jal x0, 16
sub x10, x0, x10
andi x10, x10, 255
lw x5, 64(x0)
sw x5, 1072(x0)
auipc x6, 0
jalr x1, -1896(x6)
addi x0, x0, 0
addi x11, x0, 0
auipc x6, 0
jalr x1, -1472(x6)
lw x1, 28(x2)
lw x8, 24(x2)
addi x2, x2, 32
jalr x0, 0(x1)
addi x0, x0, 0
addi x0, x0, 0
add x5, x11, x0
beq x5, x0, 12
addi x5, x5, -1
jal x0, -8
jalr x0, 0(x1)
ebreak
