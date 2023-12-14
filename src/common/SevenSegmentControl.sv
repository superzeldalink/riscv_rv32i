module SevenSegmentControl (
  input  wire [31:0] val,
  output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7
);

// Define a 7-segment display lookup table for hexadecimal digits
// Each element corresponds to the 7 segments (a, b, c, d, e, f, g)
  wire [6:0] seven_segment[16];

  generate
    assign seven_segment[0] = 7'b1000000;  // 0
    assign seven_segment[1] = 7'b1111001;  // 1
    assign seven_segment[2] = 7'b0100100;  // 2
    assign seven_segment[3] = 7'b0110000;  // 3
    assign seven_segment[4] = 7'b0011001;  // 4
    assign seven_segment[5] = 7'b0010010;  // 5
    assign seven_segment[6] = 7'b0000010;  // 6
    assign seven_segment[7] = 7'b1111000;  // 7
    assign seven_segment[8] = 7'b0000000;  // 8
    assign seven_segment[9] = 7'b0010000;  // 9
    assign seven_segment[10] = 7'b0001000; // A
    assign seven_segment[11] = 7'b0000011; // B
    assign seven_segment[12] = 7'b1000110; // C
    assign seven_segment[13] = 7'b0100001; // D
    assign seven_segment[14] = 7'b0000110; // E
    assign seven_segment[15] = 7'b0001110; // F
  endgenerate

  wire [3:0] val0, val1, val2, val3, val4, val5, val6, val7;
  assign {val7, val6, val5, val4, val3, val2, val1, val0} = val;

// Map val values to 7-segment displays
  assign HEX0 = seven_segment[val0];
  assign HEX1 = seven_segment[val1];
  assign HEX2 = seven_segment[val2];
  assign HEX3 = seven_segment[val3];
  assign HEX4 = seven_segment[val4];
  assign HEX5 = seven_segment[val5];
  assign HEX6 = seven_segment[val6];
  assign HEX7 = seven_segment[val7];

endmodule
