module saturated_adder #(parameter WIDTH = 4) (
  input      [WIDTH-1:0] val_i,
  input                  taken,
  output reg [WIDTH-1:0] val_o
);

  always_comb begin
    if((val_i == {WIDTH{1'd1}} & taken) | (val_i == {WIDTH{1'd0}} & ~taken)) begin
      val_o = val_i;
    end else begin
      if(taken) begin
        val_o = val_i + 'd1;
      end else begin
        val_o = val_i - 'd1;
      end
    end
  end
endmodule
