module regfile_tb ();
  // Define the clock signal
  reg clk;
  always begin
    #5 clk = ~clk; // Create a 10ns clock period
  end

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,regfile_tb);
  end

  // Define signals to monitor the outputs
  wire [31:0] dataR1_o;
  wire [31:0] dataR2_o;

  // Define testbench signals
  reg [ 4:0] rsW_i   ;
  reg [ 4:0] rsR1_i  ;
  reg [ 4:0] rsR2_i  ;
  reg [31:0] dataW_i ;
  reg        regWEn_i;

  // Instantiate the RegFile module
  RegFile dut (
    .clk_i   (clk     ),
    .rsW_i   (rsW_i   ),
    .rsR1_i  (rsR1_i  ),
    .rsR2_i  (rsR2_i  ),
    .dataW_i (dataW_i ),
    .regWEn_i(regWEn_i),
    .dataR1_o(dataR1_o),
    .dataR2_o(dataR2_o)
  );

  task write_data(input [4:0] addr, input [31:0] data);
    begin
      @(negedge clk);
      rsW_i = addr;
      dataW_i = data;
      regWEn_i = 1;
      #10; // Wait for a clock cycle
      regWEn_i = 0;
      assert(dut.RegArray[addr] == data);
    end
  endtask

  task write_random_data();
    begin
      logic[4:0] addr = $random();
      logic[31:0] data = $random();
      @(negedge clk);
      rsW_i = addr;
      dataW_i = data;
      regWEn_i = 1;
      #10; // Wait for a clock cycle
      regWEn_i = 0;
      assert(dut.RegArray[addr] == data);
    end
  endtask

  task read_random_data();
    begin
      logic[4:0] addr = $random();
      logic[4:0] addr2 = $random();
      rsR1_i = addr;
      rsR2_i = addr2;
      #10;
      assert((addr == 0 ? 0 : dut.RegArray[addr]) == dataR1_o) else $display("Read test failed: rsR1=%h, output=%h, mem_data=%h", addr, dataR1_o, dut.RegArray[addr]);
      assert((addr2 == 0 ? 0 : dut.RegArray[addr2]) == dataR2_o) else $display("Read test failed: rsR2=%h, output=%h, mem_data=%h", addr2, dataR2_o, dut.RegArray[addr2]);
    end
  endtask

  initial begin
    // Initialize signals
    clk = 0;
    regWEn_i = 0;

    write_random_data;
    read_random_data;

    // repeat(200) write_random_data;
    // repeat(200) read_random_data;

    // End the simulation
    #100 $finish;
  end

endmodule
