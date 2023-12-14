module saturated_counter #(parameter WIDTH = 4) (
  input  clk          ,
  input  reset_n      ,
  input  enable       ,
  input  taken        ,
  output predict_taken
);

  reg [WIDTH-1:0] counter, counter_next;

  assign predict_taken = counter[WIDTH-1];

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      counter <= {WIDTH{1'b0}};
    end else begin
      if (enable) begin
        counter <= counter_next;
      end
    end
  end

  always_comb begin
    if((counter == {WIDTH{1'd1}} & taken) | (counter == {WIDTH{1'd0}} & ~taken)) begin
      counter_next = counter;
    end else begin
      if(taken) begin
        counter_next = counter + 'd1;
      end else begin
        counter_next = counter - 'd1;
      end
    end
  end

endmodule
