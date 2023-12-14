`include "params.vh"

module pipelined (
  input         clk_i, rst_ni,
  input  [31:0] io_sw_i, io_keys_i,
  output [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o,
  output [31:0] io_lcd_o ,
  output [31:0] io_ledr_o,
  output [31:0] io_ledg_o,
  output [31:0] PC_debug
);

assign PC_debug = PC_ID_i;

// IF/ID
wire [31:0] PC_IF_o, inst_IF_o;
wire [31:0] PC_ID_i, inst_ID_i;

// ID/EX
wire [31:0] dataR1_ID_o, dataR2_ID_o;
wire [31:0] imm_ID_o      ;
wire        a_sel_ID_o, b_sel_ID_o;
wire        BrUn_ID_o     ;
wire [ 3:0] alu_sel_ID_o  ;
wire        regWEn_ID_o   ;
wire        memRW_ID_o    ;
wire [ 1:0] wb_sel_ID_o   ;
wire [ 2:0] ld_st_sel_ID_o;

wire [31:0] PC_EX_i, inst_EX_i;
wire [31:0] dataR1_EX_i, dataR2_EX_i;
wire [31:0] imm_EX_i      ;
wire        a_sel_EX_i, b_sel_EX_i;
wire        BrUn_EX_i     ;
wire [ 3:0] alu_sel_EX_i  ;
wire        regWEn_EX_i   ;
wire        memRW_EX_i    ;
wire [ 1:0] wb_sel_EX_i   ;
wire [ 2:0] ld_st_sel_EX_i;

// EX/MEM
wire [31:0] alu_out_EX_o     ;
wire [31:0] pc_plus_four_EX_o;
wire [31:0] forwardB_EX_o;

wire [31:0] alu_out_MEM_i     ;
wire [31:0] PC_MEM_i, inst_MEM_i;
wire [31:0] dataR2_MEM_i      ;
wire        regWEn_MEM_i      ;
wire        memRW_MEM_i       ;
wire [ 1:0] wb_sel_MEM_i      ;
wire [ 2:0] ld_st_sel_MEM_i   ;
wire [31:0] pc_plus_four_MEM_i;

// MEM/WB
wire [31:0] mem_MEM_o;

wire [31:0] pc_plus_four_WB_i, inst_WB_i;
wire [31:0] alu_out_WB_i     ;
wire        regWEn_WB_i      ;
wire [31:0] mem_WB_i         ;
wire [ 1:0] wb_sel_WB_i      ;

// WB
wire [31:0] dataW_WB;

// Forward
wire [1:0] forward_sel_A_w, forward_sel_B_w;
wire       pc_plus_four_selA_w, pc_plus_four_selB_w;
wire       pc_en, IF_ID_en, ID_EX_flush;

// Branch
wire branch_taken;
wire br_flush    ;

IF IF (
  .clk         (clk_i       ),
  .reset_n     (rst_ni      ),
  .enable      (pc_en       ),
  .alu_out_i   (alu_out_EX_o),
  .PC_ID_i     (PC_ID_i     ),
  .PC_EX_i     (PC_EX_i     ),
  .inst_EX_i   (inst_EX_i   ),
  .branch_taken(branch_taken),
  .PC_o        (PC_IF_o     ),
  .instr_o     (inst_IF_o   ),
  .br_flush    (br_flush    )
);

IF_ID_regs IF_ID_regs (
  .clk    (clk_i    ),
  .reset_n(rst_ni   ),
  .PC_i   (PC_IF_o  ),
  .PC_o   (PC_ID_i  ),
  .inst_i (inst_IF_o),
  .inst_o (inst_ID_i),
  .enable (IF_ID_en ),
  .flush  (br_flush )
);

ID ID (
  .clk_i      (clk_i          ),
  .reset_n    (rst_ni         ),
  .inst_i     (inst_ID_i      ),
  .dataW_i    (dataW_WB       ),
  .dataR1_o   (dataR1_ID_o    ),
  .dataR2_o   (dataR2_ID_o    ),
  .imm_o      (imm_ID_o       ),
  .regWEn_WB_i(regWEn_WB_i    ),
  .BrUn_o     (BrUn_ID_o      ),
  .a_sel_o    (a_sel_ID_o     ),
  .b_sel_o    (b_sel_ID_o     ),
  .alu_sel_o  (alu_sel_ID_o   ),
  .regWEn_o   (regWEn_ID_o    ),
  .memRW_o    (memRW_ID_o     ),
  .wb_sel_o   (wb_sel_ID_o    ),
  .ld_st_sel_o(ld_st_sel_ID_o ),
  .rsW_i      (inst_WB_i[11:7])
);

ID_EX_regs ID_EX_regs (
  .clk        (clk_i                 ),
  .reset_n    (rst_ni                ),
  .PC_i       (PC_ID_i               ),
  .inst_i     (inst_ID_i             ),
  .dataR1_i   (dataR1_ID_o           ),
  .dataR2_i   (dataR2_ID_o           ),
  .imm_i      (imm_ID_o              ),
  .a_sel_i    (a_sel_ID_o            ),
  .b_sel_i    (b_sel_ID_o            ),
  .BrUn_i     (BrUn_ID_o             ),
  .alu_sel_i  (alu_sel_ID_o          ),
  .regWEn_i   (regWEn_ID_o           ),
  .memRW_i    (memRW_ID_o            ),
  .wb_sel_i   (wb_sel_ID_o           ),
  .ld_st_sel_i(ld_st_sel_ID_o        ),
  .PC_o       (PC_EX_i               ),
  .inst_o     (inst_EX_i             ),
  .dataR1_o   (dataR1_EX_i           ),
  .dataR2_o   (dataR2_EX_i           ),
  .imm_o      (imm_EX_i              ),
  .a_sel_o    (a_sel_EX_i            ),
  .b_sel_o    (b_sel_EX_i            ),
  .BrUn_o     (BrUn_EX_i             ),
  .alu_sel_o  (alu_sel_EX_i          ),
  .regWEn_o   (regWEn_EX_i           ),
  .memRW_o    (memRW_EX_i            ),
  .wb_sel_o   (wb_sel_EX_i           ),
  .ld_st_sel_o(ld_st_sel_EX_i        ),
  .flush      (br_flush | ID_EX_flush)
);

EX EX (
  .alu_sel_i          (alu_sel_EX_i       ),
  .PC_i               (PC_EX_i            ),
  .rs1_data           (dataR1_EX_i        ),
  .rs2_data           (dataR2_EX_i        ),
  .imm_i              (imm_EX_i           ),
  .BrUn_i             (BrUn_EX_i          ),
  .A_sel              (a_sel_EX_i         ),
  .B_sel              (b_sel_EX_i         ),
  .inst_EX_i          (inst_EX_i          ),
  .forward_sel_A_i    (forward_sel_A_w    ),
  .forward_sel_B_i    (forward_sel_B_w    ),
  .pc_plus_four_selA_i(pc_plus_four_selA_w),
  .pc_plus_four_selB_i(pc_plus_four_selB_w),
  .pc_plus_four_MEM_i (pc_plus_four_MEM_i ),
  .pc_plus_four_WB_i  (pc_plus_four_WB_i  ),
  .forwardB_o         (forwardB_EX_o      ),
  .alu_out_o          (alu_out_EX_o       ),
  .alu_out_MEM_i      (alu_out_MEM_i      ),
  .dataW_WB           (dataW_WB           ),
  .branch_taken       (branch_taken       ),
  .pc_plus_four_o     (pc_plus_four_EX_o  )
);

EX_MEM_regs EX_MEM_regs (
  .clk           (clk_i             ),
  .reset_n       (rst_ni            ),
  .PC_i          (PC_EX_i           ),
  .inst_i        (inst_EX_i         ),
  .alu_out_i     (alu_out_EX_o      ),
  .dataR2_i      (forwardB_EX_o     ),
  .regWEn_i      (regWEn_EX_i       ),
  .memRW_i       (memRW_EX_i        ),
  .wb_sel_i      (wb_sel_EX_i       ),
  .ld_st_sel_i   (ld_st_sel_EX_i    ),
  .pc_plus_four_i(pc_plus_four_EX_o ),
  .alu_out_o     (alu_out_MEM_i     ),
  .dataR2_o      (dataR2_MEM_i      ),
  .regWEn_o      (regWEn_MEM_i      ),
  .memRW_o       (memRW_MEM_i       ),
  .wb_sel_o      (wb_sel_MEM_i      ),
  .ld_st_sel_o   (ld_st_sel_MEM_i   ),
  .PC_o          (PC_MEM_i          ),
  .inst_o        (inst_MEM_i        ),
  .pc_plus_four_o(pc_plus_four_MEM_i)
);

MEM MEM (
  .clk        (clk_i          ),
  .reset_n    (rst_ni         ),
  .addr_i     (alu_out_MEM_i  ),
  .rs2_i      (dataR2_MEM_i   ),
  .st_en_i    (memRW_MEM_i    ),
  .ld_st_sel_i(ld_st_sel_MEM_i),
  .PC_i       (PC_MEM_i       ),
  .io_sw_i    (io_sw_i        ),
  .io_keys_i  (io_keys_i      ),
  .ld_data_o  (mem_MEM_o      ),
  .io_ledr_o  (io_ledr_o      ),
  .io_lcd_o   (io_lcd_o       ),
  .io_ledg_o  (io_ledg_o      ),
  .io_hex0_o  (io_hex0_o      ),
  .io_hex1_o  (io_hex1_o      ),
  .io_hex2_o  (io_hex2_o      ),
  .io_hex3_o  (io_hex3_o      ),
  .io_hex4_o  (io_hex4_o      ),
  .io_hex5_o  (io_hex5_o      ),
  .io_hex6_o  (io_hex6_o      ),
  .io_hex7_o  (io_hex7_o      )
);

MEM_WB_regs MEM_WB_regs (
  .clk           (clk_i             ),
  .reset_n       (rst_ni            ),
  .mem_i         (mem_MEM_o         ),
  .pc_plus_four_i(pc_plus_four_MEM_i),
  .inst_i        (inst_MEM_i        ),
  .alu_out_i     (alu_out_MEM_i     ),
  .wb_sel_i      (wb_sel_MEM_i      ),
  .regWEn_i      (regWEn_MEM_i      ),
  .mem_o         (mem_WB_i          ),
  .pc_plus_four_o(pc_plus_four_WB_i ),
  .alu_out_o     (alu_out_WB_i      ),
  .wb_sel_o      (wb_sel_WB_i       ),
  .regWEn_o      (regWEn_WB_i       ),
  .inst_o        (inst_WB_i         )
);

WB WB (
  .pc_plus_four_i(pc_plus_four_WB_i),
  .alu_i         (alu_out_WB_i     ),
  .mem_i         (mem_WB_i         ),
  .WB_sel_i      (wb_sel_WB_i      ),
  .dataW_o       (dataW_WB         )
);

forwarding_unit forwarding_unit (
  .inst_EX_i        (inst_EX_i          ),
  .inst_MEM_i       (inst_MEM_i         ),
  .inst_WB_i        (inst_WB_i          ),
  .regWEn_MEM_i     (regWEn_MEM_i       ),
  .regWEn_WB_i      (regWEn_WB_i        ),
  .forward_sel_A_o  (forward_sel_A_w    ),
  .forward_sel_B_o  (forward_sel_B_w    ),
  .pc_plus_four_selA(pc_plus_four_selA_w),
  .pc_plus_four_selB(pc_plus_four_selB_w)
);

hazard_detection hazard_detection (
  .inst_ID_i  (inst_ID_i  ),
  .inst_EX_i  (inst_EX_i  ),
  .ID_EX_flush(ID_EX_flush),
  .pc_en      (pc_en      ),
  .IF_ID_en   (IF_ID_en   )
);

endmodule
