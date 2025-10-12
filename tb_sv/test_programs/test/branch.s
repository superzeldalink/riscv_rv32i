.text
addi x7, x0, 12
addi x3, x0, 23
addi x2, x0, 34
addi x1, x0, 45

beqz x0, test
add x2, x1, x3
add x2, x1, x3
add x2, x1, x3
add x2, x1, x3
add x2, x1, x3

test: 
add x5, x1, x2