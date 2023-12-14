module local_predictor #(
  parameter WIDTH         = `predict_bit,
  parameter PATTERN_WIDTH = 4
) (
  input        clk, reset_n ,
  input        enable, stall,
  input  [7:0] pc_share_rd, pc_share_wr,
  input        taken        ,
  output       predict_taken
);

  reg  [PATTERN_WIDTH-1:0] pattern        ;
  wire [PATTERN_WIDTH-1:0] next_pattern   ;
  reg  [PATTERN_WIDTH-1:0] prev_pattern_ID, prev_pattern_EX;

  // Tables
  reg [WIDTH-1:0] bht[2**PATTERN_WIDTH];
  reg [      3:0] pht[             256];

  // Table addresses
  wire [              7:0] pht_addr_rd, pht_addr_wr;
  wire [PATTERN_WIDTH-1:0] bht_addr_rd, bht_addr_wr;

  // Counter data
  wire [WIDTH-1:0] counter_val_rd, counter_val_wr;
  wire [WIDTH-1:0] next_val_counter;

  assign next_pattern = {taken, pattern[PATTERN_WIDTH-1:1]};

  assign pht_addr_rd = pc_share_rd;
  assign pht_addr_wr = pc_share_wr;

  assign bht_addr_rd = pht[pht_addr_rd] ^ pc_share_rd[PATTERN_WIDTH-1:0];
  assign bht_addr_wr = pht[pht_addr_wr] ^ pc_share_wr[PATTERN_WIDTH-1:0];

  assign counter_val_rd = bht[bht_addr_rd];
  assign counter_val_wr = bht[bht_addr_wr];
  assign predict_taken  = counter_val_rd[WIDTH-1];

  saturated_adder #(WIDTH) saturated_adder (
    .val_i(counter_val_wr  ),
    .taken(taken           ),
    .val_o(next_val_counter)
  );

  always @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      pattern <= 'd0;
    end else begin
      prev_pattern_ID <= pattern;
      prev_pattern_EX <= prev_pattern_ID;
      if(enable & ~stall) begin
        pattern          <= next_pattern;
        pht[pht_addr_wr] <= prev_pattern_EX;
        bht[bht_addr_wr] <= next_val_counter;
      end
    end
  end

endmodule
