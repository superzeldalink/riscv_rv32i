module timer_wrapper #(
  parameter TIMER_BITS  = 30,
  parameter SCALER_BITS = 4
) (
  input                    clk, reset_n,
  // input  [31:0] data_in,
  input  [ TIMER_BITS-1:0] start_i    ,
  input  [SCALER_BITS-1:0] prescaler_i,
  input                    enable_i   ,
  // input  [         31:0] start_i, prescaler_i, enable_i,
  output                   done
);

  // reg                   enable   ;
  // reg [ TIMER_BITS-1:0] start    ;
  // reg [SCALER_BITS-1:0] prescaler;

  timer #(TIMER_BITS,SCALER_BITS) timer (
    .clk    (clk                         ),
    .reset_n(reset_n & enable_i          ), // async reset
    .enable (enable_i                    ), // timer enable
    .init   (start_i[TIMER_BITS-1:0]     ), // timer start value,
    .ps     (prescaler_i[SCALER_BITS-1:0]), // pre-scale factor
    .done   (done                        )  // tick event raised when timer reaches zero
  );

  // always_ff @(posedge clk or negedge reset_n) begin
  //   if(~reset_n) begin
  //     enable    <= 0;
  //     start     <= 0;
  //     prescaler <= 0;
  //   end else begin
  //     enable    <= enable;
  //     start     <= start;
  //     prescaler <= prescaler;
  //     casez (data_in[31:30])
  //       2'b00 : start <= data_in[TIMER_BITS-1:0];
  //       2'b01 : prescaler <= data_in[SCALER_BITS-1:0];
  //       2'b1? : enable <= data_in[30];
  //     endcase
  //   end
  // end

  // assign data_out    = {31'd0, done};
  // assign enable_tick = ~enable_i & data_in[31] & data_in[30]; //  (enable ^ &data_in[31:30]) & &data_in[31:30];   // (A ^ B) & B

  // assign start_o     = {{(32-TIMER_BITS){1'b0}}, start};
  // assign prescaler_o = {{(32-SCALER_BITS){1'b0}}, prescaler};
  // assign enable_o    = {31'd0, enable};

endmodule
