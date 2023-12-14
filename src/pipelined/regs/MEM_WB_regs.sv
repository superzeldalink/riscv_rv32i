module MEM_WB_regs (
  input             clk, reset_n  ,
  input      [31:0] mem_i         ,
  input      [31:0] pc_plus_four_i, inst_i,
  input      [31:0] alu_out_i     ,
  input      [ 1:0] wb_sel_i      ,
  input             regWEn_i      ,
  output reg [31:0] mem_o         ,
  output reg [31:0] pc_plus_four_o, inst_o,
  output reg [31:0] alu_out_o     ,
  output reg [ 1:0] wb_sel_o      ,
  output reg        regWEn_o
);

  always_ff @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      mem_o          <= 32'd0;
      regWEn_o       <= 1'd0;
      pc_plus_four_o <= 32'd0;
      alu_out_o      <= 32'd0;
      wb_sel_o       <= 2'd0;
      inst_o         <= 32'd0;
    end else begin
      mem_o          <= mem_i;
      regWEn_o       <= regWEn_i;
      pc_plus_four_o <= pc_plus_four_i;
      alu_out_o      <= alu_out_i;
      wb_sel_o       <= wb_sel_i;
      inst_o         <= inst_i;
    end
  end

endmodule
