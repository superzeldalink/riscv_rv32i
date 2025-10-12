	.file	"timer.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	li	a5,4096
	addi	a5,a5,-1904
	lbu	a4,-17(s0)
	sb	a4,0(a5)
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	putchar, .-putchar
	.align	2
	.globl	print_number
	.type	print_number, @function
print_number:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	bge	a5,zero,.L3
	li	a0,45
	call	putchar
	lw	a5,-36(s0)
	neg	a5,a5
	sw	a5,-36(s0)
.L3:
	lw	a5,-36(s0)
	bne	a5,zero,.L4
	li	a0,48
	call	putchar
	j	.L2
.L4:
	sw	zero,-20(s0)
	j	.L6
.L7:
	lw	a5,-36(s0)
	li	a1,10
	mv	a0,a5
	call	__modsi3
	mv	a5,a0
	andi	a4,a5,0xff
	lw	a5,-20(s0)
	addi	a3,a5,1
	sw	a3,-20(s0)
	addi	a4,a4,48
	andi	a4,a4,0xff
	addi	a5,a5,-16
	add	a5,a5,s0
	sb	a4,-16(a5)
	lw	a5,-36(s0)
	li	a1,10
	mv	a0,a5
	call	__divsi3
	mv	a5,a0
	sw	a5,-36(s0)
.L6:
	lw	a5,-36(s0)
	bgt	a5,zero,.L7
	j	.L8
.L9:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-16(a5)
	mv	a0,a5
	call	putchar
.L8:
	lw	a5,-20(s0)
	bgt	a5,zero,.L9
.L2:
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	print_number, .-print_number
	.align	2
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-96
	sw	ra,60(sp)
	sw	s0,56(sp)
	addi	s0,sp,64
	sw	a0,-52(s0)
	sw	a1,4(s0)
	sw	a2,8(s0)
	sw	a3,12(s0)
	sw	a4,16(s0)
	sw	a5,20(s0)
	sw	a6,24(s0)
	sw	a7,28(s0)
	addi	a5,s0,32
	sw	a5,-56(s0)
	lw	a5,-56(s0)
	addi	a5,a5,-28
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	j	.L11
.L26:
	lw	a5,-52(s0)
	lbu	a4,0(a5)
	li	a5,37
	bne	a4,a5,.L12
	lw	a5,-52(s0)
	addi	a5,a5,1
	sw	a5,-52(s0)
	lw	a5,-52(s0)
	lbu	a5,0(a5)
	li	a4,115
	beq	a5,a4,.L13
	li	a4,115
	bgt	a5,a4,.L14
	li	a4,100
	beq	a5,a4,.L15
	li	a4,100
	bgt	a5,a4,.L14
	li	a4,37
	beq	a5,a4,.L16
	li	a4,99
	bne	a5,a4,.L14
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a5,0(a5)
	sb	a5,-29(s0)
	lbu	a5,-29(s0)
	mv	a0,a5
	call	putchar
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L25
.L13:
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a5,0(a5)
	sw	a5,-24(s0)
	j	.L18
.L19:
	lw	a5,-24(s0)
	addi	a4,a5,1
	sw	a4,-24(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	putchar
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L18:
	lw	a5,-24(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L19
	j	.L25
.L15:
	lw	a5,-36(s0)
	addi	a4,a5,4
	sw	a4,-36(s0)
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a0,-28(s0)
	call	print_number
	lw	a5,-28(s0)
	bne	a5,zero,.L20
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L25
.L20:
	lw	a5,-28(s0)
	bge	a5,zero,.L23
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-28(s0)
	neg	a5,a5
	sw	a5,-28(s0)
	j	.L23
.L24:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-28(s0)
	li	a1,10
	mv	a0,a5
	call	__divsi3
	mv	a5,a0
	sw	a5,-28(s0)
.L23:
	lw	a5,-28(s0)
	bgt	a5,zero,.L24
	j	.L25
.L16:
	li	a0,37
	call	putchar
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
	j	.L25
.L14:
	li	a0,37
	call	putchar
	lw	a5,-52(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	putchar
	lw	a5,-20(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
	j	.L25
.L12:
	lw	a5,-52(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	putchar
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L25:
	lw	a5,-52(s0)
	addi	a5,a5,1
	sw	a5,-52(s0)
.L11:
	lw	a5,-52(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L26
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,60(sp)
	lw	s0,56(sp)
	addi	sp,sp,96
	jr	ra
	.size	printf, .-printf
	.section	.rodata
	.align	2
.LC0:
	.string	"Done: %d"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a5,4096
	addi	a5,a5,-1516
	sw	zero,0(a5)
	li	a5,4096
	addi	a5,a5,-1520
	li	a4,49152
	addi	a4,a4,848
	sw	a4,0(a5)
	li	a5,4096
	addi	a5,a5,-1904
	li	a4,1
	sw	a4,0(a5)
	li	a5,4096
	addi	a5,a5,-1512
	li	a4,1
	sw	a4,0(a5)
	j	.L29
.L30:
	li	a5,4096
	addi	a4,a5,-1504
	li	a5,4096
	addi	a5,a5,-1872
	lw	a4,0(a4)
	sw	a4,0(a5)
.L29:
	li	a5,4096
	addi	a5,a5,-1508
	lw	a5,0(a5)
	beq	a5,zero,.L30
	li	a5,4096
	addi	a5,a5,-1508
	sw	zero,0(a5)
	li	a5,4096
	addi	a5,a5,-1512
	sw	zero,0(a5)
	li	a5,4096
	addi	a5,a5,-1904
	li	a4,2
	sw	a4,0(a5)
	li	a5,4096
	addi	a5,a5,-1520
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
.L31:
	j	.L31
	.size	main, .-main
	.globl	__divsi3
	.globl	__modsi3
	.ident	"GCC: (g04696df0963) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
