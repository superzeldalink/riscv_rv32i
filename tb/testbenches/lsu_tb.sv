`timescale 1ns / 1ps

module lsu_tb ();

  // Constants
  reg         clk        ;
  reg  [11:0] addr_i     ;
  reg  [ 2:0] ld_st_sel_i;
  reg  [31:0] st_data_i  ;
  reg         st_en_i    ;
  reg  [31:0] io_sw_i, io_keys_i;
  wire [31:0] ld_data_o  ;
  wire [31:0] io_lcd_o, io_ledg_o, io_ledr_o;
  wire [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o;

  // Instantiate the LSU module
  lsu dut (
    .clk        (clk        ),
    .addr_i     (addr_i     ),
    .st_data_i  (st_data_i  ),
    .st_en_i    (st_en_i    ),
    .io_sw_i    (io_sw_i    ),
    .io_keys_i  (io_keys_i  ),
    .ld_st_sel_i(ld_st_sel_i),
    .ld_data_o  (ld_data_o  ),
    .io_lcd_o   (io_lcd_o   ),
    .io_ledg_o  (io_ledg_o  ),
    .io_ledr_o  (io_ledr_o  ),
    .io_hex0_o  (io_hex0_o  ),
    .io_hex1_o  (io_hex1_o  ),
    .io_hex2_o  (io_hex2_o  ),
    .io_hex3_o  (io_hex3_o  ),
    .io_hex4_o  (io_hex4_o  ),
    .io_hex5_o  (io_hex5_o  ),
    .io_hex6_o  (io_hex6_o  ),
    .io_hex7_o  (io_hex7_o  )
  );

  integer random_addr, random_data;

  // Clock generation
  always begin
    #5 clk = ~clk;  // Toggle the clock every 5 time units
  end

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,lsu_tb);
  end

  // sequence rd_detect(addr);
  //   ##[0:$] (~st_data_i && (addr_i == addr));
  // endsequence

  // property data_wr_rd_chk(addr, data);
  //   @(posedge clk)
  //     (st_en_i, $display($time, "WRITE: addr=%h, data=%h", addr, data))
  //     |-> @(posedge clk)
  //     ##1 (addr !== addr) |-> first_match(rd_detect(addr), $display($time, "READ: addr=%h, data=%h", addr, ld_data_o)) ##0 ld_data_o == data;
  // endproperty
  // assert property (data_wr_rd_chk(addr_i, st_data_i)) $display("DATA_WR_RD_CHK: passed"); else $error("Assertion DATA_WR_RD_CHK failed");

  task writeRandomData(input [11:0] addr);
    addr_i = addr;
    random_data = $random();
    st_data_i = random_data;
    @(posedge clk);
    st_en_i = 1'b1;
    @(posedge clk);
    st_en_i = 1'b0;
    addr = 12'd0;

    $display("0x%x: stored %x", addr_i, random_data);
  endtask

  task checkDataAtAddr(input [11:0] addr, input [31:0] data);
    addr_i = addr;
    @(posedge clk);
    #1 assert (ld_data_o === data) $display("0x%x:   read %x => Matched", addr, ld_data_o); else $error("0x%x:   read %x => NOT matched!", addr, ld_data_o);
    @(posedge clk);
    addr = 12'd0;
  endtask

  task checkData(input [31:0] data, input [31:0] data2);
    #1 assert (data === data2) $display("Read data: %x => Matched.", data2); else $error("Read data: %x => NOT matched!", data2);
  endtask

  wire [31:0] memory_data;
  assign memory_data = dut.data_memory.mem[addr_i/4];

  // Test input values
  initial begin
    clk = 0;
    ld_st_sel_i = 3'b010;

    // DMEM TEST
    // Loop through some addresses (DMEM)
    $display("===== DMEM test =====");
    for (integer i = 0; i < 10240; i = i + 4) begin
      random_addr = $random % 12'h800;
      writeRandomData(random_addr);
      checkDataAtAddr(random_addr, random_data);
      #10;
    end

    for (int i = 0; i < 100; i+=1) begin
      $display("===== IO test =====");
      $display("** PASS %d **", i);
      // Inputs
      $display("===> Input peripherals test");
      io_sw_i = $random; // Random switch input
      io_keys_i = $random;
      $display("SW:           %x", io_sw_i);
      checkDataAtAddr('h900, io_sw_i);
      $display("KEYS:         %x", io_keys_i);
      checkDataAtAddr('h910, io_keys_i);

      // Outputs
      $display("===> Output peripherals test");
      $display("[HEXes]");
      writeRandomData('h800);
      checkData(random_data, io_hex0_o);
      writeRandomData('h810);
      checkData(random_data, io_hex1_o);
      writeRandomData('h820);
      checkData(random_data, io_hex2_o);
      writeRandomData('h830);
      checkData(random_data, io_hex3_o);
      writeRandomData('h840);
      checkData(random_data, io_hex4_o);
      writeRandomData('h850);
      checkData(random_data, io_hex5_o);
      writeRandomData('h860);
      checkData(random_data, io_hex6_o);
      writeRandomData('h870);
      checkData(random_data, io_hex7_o);

      $display("[LEDR]");
      writeRandomData('h880);
      checkData(random_data, io_ledr_o);

      $display("[LEDG]");
      writeRandomData('h890);
      checkData(random_data, io_ledg_o);

      $display("[LCD]");
      writeRandomData('h8A0);
      checkData(random_data, io_lcd_o);
    end
    // Finish simulation
    $finish;
  end

endmodule
