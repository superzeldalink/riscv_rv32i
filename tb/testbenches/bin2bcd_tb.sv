module bin2bcd_tb ();
  parameter   MAX_SIM = 10;
  reg  [31:0] in          ; // Input data
  wire [39:0] bcd         ; // Output: bcd signal

  reg [31:0] expected_output;

  function automatic bit check_bcd(input [31:0] bin, input [39:0] bcd);
    // Convert the BCD to binary
    integer i;
    reg [31:0] bin_check = 0;
    for (i = 10; i > 0; i = i - 1) begin
      bin_check = bin_check * 10 + bcd[i*4-1 -:4];
    end
    // Check if the binary matches
    return (bin_check == bin);
  endfunction

  // Instantiate the bin2bcd module
  bin2bcd bin2bcd_inst (
    .in (in ),
    .bcd(bcd)
  );

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,bin2bcd_tb);
  end

  // Test sequence
  initial begin
    // Start the test loop
    for (int i = 0; i < MAX_SIM; i = i + 1) begin
      in = $random;
      $sscanf(in, "%h", expected_output);
      #10;
      $write("Test %0d - Input: %d, Output: %h => ", i, in, bcd);
      assert (check_bcd(in, bcd)) $display("Passed"); else $display("Failed");

    end

    // Finish the test
    $display("All Passed.");
    $finish;
  end

endmodule
