module forwarding_unit (
  input      [31:0] inst_EX_i, inst_MEM_i, inst_WB_i,
  input             regWEn_MEM_i, regWEn_WB_i,
  output reg [ 1:0] forward_sel_A_o, forward_sel_B_o,
  output reg        pc_plus_four_selA, pc_plus_four_selB
);

  wire [4:0] rs1_EX, rs2_EX, rsW_MEM, rsW_WB;

  assign rs1_EX  = inst_EX_i[19:15];
  assign rs2_EX  = inst_EX_i[24:20];
  assign rsW_MEM = inst_MEM_i[11:7];
  assign rsW_WB  = inst_WB_i[11:7];

  wire [4:0] opcode_MEM, opcode_WB;
  assign opcode_MEM = inst_MEM_i[6:2];
  assign opcode_WB  = inst_WB_i[6:2];

  wire is_jump_MEM, is_jump_WB;
  assign is_jump_MEM = (opcode_MEM == 5'b11011) | (opcode_MEM == 5'b11001);
  assign is_jump_WB  = (opcode_WB == 5'b11011) | (opcode_WB == 5'b11001);


  always_comb begin
    forward_sel_A_o   = 2'b00;
    forward_sel_B_o   = 2'b00;
    pc_plus_four_selA = 1'b0;
    pc_plus_four_selB = 1'b0;

    // A
    if(regWEn_MEM_i & (rsW_MEM != 5'd0) & (rsW_MEM == rs1_EX)) begin
      if(is_jump_MEM) begin
        forward_sel_A_o   = 2'b11;
        pc_plus_four_selA = 1'b0;
      end else begin
        forward_sel_A_o = 2'b10;
      end
    end else if(regWEn_WB_i & (rsW_WB != 5'd0) & (rsW_WB == rs1_EX)) begin
      if(is_jump_WB) begin
        forward_sel_A_o   = 2'b11;
        pc_plus_four_selA = 1'b1;
      end else begin
        forward_sel_A_o = 2'b01;
      end
    end

    // B
    if(regWEn_MEM_i & (rsW_MEM != 5'd0) & (rsW_MEM == rs2_EX)) begin
      if(is_jump_MEM) begin
        forward_sel_B_o   = 2'b11;
        pc_plus_four_selB = 1'b0;
      end else begin
        forward_sel_B_o = 2'b10;
      end
    end else if(regWEn_WB_i & (rsW_WB != 5'd0) & (rsW_WB == rs2_EX)) begin
      if(is_jump_WB) begin
        forward_sel_B_o   = 2'b11;
        pc_plus_four_selB = 1'b1;
      end else begin
        forward_sel_B_o = 2'b01;
      end
    end
  end

endmodule

// wire A1, B1, A2, B2, C, D;

// assign A1 = regWEn_MEM_i & (rsW_MEM != 5'd0) & (rsW_MEM == rs1_EX);
// assign B1 = regWEn_WB_i & (rsW_WB != 5'd0) & (rsW_WB == rs1_EX);
// assign A2 = regWEn_MEM_i & (rsW_MEM != 5'd0) & (rsW_MEM == rs2_EX);
// assign B2 = regWEn_WB_i & (rsW_WB != 5'd0) & (rsW_WB == rs2_EX);
// assign C  = is_jump_MEM;
// assign D  = is_jump_WB;

// assign forward_sel_A_o[1] = (B1 & D) | A1;
// assign forward_sel_A_o[0] = (~A1 & B1) | (A1 & ~B1 & C) | (A1 & C & D);
// assign forward_sel_B_o[1] = (B2 & D) | A2;
// assign forward_sel_B_o[0] = (~A2 & B2) | (A2 & ~B2 & C) | (A2 & C & D);
// assign pc_plus_four_selA  = ~A1;
// assign pc_plus_four_selB  = ~A2;
