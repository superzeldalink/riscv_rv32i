`ifndef btb_bit
  `define btb_bit 1
`endif

`ifndef predict_bit
  `define predict_bit 2
`endif

module wrapper (
  input         CLOCK_50,
  input  [17:0] SW      ,
  input  [ 3:0] KEY     ,
  output [31:0] PC_debug,
  output [ 6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
  output [17:0] LEDR    ,
  output [ 8:0] LEDG    ,
  output [ 7:0] LCD_DATA,
  output        LCD_RW, LCD_EN, LCD_RS, LCD_ON, LCD_BLON
);

  wire [10:0] io_lcd_w;
  assign {LCD_EN, LCD_RS, LCD_RW, LCD_DATA} = io_lcd_w;
  assign LCD_BLON = 1'b1;
  // assign LCD_ON   = 1'b1;

  wire [31:0] io_sw_i,io_keys_i ,io_hex0_o ,io_hex1_o ,io_hex2_o ,io_hex3_o ,io_hex4_o ,io_hex5_o ,io_hex6_o ,io_hex7_o ,io_ledr_o ,io_ledg_o ,io_lcd_o;

  assign io_sw_i   = {15'd0, SW[16:0]} ;
  assign io_keys_i = {{28{1'b1}}, KEY[3:0]};
  assign HEX0      = io_hex0_o[6:0];
  assign HEX1      = io_hex1_o[6:0];
  assign HEX2      = io_hex2_o[6:0];
  assign HEX3      = io_hex3_o[6:0];
  assign HEX4      = io_hex4_o[6:0];
  assign HEX5      = io_hex5_o[6:0];
  assign HEX6      = io_hex6_o[6:0];
  assign HEX7      = io_hex7_o[6:0];
  assign LEDR      = io_ledr_o[17:0];
  assign LEDG      = io_ledg_o[8:0];
  assign io_lcd_w  = io_lcd_o[10:0];
  assign LCD_ON    = io_lcd_o[31];

  pipelined pipelined (
    .clk_i    (CLOCK_50 ),
    .rst_ni   (SW[17]   ),
    .io_sw_i  (io_sw_i  ),
    .io_keys_i(io_keys_i),
    .io_hex0_o(io_hex0_o),
    .io_hex1_o(io_hex1_o),
    .io_hex2_o(io_hex2_o),
    .io_hex3_o(io_hex3_o),
    .io_hex4_o(io_hex4_o),
    .io_hex5_o(io_hex5_o),
    .io_hex6_o(io_hex6_o),
    .io_hex7_o(io_hex7_o),
    .io_ledr_o(io_ledr_o),
    .io_ledg_o(io_ledg_o),
    .io_lcd_o (io_lcd_o ),
    .PC_debug (PC_debug )
  );

endmodule
