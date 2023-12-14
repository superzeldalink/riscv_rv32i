module one_bit_predictor (
  input  clk, reset_n ,
  input  enable       ,
  input  taken        ,
  output predict_taken
);

  // Define states
  parameter ST_PREDICT_NOT_TAKEN = 2'b00;
  parameter ST_PREDICT_TAKEN     = 2'b01;

  // State variable
  reg [1:0] state, next_state;

  // Output variable
  reg predict_taken_reg;

  // Combinational logic for next state and output
  always_comb begin
    case (state)
      ST_PREDICT_TAKEN :
        begin
          next_state        = (taken) ? ST_PREDICT_TAKEN : ST_PREDICT_NOT_TAKEN;
          predict_taken_reg = 1;
        end
      ST_PREDICT_NOT_TAKEN :
        begin
          next_state        = (taken) ? ST_PREDICT_TAKEN : ST_PREDICT_NOT_TAKEN;
          predict_taken_reg = 0;
        end
      default :
        begin
          next_state        = ST_PREDICT_NOT_TAKEN;
          predict_taken_reg = 0;
        end
    endcase
  end

  // Sequential logic for state update
  always_ff @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state <= ST_PREDICT_NOT_TAKEN; // Reset state
    end else if (enable) begin
      state <= next_state; // Update state
    end
  end

  // Output the predicted value
  assign predict_taken = predict_taken_reg;

endmodule
