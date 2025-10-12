from vcdvcd import VCDVCD

# Load the VCD file
vcd = VCDVCD('wave.vcd')

# Variables to track signal states
clk_signal = vcd['TOP.clk_i']
is_br_EX = vcd['TOP.pipelined.IF.branch_prediction.is_br_EX']
is_jmp_EX = vcd['TOP.pipelined.IF.branch_prediction.is_jump_EX']
flush_signal = vcd['TOP.pipelined.IF.branch_prediction.br_flush']

count_missed = sum(1 for time, value in flush_signal.tv if (value == '1') and ((time,value) in is_br_EX.tv))
count_branch = sum(1 for time, value in is_br_EX.tv if value == '1')

print("MISS/ALL: ", count_missed, " / ", count_branch)

