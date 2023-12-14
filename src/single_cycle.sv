`include "params.vh"

module single_cycle (
  input         clk_i, rst_ni,
  input  [31:0] io_sw_i, io_keys_i,
  output [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o,
  output [31:0] io_lcd_o ,
  output [31:0] io_ledr_o,
  output [31:0] io_ledg_o,
  output [31:0] PC_debug
);

reg [31:0] PC;
wire [31:0] pc_plus_four, pc_new;

wire [31:0] inst_w, alu_out_w, dataW_w, imm_w;
reg  [31:0] mem_w      ;
wire        pc_sel_w   ;
wire [ 2:0] ld_st_sel_w;
wire [31:0] dataR1_w, dataR2_w;
wire        BrUn_w, BrLT_w, BrEq_w;
wire        memRW_w, a_sel_w, b_sel_w, regWEn_w;
wire [ 3:0] alu_sel_w  ;
wire [ 4:0] imm_sel_w  ;
wire [ 1:0] wb_sel_w   ;

wire [31:0] alu_inA_w, alu_inB_w;

assign alu_inA_w = a_sel_w ? PC : dataR1_w;
assign alu_inB_w = b_sel_w ? imm_w : dataR2_w;

assign pc_plus_four = PC + 32'd4;
assign pc_new = pc_sel_w ? alu_out_w : pc_plus_four;

assign dataW_w = (wb_sel_w == 2'b01) ? alu_out_w : (wb_sel_w == 2'b10) ? pc_plus_four : mem_w;

assign PC_debug = PC;

inst_mem #(.DEPTH(IMEM_DEPTH)) IMEM (
  .addr_i    (PC[12:0]),
  .data_out_o(inst_w  )
);

RegFile RegFile (
  .clk_i   (clk_i        ),
  .reset_n (rst_ni       ),
  .rsW_i   (inst_w[11:7] ),
  .rsR1_i  (inst_w[19:15]),
  .rsR2_i  (inst_w[24:20]),
  .dataW_i (dataW_w      ),
  .regWEn_i(regWEn_w     ),
  .dataR1_o(dataR1_w     ),
  .dataR2_o(dataR2_w     )
);

brcomp BrComp (
  .rs1_data   (dataR1_w),
  .rs2_data   (dataR2_w),
  .br_unsigned(BrUn_w  ),
  .br_less    (BrLT_w  ),
  .br_equal   (BrEq_w  )
);

control_logic CtrlLogic (
  .inst_i     (inst_w     ),
  .BrEq       (BrEq_w     ),
  .BrLT       (BrLT_w     ),
  .imm_sel_o  (imm_sel_w  ),
  .alu_sel_o  (alu_sel_w  ),
  .pc_sel_o   (pc_sel_w   ),
  .regWEn_o   (regWEn_w   ),
  .BrUn_o     (BrUn_w     ),
  .a_sel_o    (a_sel_w    ),
  .b_sel_o    (b_sel_w    ),
  .memRW_o    (memRW_w    ),
  .wb_sel_o   (wb_sel_w   ),
  .ld_st_sel_o(ld_st_sel_w)
);

immgen immgen (
  .instr  (inst_w[31:7]),
  .imm_sel(imm_sel_w   ),
  .imm    (imm_w       )
);

alu alu (
  .inA (alu_inA_w),
  .inB (alu_inB_w),
  .sel (alu_sel_w),
  .data(alu_out_w)
);

lsu lsu (
  .clk        (clk_i          ),
  .reset_n    (rst_ni         ),
  .addr_i     (alu_out_w[11:0]),
  .st_data_i  (dataR2_w       ),
  .st_en_i    (memRW_w        ),
  .io_sw_i    (io_sw_i        ),
  .io_keys_i  (io_keys_i      ),
  .ld_st_sel_i(ld_st_sel_w    ),
  .ld_data_o  (mem_w          ),
  .io_lcd_o   (io_lcd_o       ),
  .io_ledg_o  (io_ledg_o      ),
  .io_ledr_o  (io_ledr_o      ),
  .io_hex0_o  (io_hex0_o      ),
  .io_hex1_o  (io_hex1_o      ),
  .io_hex2_o  (io_hex2_o      ),
  .io_hex3_o  (io_hex3_o      ),
  .io_hex4_o  (io_hex4_o      ),
  .io_hex5_o  (io_hex5_o      ),
  .io_hex6_o  (io_hex6_o      ),
  .io_hex7_o  (io_hex7_o      )
);

always_ff @( posedge clk_i or negedge rst_ni ) begin
  if(~rst_ni) begin
    PC <= 32'd0;
  end else begin
    PC <= pc_new;
  end
end
endmodule
