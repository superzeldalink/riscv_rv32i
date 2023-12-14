module bin2bcd #(parameter W = 32  // Input width
) (
  input      [      W-1:0] in , // Binary input
  output reg [W+(W-4)/3:0] bcd  // BCD output
);

  integer i, j;

  always @(*) begin
    // Initialize the BCD output with zeros
    for (i = 0; i <= W + (W-4)/3; i = i + 1)
      bcd[i] = 0;

    // Copy the binary input to the BCD output
    bcd[W-1:0] = in;

    // Convert the binary input to BCD representation
    for (i = 0; i <= W - 4; i = i + 1) begin
      for (j = 0; j <= i/3; j = j + 1) begin
        if (bcd[W - i + 4*j -: 4] > 4) begin
          // If the binary value is greater than 4, add 3 to it
          bcd[W-i+4*j-:4] = bcd[W - i + 4*j -: 4] + 4'd3;
        end
      end
    end
  end
endmodule
