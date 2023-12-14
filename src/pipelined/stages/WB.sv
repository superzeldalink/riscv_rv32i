module WB (
  input  [31:0] pc_plus_four_i,
  input  [31:0] alu_i         ,
  input  [31:0] mem_i         ,
  input  [ 1:0] WB_sel_i         ,
  output [31:0] dataW_o
);

  assign dataW_o = (WB_sel_i == 2'b01) ? alu_i : (WB_sel_i == 2'b10) ? pc_plus_four_i : mem_i;

endmodule
