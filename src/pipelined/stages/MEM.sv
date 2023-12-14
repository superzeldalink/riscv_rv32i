module MEM (
  input         clk           ,
  input         reset_n       ,
  input  [31:0] addr_i        ,
  input  [31:0] rs2_i         ,
  input         st_en_i       ,
  input  [31:0] io_sw_i       ,
  input  [31:0] io_keys_i     ,
  input  [ 2:0] ld_st_sel_i   ,
  input  [31:0] PC_i          ,
  output [31:0] ld_data_o     ,
  output [31:0] io_ledr_o     ,
  output [31:0] io_lcd_o      ,
  output [31:0] io_ledg_o     ,
  output [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o
);

  lsu lsu_module (
    .clk        (clk         ),
    .reset_n    (reset_n     ),
    .addr_i     (addr_i[11:0]),
    .st_data_i  (rs2_i       ),
    .st_en_i    (st_en_i     ),
    .io_sw_i    (io_sw_i     ),
    .io_keys_i  (io_keys_i   ),
    .ld_st_sel_i(ld_st_sel_i ),
    .ld_data_o  (ld_data_o   ),
    .io_ledr_o  (io_ledr_o   ),
    .io_lcd_o   (io_lcd_o    ),
    .io_ledg_o  (io_ledg_o   ),
    .io_hex0_o  (io_hex0_o   ),
    .io_hex1_o  (io_hex1_o   ),
    .io_hex2_o  (io_hex2_o   ),
    .io_hex3_o  (io_hex3_o   ),
    .io_hex4_o  (io_hex4_o   ),
    .io_hex5_o  (io_hex5_o   ),
    .io_hex6_o  (io_hex6_o   ),
    .io_hex7_o  (io_hex7_o   )
  );
endmodule
