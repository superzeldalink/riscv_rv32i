`define min(v1, v2) ((v1) < (v2) ? (v1) : (v2))

module custom_components (
  input             clk, reset_n,
  input      [ 7:0] addr_i    ,
  input             write_en_i, // Write enable control,
  input      [31:0] data_i    ,
  output reg [31:0] data_o
);

  localparam BCD_IN_WIDTH  = 16                                           ;
  localparam BCD_OUT_WIDTH = `min(BCD_IN_WIDTH+(BCD_IN_WIDTH-4)/3 + 1, 32);

  localparam TIMER_BITS  = 30;
  localparam SCALER_BITS = 4 ;

/* verilator lint_off UNUSEDSIGNAL */
  wire [BCD_OUT_WIDTH-1:0] bcd_o;
/* verilator lint_on UNUSEDSIGNAL */
  reg  [  TIMER_BITS-1:0] timer_start    ;
  reg  [ SCALER_BITS-1:0] timer_prescaler;
  reg                     timer_enable   ;
  wire                    timer_done     ;
  reg  [BCD_IN_WIDTH-1:0] bcd_i          ;

  bin2bcd #(BCD_IN_WIDTH) u_bin2bcd (
    .in (bcd_i),
    .bcd(bcd_o)
  );

  timer_wrapper timer (
    .clk        (clk            ),
    .reset_n    (reset_n        ),
    .start_i    (timer_start    ),
    .prescaler_i(timer_prescaler),
    .enable_i   (timer_enable   ),
    .done       (timer_done     )
  );

  always_ff @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      bcd_i           <= {BCD_IN_WIDTH{1'd0}};
      timer_start     <= {TIMER_BITS{1'd0}};
      timer_prescaler <= {SCALER_BITS{1'd0}};
      timer_enable    <= 1'd0;
    end else begin
      if(write_en_i) begin
        case (addr_i)
          8'h00   : bcd_i <= data_i[BCD_IN_WIDTH-1:0];
          8'h10   : timer_start <= data_i[TIMER_BITS-1:0];
          8'h14   : timer_prescaler <= data_i[SCALER_BITS-1:0];
          8'h18   : timer_enable <= data_i[0];
          default : begin
            bcd_i           <= bcd_i;
            timer_start     <= timer_start;
            timer_prescaler <= timer_prescaler;
            timer_enable    <= timer_enable;
          end
        endcase
      end
    end
  end

  always_comb begin
    case (addr_i)
      8'h00   : data_o = {{(32 - BCD_IN_WIDTH){1'd0}}, bcd_i};
      8'h04   : data_o = {{(32 - BCD_OUT_WIDTH){1'd0}}, bcd_o};
      8'h10   : data_o = {{(32 - TIMER_BITS){1'd0}}, timer_start};
      8'h14   : data_o = {{(32 - SCALER_BITS){1'd0}}, timer_prescaler};
      8'h18   : data_o = {31'd0, timer_enable};
      8'h1C   : data_o = {31'd0, timer_done};
      default : data_o = 32'd0;
    endcase
  end

endmodule
