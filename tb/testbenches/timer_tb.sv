module timer_tb ();
  reg         clk     ;
  reg         reset_n ;
  reg  [31:0] data_in ;
  wire [31:0] data_out;

  integer start_time, end_time, cycles;

  // Instantiate the timer_wrapper module
  timer_wrapper uut (
    .clk     (clk     ),
    .reset_n (reset_n ),
    .data_in (data_in ),
    .data_out(data_out)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

// Simulate the testbench
  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,timer_tb);
  end

  task start_timer;
    input [29:0] INIT;
    input [29:0] PRESCALER;
    reg [63:0] start_time;
    reg [63:0] end_time;
    reg [63:0] cycles;

    $display("Initial Value: %d, Prescaler: %d", INIT, PRESCALER);

    // Disable the timer
    data_in = {2'b10, 30'd0};
    #20;

    // Set start value to INIT
    data_in = {2'b00, INIT};
    #10;

    // Set prescaler to PRESCALER
    data_in = {2'b01, PRESCALER};
    #10;

    // Enable the timer
    data_in = {2'b11, 30'd0};
    #10;
    start_time = $time;

    while (!data_out[0]) #5;
    end_time = $time;

    cycles = (end_time - start_time) / 10;
    $display("Start time: %d, End time: %d => Cycles: %d", start_time, end_time, cycles);
    if (cycles == INIT * (2**PRESCALER))
      $display("Test Passed!");
    else
      $display("Test Failed!");
  endtask

  initial begin
    // Initialize inputs
    clk = 0;
    reset_n = 1;
    data_in = 32'b0;

    // Apply reset
    reset_n = 0;
    #10 reset_n = 1;

    // start a timer with init=250, prescaler=4
    start_timer(250, 2);

    // start a timer with init=500, prescaler=16
    start_timer(500, 4);
    $finish;
  end
endmodule
