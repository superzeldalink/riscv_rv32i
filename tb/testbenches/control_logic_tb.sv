module testbench ();
  // Inputs and outputs for the testbench
  reg  [31:0] inst_i     ;
  reg         BrEq, BrLT;
  wire [ 4:0] imm_sel_o  ;
  wire [ 3:0] alu_sel_o  ;
  wire        pc_sel_o, regWEn_o, BrUn_o, b_sel_o, a_sel_o, memRW_o;
  wire [ 1:0] wb_sel_o   ;
  wire [ 2:0] ld_st_sel_w;

  // Instantiate the module you want to test
  control_logic uut (
    .inst_i     (inst_i     ),
    .BrEq       (BrEq       ),
    .BrLT       (BrLT       ),
    .imm_sel_o  (imm_sel_o  ),
    .alu_sel_o  (alu_sel_o  ),
    .pc_sel_o   (pc_sel_o   ),
    .regWEn_o   (regWEn_o   ),
    .BrUn_o     (BrUn_o     ),
    .b_sel_o    (b_sel_o    ),
    .a_sel_o    (a_sel_o    ),
    .memRW_o    (memRW_o    ),
    .wb_sel_o   (wb_sel_o   ),
    .ld_st_sel_o(ld_st_sel_w)
  );

  wire [19:0] output_data;
  reg  [19:0] expected   ;
  assign output_data = {pc_sel_o, imm_sel_o, BrUn_o, a_sel_o, b_sel_o, alu_sel_o, memRW_o, regWEn_o, wb_sel_o, ld_st_sel_w};

  reg [10:0] input_test;
  assign inst_i = {1'b?, input_test[8], 15'b???????????????, input_test[7:5], 5'b?????, input_test[4:0], 2'b??};
  assign BrLT   = input_test[10];
  assign BrEq   = input_test[9];

  // Define test cases and expected outputs
  always @(input_test) begin
    casez (input_test)
      11'b??000001100 : begin expected = 20'b0??????0000000101???; $write("ADD: "); end
      11'b??100001100 : begin expected = 20'b0??????0010000101???; $write("SUB: "); end
      11'b??010001100 : begin expected = 20'b0??????0001000101???; $write("XOR: "); end
      11'b??011001100 : begin expected = 20'b0??????0001100101???; $write("OR: "); end
      11'b??011101100 : begin expected = 20'b0??????0001110101???; $write("AND: "); end
      11'b??000101100 : begin expected = 20'b0??????0000010101???; $write("SLL: "); end
      11'b??010101100 : begin expected = 20'b0??????0001010101???; $write("SRL: "); end
      11'b??110101100 : begin expected = 20'b0??????0011010101???; $write("SRA: "); end
      11'b??001001100 : begin expected = 20'b0??????0000100101???; $write("SLT: "); end
      11'b??001101100 : begin expected = 20'b0??????0000110101???; $write("SLTU: "); end

      11'b???00000100 : begin expected = 20'b000001?0100000101???; $write("ADDI: "); end
      11'b???10000100 : begin expected = 20'b000001?0101000101???; $write("XORI: "); end
      11'b???11000100 : begin expected = 20'b000001?0101100101???; $write("ORI: "); end
      11'b???11100100 : begin expected = 20'b000001?0101110101???; $write("ANDI: "); end
      11'b??000100100 : begin expected = 20'b000001?0100010101???; $write("SLLI: "); end
      11'b??010100100 : begin expected = 20'b000001?0101010101???; $write("SRLI: "); end
      11'b??110100100 : begin expected = 20'b000001?0111010101???; $write("SRAI: "); end
      11'b???01000100 : begin expected = 20'b000001?0100100101???; $write("SLTI: "); end
      11'b???01100100 : begin expected = 20'b000001?0100110101???; $write("SLTIU: "); end

      11'b???00000000 : begin expected = 20'b000001?0100000100000; $write("LB: "); end
      11'b???00100000 : begin expected = 20'b000001?0100000100001; $write("LH: "); end
      11'b???01000000 : begin expected = 20'b000001?0100000100010; $write("LW: "); end
      11'b???10000000 : begin expected = 20'b000001?0100000100100; $write("LBU: "); end
      11'b???10100000 : begin expected = 20'b000001?0100000100101; $write("LHU: "); end

      11'b???00001000 : begin expected = 20'b000010?01000010??000; $write("SB: "); end
      11'b???00101000 : begin expected = 20'b000010?01000010??001; $write("SH: "); end
      11'b???01001000 : begin expected = 20'b000010?01000010??010; $write("SW: "); end

      11'b?0?00011000 : begin expected = 20'b000100?11000000?????; $write("BEQ: "); end
      11'b?1?00011000 : begin expected = 20'b100100?11000000?????; $write("BEQ: "); end
      11'b?0?00111000 : begin expected = 20'b100100?11000000?????; $write("BNE: "); end
      11'b?1?00111000 : begin expected = 20'b000100?11000000?????; $write("BNE: "); end
      11'b1??10011000 : begin expected = 20'b100100011000000?????; $write("BLT: "); end
      11'b0??10011000 : begin expected = 20'b000100011000000?????; $write("BLT: "); end
      11'b1??11011000 : begin expected = 20'b100100111000000?????; $write("BLTU: "); end
      11'b0??11011000 : begin expected = 20'b000100111000000?????; $write("BLTU: "); end
      11'b01?10111000 : begin expected = 20'b100100011000000?????; $write("BGE: "); end
      11'b00?10111000 : begin expected = 20'b100100011000000?????; $write("BGE: "); end
      11'b10?10111000 : begin expected = 20'b000100011000000?????; $write("BGE: "); end
      11'b01?11111000 : begin expected = 20'b100100111000000?????; $write("BGEU: "); end
      11'b00?11111000 : begin expected = 20'b100100111000000?????; $write("BGEU: "); end
      11'b10?11111000 : begin expected = 20'b000100111000000?????; $write("BGEU: "); end

      11'b??????11011 : begin expected = 20'b110000?1100000110???; $write("JAL: "); end
      11'b??????11001 : begin expected = 20'b100001?0100000110???; $write("JALR: "); end
      11'b??????01101 : begin expected = 20'b001000??110010101???; $write("LUI: "); end
      11'b??????00101 : begin expected = 20'b001000?1100000101???; $write("AUIPC: "); end
      default         : begin expected = 20'b?????????????????; $write("NA: "); end // Default case with don't care output
    endcase
  end

  integer passed = 0;

  initial begin
    // Create a loop to iterate through the test cases
    for (int i = 0; i < 2048; i = i + 1) begin
      input_test = i; // Set the current test case input
      #10; // Allow some time for the module to process

      // Check the output with "don't care" (?) bits
      if (output_data inside expected) begin
        $display("PASSED");
        passed += 1;
      end else begin
        $display("FAILED");
      end
    end

    $display("Pass rate: %d/%d", passed, 2048);

    // End the simulation
    $finish;
  end

endmodule