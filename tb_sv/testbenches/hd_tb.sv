module hd_tb ();

  // Parameters
  parameter CLK_PERIOD = 10 ; // Clock period in time units
  parameter SIM_TIME   = 100; // Simulation time in time units

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,hd_tb);
  end

  // Signals
  reg  [31:0] inst_IF_i, inst_ID_i, inst_EX_i, inst_MEM_i, inst_WB_i;
  wire        ID_EX_flush, pc_IF_ID_en;

  // Instantiate the forwarding_unit module
  hazard_detection dut (
    .inst_ID_i  (inst_ID_i  ),
    .inst_EX_i  (inst_EX_i  ),
    .ID_EX_flush(ID_EX_flush),
    .pc_en      (pc_IF_ID_en),
    .IF_ID_en   (           )
  );

  // Clock Generation
  reg clk = 0;
  always #((CLK_PERIOD) / 2) clk = ~clk;

  always @(posedge clk) begin
    inst_ID_i  <= inst_IF_i;
    inst_EX_i  <= inst_ID_i;
    inst_MEM_i <= inst_EX_i;
    inst_WB_i  <= inst_MEM_i;
  end

  task send_inst(input [31:0] inst);
    inst_IF_i = inst;
    #(CLK_PERIOD);
  endtask

  task send_and_check(input [31:0] inst);
    fork
      send_inst(inst);
      #(2*CLK_PERIOD) $display("inst_EX: %h, ID_EX_flush: %b, pc/IF_ID_en: %b", inst_EX_i, ID_EX_flush, pc_IF_ID_en);
    join_any
  endtask

  task case1;
// add x4, x3, x2
// lw  x5, 0x40(x1)
// sub x9, x5, x1
// or  x2, x7, x5
// sll x4, x5, x1
    send_and_check(32'h00218233);
    send_and_check(32'h0400A283);
    send_and_check(32'h401284B3);
    send_and_check(32'h0053E133);
    send_and_check(32'h00129233);
  endtask

  task case2;
// lw x1, 0(x0)
// lw x2, 4(x0)
// add x3, x1, x2
// sw x3, 12(x0)
// lw x4, 8(x0)
// add x5, x1, x4
// sw x5, 16(x0)
    send_and_check(32'h00002083);
    send_and_check(32'h00402103);
    send_and_check(32'h002081B3);
    send_and_check(32'h00302623);
    send_and_check(32'h00802203);
    send_and_check(32'h004082B3);
    send_and_check(32'h00502823);
  endtask

  task case3;
// lw x1, 0(x0)
// lw x2, 4(x0)
// sw x3, 12(x0)
// add x3, x1, x2
// lw x4, 8(x0)
// add x5, x1, x4
// sw x5, 16(x0)
    send_and_check(32'h00002083);
    send_and_check(32'h00402103);
    send_and_check(32'h00802203);
    send_and_check(32'h002081B3);
    send_and_check(32'h00302623);
    send_and_check(32'h004082B3);
    send_and_check(32'h00502823);
  endtask

  // Stimulus
  initial begin
    // Initialize inputs
    case3;

    #50;

    $finish;
  end

endmodule
