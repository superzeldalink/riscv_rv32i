module EX_MEM_regs (
  input             clk, reset_n  ,
  input      [31:0] PC_i, inst_i  ,
  input      [31:0] alu_out_i, dataR2_i,
  input             regWEn_i      ,
  input             memRW_i       ,
  input      [ 1:0] wb_sel_i      ,
  input      [ 2:0] ld_st_sel_i   ,
  input      [31:0] pc_plus_four_i,
  output reg [31:0] PC_o, inst_o  ,
  output reg [31:0] alu_out_o, dataR2_o,
  output reg        regWEn_o      ,
  output reg        memRW_o       ,
  output reg [ 1:0] wb_sel_o      ,
  output reg [ 2:0] ld_st_sel_o   ,
  output reg [31:0] pc_plus_four_o
);

  always_ff @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      PC_o           <= 32'd0;
      inst_o         <= 32'd0;
      alu_out_o      <= 32'd0;
      regWEn_o       <= 1'd0;
      memRW_o        <= 1'd0;
      wb_sel_o       <= 2'd0;
      ld_st_sel_o    <= 3'd0;
      dataR2_o       <= 32'd0;
      pc_plus_four_o <= 32'd0;
    end else begin
      PC_o           <= PC_i;
      inst_o         <= inst_i;
      alu_out_o      <= alu_out_i;
      regWEn_o       <= regWEn_i;
      memRW_o        <= memRW_i;
      wb_sel_o       <= wb_sel_i;
      ld_st_sel_o    <= ld_st_sel_i;
      dataR2_o       <= dataR2_i;
      pc_plus_four_o <= pc_plus_four_i;
    end
  end

endmodule
