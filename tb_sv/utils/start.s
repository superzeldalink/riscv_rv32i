    .section .text._start
    .globl _start
_start:
    la sp, _stack_top    # initialize stack pointer
    call main            # jump to C main
1:  j 1b                 # hang if main returns
