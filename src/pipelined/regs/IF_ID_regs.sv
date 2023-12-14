module IF_ID_regs (
  input             clk, reset_n, enable, flush,
  input      [31:0] PC_i, inst_i,
  output reg [31:0] PC_o, inst_o
);

  always_ff @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      PC_o   <= 32'd0;
      inst_o <= 32'd0;
    end else if(enable & flush) begin
      PC_o   <= 32'd0;
      inst_o <= 32'd0;
    end else if(enable) begin
      PC_o   <= PC_i;
      inst_o <= inst_i;
    end
  end

endmodule
