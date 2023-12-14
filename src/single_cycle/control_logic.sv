// verilator lint_off UNUSEDSIGNAL
module control_logic (
  input  [31:0] inst_i     ,
  input         BrEq, BrLT ,
  output [ 4:0] imm_sel_o  ,
  output [ 3:0] alu_sel_o  ,
  output        pc_sel_o, regWEn_o, BrUn_o, b_sel_o, a_sel_o, memRW_o,
  output [ 1:0] wb_sel_o   ,
  output [ 2:0] ld_st_sel_o
);

  wire [4:0] opcode = inst_i[6:2]  ;
  wire [2:0] funct3 = inst_i[14:12];
  wire       funct7 = inst_i[30]   ;
  wire branchTrue;

  wire Rtype, Itype, Stype, Btype, Jtype, JItype, Utype, Ltype; //, Mtype;

  assign Rtype  = (opcode == 5'b01100);
  assign Itype  = ({opcode[4:3], opcode[1:0]} == 4'b0000);
  assign Stype  = (opcode == 5'b01000);
  assign Btype  = (opcode == 5'b11000);
  assign Jtype  = (opcode == 5'b11011);                      // jal
  assign Utype  = ({opcode[4], opcode[2:0]} == 4'b0101);     // lui, auipc
  assign JItype = (opcode == 5'b11001);                      // jalr
  assign Ltype  = ~(|opcode);                                // opcode = 00000 loads (self defined)

  // assign Mtype = Rtype & inst_i[25];

  assign branchTrue = (funct3 == 3'b000 & BrEq) | (funct3 == 3'b001 & ~BrEq) | ({funct3[2], funct3[0]} == 2'b10 & BrLT) | ({funct3[2], funct3[0]} == 2'b11 & ~BrLT);

  assign pc_sel_o  = Jtype | JItype | (Btype & branchTrue);
  assign imm_sel_o = {Jtype, Utype, Btype, Stype, Itype | JItype};
  assign BrUn_o    = funct3[1];
  assign a_sel_o   = Btype | Jtype | Utype;
  assign b_sel_o   = ~Rtype;
  assign memRW_o   = Stype;
  assign regWEn_o  = ~Btype & ~Stype;
  assign wb_sel_o  = Ltype ? 2'b00 : (Jtype | JItype) ? 2'b10 : 2'b01;

  assign ld_st_sel_o = funct3;

  assign alu_sel_o = (Rtype) ? {funct7, funct3} :
    ((Itype & ~Ltype) ? ((funct3 == 3'b101) ? {funct7, funct3} : {1'b0, funct3}) :
      ((opcode == 5'b01101) ? 4'b1001 : 4'b0000));

endmodule

// verilator lint_on UNUSEDSIGNAL
