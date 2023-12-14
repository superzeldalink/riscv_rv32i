module output_peripherals (
  input             clk       , // Clock input
  input             reset_n   , // Reset input
  input      [ 7:0] addr_i    , // Address input
  input      [31:0] data_in_i , // Data input for writing
  input             write_en_i, // Write enable control,
  output reg [31:0] data_out_o, // Data output
  output reg [31:0] io_ledr_o ,
  output reg [31:0] io_lcd_o  ,
  output reg [31:0] io_ledg_o ,
  output reg [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o
);

  wire [6:0] ssc_HEX0, ssc_HEX1, ssc_HEX2, ssc_HEX3, ssc_HEX4, ssc_HEX5, ssc_HEX6, ssc_HEX7;

  SevenSegmentControl ssc (
    .val (data_in_i),
    .HEX0(ssc_HEX0 ),
    .HEX1(ssc_HEX1 ),
    .HEX2(ssc_HEX2 ),
    .HEX3(ssc_HEX3 ),
    .HEX4(ssc_HEX4 ),
    .HEX5(ssc_HEX5 ),
    .HEX6(ssc_HEX6 ),
    .HEX7(ssc_HEX7 )
  );

  always_ff @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      io_hex0_o <= 32'b0;
      io_hex1_o <= 32'b0;
      io_hex2_o <= 32'b0;
      io_hex3_o <= 32'b0;
      io_hex4_o <= 32'b0;
      io_hex5_o <= 32'b0;
      io_hex6_o <= 32'b0;
      io_hex7_o <= 32'b0;
      io_ledr_o <= 32'b0;
      io_ledg_o <= 32'b0;
      io_lcd_o  <= 32'b0;
    end else if (write_en_i) begin
      case (addr_i)
        8'h00 :
          io_hex0_o <= data_in_i;
        8'h10 :
          io_hex1_o <= data_in_i;
        8'h20 :
          io_hex2_o <= data_in_i;
        8'h30 :
          io_hex3_o <= data_in_i;
        8'h40 :
          io_hex4_o <= data_in_i;
        8'h50 :
          io_hex5_o <= data_in_i;
        8'h60 :
          io_hex6_o <= data_in_i;
        8'h70 :
          io_hex7_o <= data_in_i;
        8'h80 :
          io_ledr_o <= data_in_i;
        8'h90 :
          io_ledg_o <= data_in_i;
        8'hA0 :
          io_lcd_o <= data_in_i;
        8'hB0 : begin
          io_hex0_o <= {25'd0, ssc_HEX0};
          io_hex1_o <= {25'd0, ssc_HEX1};
          io_hex2_o <= {25'd0, ssc_HEX2};
          io_hex3_o <= {25'd0, ssc_HEX3};
          io_hex4_o <= {25'd0, ssc_HEX4};
          io_hex5_o <= {25'd0, ssc_HEX5};
          io_hex6_o <= {25'd0, ssc_HEX6};
          io_hex7_o <= {25'd0, ssc_HEX7};
        end
        default : begin
          io_hex0_o <= io_hex0_o;
          io_hex1_o <= io_hex1_o;
          io_hex2_o <= io_hex2_o;
          io_hex3_o <= io_hex3_o;
          io_hex4_o <= io_hex4_o;
          io_hex5_o <= io_hex5_o;
          io_hex6_o <= io_hex6_o;
          io_hex7_o <= io_hex7_o;
          io_ledr_o <= io_ledr_o;
          io_ledg_o <= io_ledg_o;
          io_lcd_o  <= io_lcd_o ;
        end
      endcase
    end
  end

  always_comb begin
    case (addr_i)
      8'h00 :
        data_out_o = io_hex0_o;
      8'h10 :
        data_out_o = io_hex1_o;
      8'h20 :
        data_out_o = io_hex2_o;
      8'h30 :
        data_out_o = io_hex3_o;
      8'h40 :
        data_out_o = io_hex4_o;
      8'h50 :
        data_out_o = io_hex5_o;
      8'h60 :
        data_out_o = io_hex6_o;
      8'h70 :
        data_out_o = io_hex7_o;
      8'h80 :
        data_out_o = io_ledr_o;
      8'h90 :
        data_out_o = io_ledg_o;
      8'hA0 :
        data_out_o = io_lcd_o;
      default :
        data_out_o = 32'd0;
    endcase
  end

endmodule
