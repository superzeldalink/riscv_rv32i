// configurable timer module with pre-scaler
module timer #(parameter
  TIMER_BITS  = 8,
  SCALER_BITS = 2
) (
  input                    clk    , // clock input
  input                    reset_n, // async reset
  input                    enable , // timer enable
  input  [ TIMER_BITS-1:0] init   , // timer start value,
  input  [SCALER_BITS-1:0] ps     , // pre-scale factor
  output                   done     // tick event raised when timer reaches zero
);

// register for countdown timer
  reg [TIMER_BITS-1:0] counter;

// register for scaler
  reg [2**SCALER_BITS-1:0] scaler;

// holds the next value of internal counter
  wire [TIMER_BITS-1:0] counterNext;

// holds the next value of the scaler
  wire [2**SCALER_BITS-1:0] scalerNext;

// update or reset the timer on the clock tick
  always_ff @(posedge clk) begin
    if (~reset_n) begin
      counter <= init;
      scaler  <= 0;
    end else begin
      // only update counter when it is enable
      if (enable) begin
        counter <= counterNext;
        scaler  <= scalerNext;
      end else begin
        counter <= counter;
        scaler  <= scaler;
      end
    end
  end

// compute the next scaler value
  assign scalerNext = (scaler == (('d1 << ps) - 'd1) || (counter == 0)) ? 0 : scaler + 'd1;

// compute the next counter value
  assign counterNext = (counter == 0) ? 0 : (scalerNext == 0) ? counter - 1 : counter;

// raise tick when counter reaches 0
  assign done = counter == 0;

endmodule
