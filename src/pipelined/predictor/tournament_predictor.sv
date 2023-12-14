module tournament_predictor (
  input        clk          ,
  input        reset_n      ,
  input        is_br_EX     ,
  input        stall        ,
  input  [9:2] PC_i         ,
  input  [9:2] PC_EX_i      ,
  input        branch_taken   ,
  input        br_flush     ,
  output       predict_taken
);

  reg [1:0] score, next_score;

  wire predict_taken1, predict_taken2;

  reg prev_predict_taken1_ID, prev_predict_taken1_EX, prev_predict_taken2_ID, prev_predict_taken2_EX;

  wire predict1_correct, predict2_correct;
  assign predict1_correct = prev_predict_taken1_EX ~^ br_flush;
  assign predict2_correct = prev_predict_taken2_EX ~^ br_flush;

  wire [1:0] predict_correct12;
  assign predict_correct12 = {predict1_correct, predict2_correct};

`ifdef TOURNAMENT_BIT
  saturated_counter #(`predict_bit) saturated_counter (
    .clk          (clk           ),
    .reset_n      (reset_n       ),
    .enable       (is_br_EX      ),
    .taken        (branch_taken    ),
    .predict_taken(predict_taken1)
  );
`else
  local_predictor #(.WIDTH(2)) predictor1 (
    .clk          (clk           ),
    .reset_n      (reset_n       ),
    .enable       (is_br_EX      ),
    .stall        (stall         ),
    .pc_share_rd  (PC_i[9:2]     ),
    .pc_share_wr  (PC_EX_i[9:2]  ),
    .taken        (branch_taken    ),
    .predict_taken(predict_taken1)
  );
`endif

  gshare #(.PATTERN_WIDTH(4)) predictor2 (
    .clk          (clk           ),
    .reset_n      (reset_n       ),
    .enable       (is_br_EX      ),
    .stall        (stall         ),
    .pc_share_rd  (PC_i[9:2]     ),
    .pc_share_wr  (PC_EX_i[9:2]  ),
    .taken        (branch_taken    ),
    .predict_taken(predict_taken2)
  );

  saturated_adder #(2) saturated_adder (
    .val_i(score                     ),
    .taken(predict_correct12 == 2'b01),
    .val_o(next_score                )
  );

  assign predict_taken = ~score[1] ? predict_taken2 : predict_taken1;

  always @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      score                  <= 2'd0;
      prev_predict_taken1_ID <= 1'b0;
      prev_predict_taken1_EX <= 1'b0;
      prev_predict_taken2_ID <= 1'b0;
      prev_predict_taken2_EX <= 1'b0;
    end else begin
      prev_predict_taken1_ID <= predict_taken1;
      prev_predict_taken1_EX <= prev_predict_taken1_ID;
      prev_predict_taken2_ID <= predict_taken2;
      prev_predict_taken2_EX <= prev_predict_taken2_ID;
      if(is_br_EX & (predict1_correct ^ predict2_correct)) begin
        score <= next_score;
      end
    end
  end
endmodule
