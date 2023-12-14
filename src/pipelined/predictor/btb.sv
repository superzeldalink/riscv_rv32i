module btb (
  input         clk      ,
  input  [ 9:0] addr_rd_i, addr_wr_i,
  input  [31:0] pc_i     ,
  input  [19:0] tag_i    ,
  input         enable   ,
  // input         taken    ,
  output [31:0] pc_o     ,
  output [19:0] tag_o    ,
  output        used_o
);

  reg  [50:0] buffer[1024];
  wire [29:0] pc          ;
  assign pc_o = {pc, 2'd0};

  always_ff @(posedge clk) begin
    if(enable) begin
      buffer[addr_wr_i] <= {1'b1, tag_i, pc_i[31:2]};
    end
  end

  assign {used_o, tag_o, pc} = buffer[addr_rd_i];

endmodule
