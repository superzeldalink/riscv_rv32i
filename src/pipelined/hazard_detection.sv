// ID/EX. instr==ld & ID/EX. ==IF/ID.rs | | ID/EX.rt==IF/ID.rt)
// (ID_EX_MemRead && (ID_EX_rd !=0)) ? ((ID_EX_rd == IF_ID_RS1) || (ID_EX_rd == IF_ID_RS2)) : 0;


module hazard_detection (
  input      [31:0] inst_ID_i, inst_EX_i,
  output reg        ID_EX_flush ,
  output reg        pc_en, IF_ID_en
);

  wire [4:0] rs1_ID, rs2_ID, rsW_EX;
  wire [4:0] opcode_EX;
  wire       isload_EX;

  assign opcode_EX = inst_EX_i[6:2];
  assign isload_EX = ~(|opcode_EX);                                // opcode = 00000 loads (self defined)
  assign rs1_ID    = inst_ID_i[19:15];
  assign rs2_ID    = inst_ID_i[24:20];
  assign rsW_EX    = inst_EX_i[11:7];

  always_comb begin
    // if(regWEn_MEM_i & (rsW_MEM != 5'd0) & isload_EX & (rsW_MEM == rs1_EX | rsW_MEM == rs2_EX)) begin
    if(isload_EX & (rsW_EX != 5'd0) & (rsW_EX == rs1_ID | rsW_EX == rs2_ID)) begin
      ID_EX_flush = 1'b1;
      IF_ID_en    = 1'b0;
      pc_en       = 1'b0;
    end else begin
      ID_EX_flush = 1'b0;
      IF_ID_en    = 1'b1;
      pc_en       = 1'b1;
    end
  end

endmodule
