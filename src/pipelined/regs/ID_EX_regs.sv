module ID_EX_regs (
  input             clk, reset_n, flush,
  input      [31:0] PC_i, inst_i,
  input      [31:0] dataR1_i, dataR2_i, imm_i,
  input             a_sel_i, b_sel_i,
  input             BrUn_i     ,
  input      [ 3:0] alu_sel_i  ,
  input             regWEn_i   ,
  input             memRW_i    ,
  input      [ 1:0] wb_sel_i   ,
  input      [ 2:0] ld_st_sel_i,
  output reg [31:0] PC_o, inst_o,
  output reg [31:0] dataR1_o, dataR2_o, imm_o,
  output reg        a_sel_o, b_sel_o,
  output reg        BrUn_o     ,
  output reg [ 3:0] alu_sel_o  ,
  output reg        regWEn_o   ,
  output reg        memRW_o    ,
  output reg [ 1:0] wb_sel_o   ,
  output reg [ 2:0] ld_st_sel_o
);

  always_ff @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      PC_o        <= 32'd0;
      inst_o      <= 32'd0;
      dataR1_o    <= 32'd0;
      dataR2_o    <= 32'd0;
      imm_o       <= 32'd0;
      a_sel_o     <= 1'd0;
      b_sel_o     <= 1'd0;
      BrUn_o      <= 1'd0;
      alu_sel_o   <= 4'd0;
      regWEn_o    <= 1'd0;
      memRW_o     <= 1'd0;
      wb_sel_o    <= 2'd0;
      ld_st_sel_o <= 3'd0;
    end else if(flush) begin
      PC_o        <= 32'd0;
      inst_o      <= 32'd0;
      dataR1_o    <= 32'd0;
      dataR2_o    <= 32'd0;
      imm_o       <= 32'd0;
      a_sel_o     <= 1'd0;
      b_sel_o     <= 1'd0;
      BrUn_o      <= 1'd0;
      alu_sel_o   <= 4'd0;
      regWEn_o    <= 1'd0;
      memRW_o     <= 1'd0;
      wb_sel_o    <= 2'd0;
      ld_st_sel_o <= 3'd0;
    end else begin
      PC_o        <= PC_i;
      inst_o      <= inst_i;
      dataR1_o    <= dataR1_i;
      dataR2_o    <= dataR2_i;
      imm_o       <= imm_i;
      a_sel_o     <= a_sel_i;
      b_sel_o     <= b_sel_i;
      BrUn_o      <= BrUn_i;
      alu_sel_o   <= alu_sel_i;
      regWEn_o    <= regWEn_i;
      memRW_o     <= memRW_i;
      wb_sel_o    <= wb_sel_i;
      ld_st_sel_o <= ld_st_sel_i;
    end
  end

endmodule
