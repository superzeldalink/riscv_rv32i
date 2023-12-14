module lsu (
  input             clk        ,
  input             reset_n    ,
  input      [11:0] addr_i     ,
  input      [31:0] st_data_i  ,
  input             st_en_i    ,
  input      [31:0] io_sw_i    ,
  input      [31:0] io_keys_i  ,
  input      [ 2:0] ld_st_sel_i,
  output reg [31:0] ld_data_o  ,
  output     [31:0] io_ledr_o  ,
  output     [31:0] io_lcd_o   ,
  output     [31:0] io_ledg_o  ,
  output     [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o
);

  wire [31:0] memory_data_out_w, peripherals_data_out_w, custom_components_data_out_w;
  wire [31:0] input_peripherals_w;
  wire  [31:0] data_o             ;
  assign input_peripherals_w = (addr_i[7:0] == 8'h00) ? io_sw_i : (addr_i[7:0] == 8'h10) ? io_keys_i : 32'd0;

  wire memory_write_en_w, peripherals_write_en_w;
  wire custom_components_write_en_w;

  reg [31:0] new_data;

  memory #(.DEPTH(DMEM_DEPTH), .MEM_FILE("dmem.hex")) data_memory (
    .clk       (clk              ),
    .addr_i    (addr_i[10:0]     ),
    .data_in_i (new_data         ),
    .write_en_i(memory_write_en_w),
    .data_out_o(memory_data_out_w)
  );

  output_peripherals output_peripherals (
    .clk       (clk                   ),
    .reset_n   (reset_n               ),
    .addr_i    (addr_i[7:0]           ),
    .data_in_i (new_data              ),
    .write_en_i(peripherals_write_en_w),
    .data_out_o(peripherals_data_out_w),
    .io_lcd_o  (io_lcd_o              ),
    .io_ledg_o (io_ledg_o             ),
    .io_ledr_o (io_ledr_o             ),
    .io_hex0_o (io_hex0_o             ),
    .io_hex1_o (io_hex1_o             ),
    .io_hex2_o (io_hex2_o             ),
    .io_hex3_o (io_hex3_o             ),
    .io_hex4_o (io_hex4_o             ),
    .io_hex5_o (io_hex5_o             ),
    .io_hex6_o (io_hex6_o             ),
    .io_hex7_o (io_hex7_o             )
  );

  custom_components custom_components (
    .clk       (clk                         ),
    .reset_n   (reset_n                     ),
    .addr_i    (addr_i[7:0]                 ),
    .write_en_i(custom_components_write_en_w),
    .data_i    (new_data                    ),
    .data_o    (custom_components_data_out_w)
  );

  assign memory_write_en_w            = ~addr_i[11] & st_en_i;
  assign peripherals_write_en_w       = (addr_i[11:8] == 4'b1000) & st_en_i;
  assign custom_components_write_en_w = (addr_i[11:8] == 4'b1010) & st_en_i;

  assign data_o = (~addr_i[11]) ? memory_data_out_w :
    (addr_i[10:8] == 3'b000) ? peripherals_data_out_w :
    (addr_i[10:8] == 3'b001) ? input_peripherals_w :
    (addr_i[10:8] == 3'b010) ? custom_components_data_out_w :
    32'd0;

  always_comb begin
    casez(ld_st_sel_i)
      3'b000  : ld_data_o = {{24{data_o[7]}}, data_o[7:0]}; // lb
      3'b001  : ld_data_o = {{16{data_o[15]}}, data_o[15:0]}; // lh
      3'b010  : ld_data_o = data_o; // lw
      3'b100  : ld_data_o = {24'd0, data_o[7:0]}; // lbu
      3'b101  : ld_data_o = {16'd0, data_o[15:0]}; // lhu
      default : ld_data_o = 32'dx;
    endcase
  end

  // always @(negedge clk or negedge reset_n )begin
  //   if(~reset_n)
  //     data_o <= 32'd0;
  //   else begin
  //     casez (addr_i[11:8])
  //       4'b0??? : data_o <= memory_data_out_w;
  //       4'b1000 : data_o <= peripherals_data_out_w;
  //       4'b1001 : data_o <= input_peripherals_w;
  //       4'b1010 : data_o <= custom_components_data_out_w;
  //       default : data_o <= 32'd0;
  //     endcase
  //   end
  // end

  // always @(negedge clk or negedge reset_n )begin
  //   if(~reset_n)
  //     ld_data_o <= 32'd0;
  //   else
  //     case(ld_st_sel_i)
  //       3'b000  : ld_data_o <= {{24{data_o[7]}}, data_o[7:0]}; // lb
  //       3'b001  : ld_data_o <= {{16{data_o[15]}}, data_o[15:0]}; // lh
  //       3'b010  : ld_data_o <= data_o; // lw
  //       3'b100  : ld_data_o <= {24'd0, data_o[7:0]}; // lbu
  //       3'b101  : ld_data_o <= {16'd0, data_o[15:0]}; // lhu
  //       default : ld_data_o <= 32'd0;
  //     endcase
  // end

  always_comb begin
    casez(ld_st_sel_i)
      3'b000  : new_data = {data_o[31:8], st_data_i[7:0]}; // sb
      3'b001  : new_data = {data_o[31:16], st_data_i[15:0]}; // sh
      3'b010  : new_data = st_data_i; // sw
      default : new_data = 32'dx;
    endcase
  end

endmodule
