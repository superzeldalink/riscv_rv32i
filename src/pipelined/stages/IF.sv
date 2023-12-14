module IF (
  input         clk, reset_n, enable,
  // input         pc_sel_i  ,
  input  [31:0] alu_out_i ,
  input  [31:0] PC_ID_i, PC_EX_i,
  input  [31:0] inst_EX_i ,
  input         branch_taken,
  output [31:0] PC_o      ,
  output [31:0] instr_o   ,
  output        br_flush
);

  reg  [31:0] PC     ;
  wire [31:0] next_pc;

  branch_prediction branch_prediction (
    .clk       (clk       ),
    .reset_n   (reset_n   ),
    .PC_i      (PC        ),
    .PC_EX_i   (PC_EX_i   ),
    .PC_ID_i   (PC_ID_i   ),
    .br_PC     (alu_out_i ),
    .inst_IF_i (instr_o   ),
    .inst_EX_i (inst_EX_i ),
    .stall     (1'b0   ),
    .branch_taken(branch_taken),
    .next_pc   (next_pc   ),
    .br_flush  (br_flush  )
  );

  inst_mem #(.DEPTH(IMEM_DEPTH)) IMEM (
    // .clk       (clk     ),
    // .reset_n   (reset_n ),
    .addr_i    (PC[12:0]),
    .data_out_o(instr_o )
  );

  assign PC_o = PC;

  always_ff @( posedge clk or negedge reset_n ) begin
    if(~reset_n) begin
      PC <= 32'd0;
    end else begin
      if(enable) begin
        PC <= next_pc;
      end else begin
        PC <= PC;
      end
    end
  end

endmodule
