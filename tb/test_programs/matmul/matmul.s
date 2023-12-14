.data
.LC0:
  .word 1
  .word 2
  .word 3
  .word 4
  .word 5
  .word 6
  .word 7
  .word 8
  .word 9
.LC1:
  .word 9
  .word 8
  .word 7
  .word 6
  .word 5
  .word 4
  .word 3
  .word 2
  .word 1
.text
main:
  addi sp,sp,-160
  sw ra,156(sp)
  sw s0,152(sp)
  addi s0,sp,160
  la a5,.LC0
  lw t1,0(a5)
  lw a7,4(a5)
  lw a6,8(a5)
  lw a0,12(a5)
  lw a1,16(a5)
  lw a2,20(a5)
  lw a3,24(a5)
  lw a4,28(a5)
  lw a5,32(a5)
  sw t1,-80(s0)
  sw a7,-76(s0)
  sw a6,-72(s0)
  sw a0,-68(s0)
  sw a1,-64(s0)
  sw a2,-60(s0)
  sw a3,-56(s0)
  sw a4,-52(s0)
  sw a5,-48(s0)
  la a5,.LC1
  lw t1,0(a5)
  lw a7,4(a5)
  lw a6,8(a5)
  lw a0,12(a5)
  lw a1,16(a5)
  lw a2,20(a5)
  lw a3,24(a5)
  lw a4,28(a5)
  lw a5,32(a5)
  sw t1,-116(s0)
  sw a7,-112(s0)
  sw a6,-108(s0)
  sw a0,-104(s0)
  sw a1,-100(s0)
  sw a2,-96(s0)
  sw a3,-92(s0)
  sw a4,-88(s0)
  sw a5,-84(s0)
  addi a3,s0,-152
  addi a4,s0,-116
  addi a5,s0,-80
  mv a2,a3
  mv a1,a4
  mv a0,a5
  call multiplyMatrices
  sw zero,-20(s0)
  sw zero,-24(s0)
  j .L2
.L5:
  sw zero,-28(s0)
  j .L3
.L4:
  lw a4,-24(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  lw a4,-28(s0)
  add a5,a5,a4
  slli a5,a5,2
  addi a4,s0,-16
  add a5,a4,a5
  lw a5,-136(a5)
  lw a4,-20(s0)
  add a5,a4,a5
  sw a5,-20(s0)
  lw a5,-28(s0)
  addi a5,a5,1
  sw a5,-28(s0)
.L3:
  lw a4,-28(s0)
  li a5,2
  ble a4,a5,.L4
  lw a5,-24(s0)
  addi a5,a5,1
  sw a5,-24(s0)
.L2:
  lw a4,-24(s0)
  li a5,2
  ble a4,a5,.L5
  li a5,4096
  addi a5,a5,-1920
  sw a5,-32(s0)
  li a5,4096
  addi a5,a5,-1536
  sw a5,-36(s0)
  li a5,4096
  addi a5,a5,-1532
  sw a5,-40(s0)
  li a5,4096
  addi a5,a5,-1872
  sw a5,-44(s0)
  lw a5,-36(s0)
  lw a4,-20(s0)
  sw a4,0(a5)
  lw a5,-40(s0)
  lw a4,0(a5)
  lw a5,-44(s0)
  sw a4,0(a5)
  lw a5,-32(s0)
  lw a4,-20(s0)
  sw a4,0(a5)
.L6:
  j .L6
multiply:
  addi sp,sp,-48
  sw s0,44(sp)
  addi s0,sp,48
  sw a0,-36(s0)
  sw a1,-40(s0)
  sw zero,-20(s0)
  sw zero,-24(s0)
  j .L8
.L9:
  lw a4,-20(s0)
  lw a5,-36(s0)
  add a5,a4,a5
  sw a5,-20(s0)
  lw a5,-24(s0)
  addi a5,a5,1
  sw a5,-24(s0)
.L8:
  lw a4,-24(s0)
  lw a5,-40(s0)
  blt a4,a5,.L9
  lw a5,-20(s0)
  mv a0,a5
  lw s0,44(sp)
  addi sp,sp,48
  jr ra
multiplyMatrices:
  addi sp,sp,-48
  sw ra,44(sp)
  sw s0,40(sp)
  addi s0,sp,48
  sw a0,-36(s0)
  sw a1,-40(s0)
  sw a2,-44(s0)
  sw zero,-20(s0)
  j .L12
.L15:
  sw zero,-24(s0)
  j .L13
.L14:
  lw a4,-20(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  slli a5,a5,2
  mv a4,a5
  lw a5,-44(s0)
  add a4,a5,a4
  lw a5,-24(s0)
  slli a5,a5,2
  add a5,a4,a5
  sw zero,0(a5)
  lw a5,-24(s0)
  addi a5,a5,1
  sw a5,-24(s0)
.L13:
  lw a4,-24(s0)
  li a5,2
  ble a4,a5,.L14
  lw a5,-20(s0)
  addi a5,a5,1
  sw a5,-20(s0)
.L12:
  lw a4,-20(s0)
  li a5,2
  ble a4,a5,.L15
  sw zero,-20(s0)
  j .L16
.L21:
  sw zero,-24(s0)
  j .L17
.L20:
  sw zero,-28(s0)
  j .L18
.L19:
  lw a4,-20(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  slli a5,a5,2
  mv a4,a5
  lw a5,-36(s0)
  add a4,a5,a4
  lw a5,-28(s0)
  slli a5,a5,2
  add a5,a4,a5
  lw a3,0(a5)
  lw a4,-28(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  slli a5,a5,2
  mv a4,a5
  lw a5,-40(s0)
  add a4,a5,a4
  lw a5,-24(s0)
  slli a5,a5,2
  add a5,a4,a5
  lw a5,0(a5)
  mv a1,a5
  mv a0,a3
  call multiply
  mv a1,a0
  lw a4,-20(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  slli a5,a5,2
  mv a4,a5
  lw a5,-44(s0)
  add a4,a5,a4
  lw a5,-24(s0)
  slli a5,a5,2
  add a5,a4,a5
  lw a2,0(a5)
  lw a4,-20(s0)
  mv a5,a4
  slli a5,a5,1
  add a5,a5,a4
  slli a5,a5,2
  mv a4,a5
  lw a5,-44(s0)
  add a3,a5,a4
  add a4,a1,a2
  lw a5,-24(s0)
  slli a5,a5,2
  add a5,a3,a5
  sw a4,0(a5)
  lw a5,-28(s0)
  addi a5,a5,1
  sw a5,-28(s0)
.L18:
  lw a4,-28(s0)
  li a5,2
  ble a4,a5,.L19
  lw a5,-24(s0)
  addi a5,a5,1
  sw a5,-24(s0)
.L17:
  lw a4,-24(s0)
  li a5,2
  ble a4,a5,.L20
  lw a5,-20(s0)
  addi a5,a5,1
  sw a5,-20(s0)
.L16:
  lw a4,-20(s0)
  li a5,2
  ble a4,a5,.L21
  nop
  lw ra,44(sp)
  lw s0,40(sp)
  addi sp,sp,48
  jr ra
