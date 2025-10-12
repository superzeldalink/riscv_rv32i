module fu_tb ();

  // Parameters
  parameter CLK_PERIOD = 10 ; // Clock period in time units
  parameter SIM_TIME   = 100; // Simulation time in time units

  initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars(0,fu_tb);
  end

  // Signals
  reg  [31:0] inst_IF_i, inst_ID_i, inst_EX_i, inst_MEM_i, inst_WB_i;
  wire        regWEn_MEM_i, regWEn_WB_i;
  reg  [ 1:0] forward_sel_A_o, forward_sel_B_o;
  reg         pc_plus_four_selA, pc_plus_four_selB;

  assign regWEn_MEM_i = ~(inst_MEM_i[6:2] == 5'b11000) & ~(inst_MEM_i[6:2] == 5'b01000);
  assign regWEn_WB_i  = ~(inst_WB_i[6:2] == 5'b11000) & ~(inst_WB_i[6:2] == 5'b01000);

  // Instantiate the forwarding_unit module
  forwarding_unit dut (
    .inst_EX_i        (inst_EX_i        ),
    .inst_MEM_i       (inst_MEM_i       ),
    .inst_WB_i        (inst_WB_i        ),
    .regWEn_MEM_i     (regWEn_MEM_i     ),
    .regWEn_WB_i      (regWEn_WB_i      ),
    .forward_sel_A_o  (forward_sel_A_o  ),
    .forward_sel_B_o  (forward_sel_B_o  ),
    .pc_plus_four_selA(pc_plus_four_selA),
    .pc_plus_four_selB(pc_plus_four_selB)
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
      #(2*CLK_PERIOD) $display("inst_EX: %h, ForwardA: %b, ForwardB: %b, PC_fw_A: %b, PC_fw_B: %b", inst_EX_i, forward_sel_A_o, forward_sel_B_o, pc_plus_four_selA, pc_plus_four_selB);
    join_any
  endtask

  task case1;
//   add x5, x3, x2  #
//   xor x6, x5, x1  # ALU_MEM -> A
//   sub x9, x3, x5  # WB -> B
//   or  x2, x7, x5  #
//   sll x4, x5, x5  #
    send_and_check(32'h002182B3);
    send_and_check(32'h0012C333);
    send_and_check(32'h405184B3);
    send_and_check(32'h0053E133);
    send_and_check(32'h00529233);
  endtask

  task case2;
// add x1, x0, x2
// add x2, x0, x3
// sub x3, x1, x2  # ALU_MEM -> A, WB -> B
    send_and_check(32'h002000B3);
    send_and_check(32'h00300133);
    send_and_check(32'h402081B3);
  endtask

  task case3;
// jal x1, 4
// add x2, x1, x0  # pc+4_MEM -> A
// add x3, x0, x1  # pc+4_WB -> B
// jal x4, 4
// jal x5, 8
// add x6, x4, x5  # pc+4_WB -> A, pc+4_MEM -> B
    send_and_check(32'h004000EF);
    send_and_check(32'h00008133);
    send_and_check(32'h001001B3);
    send_and_check(32'h0040026F);
    send_and_check(32'h008002EF);
    send_and_check(32'h00520333);
  endtask

  // Stimulus
  initial begin
    // Initialize inputs
    case3;


    #50;

    $finish;
  end

endmodule
