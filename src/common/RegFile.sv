module RegFile (
  input         clk_i   , // Clock input
  input         reset_n ,
  input  [ 4:0] rsW_i, rsR1_i, rsR2_i, // Address input
  input  [31:0] dataW_i , // Data input for writing
  input         regWEn_i,
  output [31:0] dataR1_o, dataR2_o  // Data output
);

  reg [31:0] RegArray[1:31]; // 8-bit memory array

  always @(negedge clk_i or negedge reset_n) begin
    if(~reset_n) begin
      for (int i = 1; i <= 31; i = i + 1) begin
        RegArray[i] <= 32'b0;
      end
      RegArray[2] <= DMEM_DEPTH;
    end else if(regWEn_i & (|rsW_i)) begin
      RegArray[rsW_i] <= dataW_i;
    end
  end

  assign dataR1_o = |rsR1_i ? RegArray[rsR1_i] : 32'b0;
  assign dataR2_o = |rsR2_i ? RegArray[rsR2_i] : 32'b0;

endmodule
