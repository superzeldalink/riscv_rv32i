`ifdef TOURNAMENT_BIT
`define TOURNAMENT
`endif

module branch_prediction (
  input         clk, reset_n,
  input  [31:0] PC_i        ,
  input  [31:0] PC_ID_i, PC_EX_i, br_PC,
  input  [31:0] inst_EX_i, inst_IF_i,
  input         branch_taken,
  input         stall       ,
  output [31:0] next_pc     ,
  output        br_flush
);

  wire [19:0] PC_tag    ;
  wire [ 9:0] table_addr;

  wire [31:0] predicted_pc ;
  wire [19:0] predicted_tag;
  wire        hit          ;
  wire        used         ;
  wire        predict_taken;

  wire [31:0] expected_pc, predict_new_pc;
  wire        is_br_IF, is_br_EX, is_jump_IF, is_jump_EX;

  wire [19:0] PC_EX_i_tag  ;
  wire [ 9:0] table_addr_EX;

  assign PC_tag     = PC_i[31:12];
  assign table_addr = PC_i[11:2];

  assign hit = (PC_tag == predicted_tag);

  assign PC_EX_i_tag   = PC_EX_i[31:12];
  assign table_addr_EX = PC_EX_i[11:2];

  assign is_br_IF   = (inst_IF_i[6:2] == 5'b11000);
  assign is_br_EX   = (inst_EX_i[6:2] == 5'b11000);
  assign is_jump_IF = (inst_IF_i[6:2] == 5'b11011 | inst_IF_i[6:2] == 5'b11001);
  assign is_jump_EX = (inst_EX_i[6:2] == 5'b11011 | inst_EX_i[6:2] == 5'b11001);

  assign br_flush = (is_br_EX | is_jump_EX) & (PC_ID_i != expected_pc);

  assign expected_pc    = branch_taken ? br_PC : PC_EX_i + 4;
  assign predict_new_pc = (((is_br_IF & predict_taken) | is_jump_IF) & hit & used) ? predicted_pc : PC_i + 4;

  assign next_pc = br_flush ? expected_pc : predict_new_pc;

`ifdef ALWAYS_NOT_TAKEN
  assign predict_taken = 1'b0;
`elsif ALWAYS_TAKEN
  assign predict_taken = 1'b1;
`elsif GSHARE
  gshare #(.PATTERN_WIDTH(4), .WIDTH(2)) gshare (
    .clk          (clk          ),
    .reset_n      (reset_n      ),
    .enable       (is_br_EX     ),
    .stall        (stall        ),
    .pc_share_rd  (PC_i[9:2]    ),
    .pc_share_wr  (PC_EX_i[9:2] ),
    .taken        (branch_taken ),
    .predict_taken(predict_taken)
  );
`elsif LOCAL
  local_predictor #(.PATTERN_WIDTH(4), .WIDTH(2)) local_predictor (
    .clk          (clk          ),
    .reset_n      (reset_n      ),
    .enable       (is_br_EX     ),
    .stall        (stall        ),
    .pc_share_rd  (PC_i[9:2]    ),
    .pc_share_wr  (PC_EX_i[9:2] ),
    .taken        (branch_taken ),
    .predict_taken(predict_taken)
  );
`elsif TOURNAMENT
  tournament_predictor tournament_predictor (
    .clk          (clk          ),
    .reset_n      (reset_n      ),
    .is_br_EX     (is_br_EX     ),
    .stall        (stall        ),
    .PC_i         (PC_i[9:2]    ),
    .PC_EX_i      (PC_EX_i [9:2]),
    .branch_taken (branch_taken ),
    .br_flush     (br_flush     ),
    .predict_taken(predict_taken)
  );
`elsif BIT
  saturated_counter #(`predict_bit) saturated_counter (
    .clk          (clk          ),
    .reset_n      (reset_n      ),
    .enable       (is_br_EX     ),
    .taken        (branch_taken ),
    .predict_taken(predict_taken)
  );
`endif

`ifndef ALWAYS_NOT_TAKEN
  btb btb (
    .clk      (clk                  ),
    .addr_rd_i(table_addr           ),
    .addr_wr_i(table_addr_EX        ),
    .pc_i     (br_PC                ),
    .tag_i    (PC_EX_i_tag          ),
    .enable   (is_br_EX | is_jump_EX),
    .pc_o     (predicted_pc         ),
    .tag_o    (predicted_tag        ),
    .used_o   (used                 )
  );
`endif

endmodule
