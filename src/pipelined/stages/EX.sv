module EX (
  input  [ 3:0] alu_sel_i          ,
  input  [31:0] PC_i               ,
  input  [31:0] imm_i              ,
  input         BrUn_i             ,
  input         A_sel, B_sel       ,
  input  [31:0] rs1_data, rs2_data ,
  input  [ 1:0] forward_sel_A_i, forward_sel_B_i,
  input         pc_plus_four_selA_i, pc_plus_four_selB_i,
  input  [31:0] pc_plus_four_MEM_i, pc_plus_four_WB_i,
  input  [31:0] alu_out_MEM_i, dataW_WB,
  input  [31:0] inst_EX_i          ,
  output [31:0] forwardB_o         ,
  output [31:0] alu_out_o          ,
  output [31:0] pc_plus_four_o     ,
  output        branch_taken
);

  assign pc_plus_four_o = PC_i + 32'd4;

  wire [31:0] inA, inB;
  wire [31:0] forwardA, forwardB;

  wire [31:0] pc_plus_fourA, pc_plus_fourB;
  assign pc_plus_fourA = pc_plus_four_selA_i ? pc_plus_four_WB_i : pc_plus_four_MEM_i;
  assign pc_plus_fourB = pc_plus_four_selB_i ? pc_plus_four_WB_i : pc_plus_four_MEM_i;

  wire BrEq, BrLT;

  assign forwardA = (forward_sel_A_i == 2'b11) ? pc_plus_fourA : (forward_sel_A_i == 2'b10) ? alu_out_MEM_i : (forward_sel_A_i == 2'b01) ? dataW_WB : rs1_data;
  assign forwardB = (forward_sel_B_i == 2'b11) ? pc_plus_fourB : (forward_sel_B_i == 2'b10) ? alu_out_MEM_i : (forward_sel_B_i == 2'b01) ? dataW_WB : rs2_data;

  assign inA = A_sel ? PC_i : forwardA;
  assign inB = B_sel ? imm_i : forwardB;

  wire [2:0] funct3 = inst_EX_i[14:12];
  wire       Btype, Jtype;
  assign Btype        = (inst_EX_i[6:2] == 5'b11000);
  assign Jtype        = (inst_EX_i[6:4] == 3'b110) & inst_EX_i[2];                      // jal, jalr
  assign branch_taken = Jtype | (Btype & ((funct3 == 3'b000 & BrEq) | (funct3 == 3'b001 & ~BrEq) | ({funct3[2], funct3[0]} == 2'b10 & BrLT) | ({funct3[2], funct3[0]} == 2'b11 & ~BrLT)));

  alu alu_module (
    .inA (inA      ),
    .inB (inB      ),
    .sel (alu_sel_i),
    .data(alu_out_o)
  );

  brcomp brcomp_module (
    .rs1_data   (forwardA),
    .rs2_data   (forwardB),
    .br_unsigned(BrUn_i  ),
    .br_less    (BrLT    ),
    .br_equal   (BrEq    )
  );

  assign forwardB_o = forwardB;
endmodule
