module top_tb ();
  reg         clk     ;
  reg         reset_n ;
  wire [31:0] PC_debug;

  // Instantiate the single_cycle module
  pipelined uut (
    .clk_i    (clk     ),
    .rst_ni   (reset_n ),
    .PC_debug (PC_debug),
    .io_sw_i  (        ),
    .io_keys_i(        ),
    .io_hex0_o(        ),
    .io_hex1_o(        ),
    .io_hex2_o(        ),
    .io_hex3_o(        ),
    .io_hex4_o(        ),
    .io_hex5_o(        ),
    .io_hex6_o(        ),
    .io_hex7_o(        ),
    .io_lcd_o (        ),
    .io_ledr_o(        ),
    .io_ledg_o(        )
  );

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,top_tb);

    $dumpfile("top.vcd");
    $dumpvars(0,top_tb);
  end

  // Clock generation
  always begin
    #5 clk = ~clk;  // Generate a clock with 10ns period
  end

  // Initializations
  initial begin
    clk = 0;
    reset_n = 0;
    // Reset the circuit
    reset_n = 0;
    #10 reset_n = 1;

    // End the simulation
    #1000000 $finish;
  end

  // Monitor PC_debug
  always @(PC_debug) begin
    $display("%d: PC_debug = %h", $time, PC_debug);
  end

endmodule