module ID (
  input         clk_i, reset_n,
  input  [31:0] inst_i     ,
  input  [ 4:0] rsW_i      ,
  input  [31:0] dataW_i    ,
  input         regWEn_WB_i,
  output        a_sel_o, b_sel_o,
  output [ 3:0] alu_sel_o  ,
  output        regWEn_o   ,
  output        BrUn_o     ,
  output        memRW_o    ,
  output [ 1:0] wb_sel_o   ,
  output [ 2:0] ld_st_sel_o,
  output [31:0] dataR1_o, dataR2_o,
  output [31:0] imm_o
);

  wire [4:0] imm_sel_w;

  RegFile RegFile_module (
    .clk_i   (clk_i        ), // Clock input
    .reset_n (reset_n      ),
    .rsW_i   (rsW_i        ),
    .rsR1_i  (inst_i[19:15]),
    .rsR2_i  (inst_i[24:20]), // Address input
    .dataW_i (dataW_i      ), // Data input for writing
    .regWEn_i(regWEn_WB_i  ),
    .dataR1_o(dataR1_o     ),
    .dataR2_o(dataR2_o     )  // Data output
  );

  immgen immgen_module (
    .instr  (inst_i[31:7]),
    .imm_sel(imm_sel_w   ),
    .imm    (imm_o       )
  );

  control_logic control_logic_module (
    .inst_i     (inst_i     ),
    .imm_sel_o  (imm_sel_w  ),
    .alu_sel_o  (alu_sel_o  ),
    .regWEn_o   (regWEn_o   ),
    .BrUn_o     (BrUn_o     ),
    .a_sel_o    (a_sel_o    ),
    .b_sel_o    (b_sel_o    ),
    .memRW_o    (memRW_o    ),
    .wb_sel_o   (wb_sel_o   ),
    .ld_st_sel_o(ld_st_sel_o)
  );
endmodule
