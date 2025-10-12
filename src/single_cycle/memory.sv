// verilator lint_off UNUSEDSIGNAL
module memory #(
    parameter DEPTH    = 2048,           // Depth of the memory, default is 8192
    parameter MEM_FILE = "data_mem.hex"  // Parameter for the memory file
) (
    input                          clk,         // Clock input
    input      [$clog2(DEPTH)-1:0] addr_i,      // Address input
    input      [             31:0] data_in_i,   // Data input for writing
    input                          write_en_i,  // Write enable control
    output reg [             31:0] data_out_o   // Data output
);

  reg  [              3:0][7:0] mem      [DEPTH/4];  // 32-bit memory array
  wire [$clog2(DEPTH)-3:0]      mem_addr;
  assign mem_addr = addr_i[$clog2(DEPTH)-1:2];

  initial begin
    for (int i = 0; i < DEPTH / 4; i += 1) begin
      mem[i] = '0;
    end
    $readmemh(MEM_FILE, mem);
  end

  always @(posedge clk) begin
    if (write_en_i) begin
      casez (addr_i[1:0])
        2'b00: {mem[mem_addr + 0][3], mem[mem_addr + 0][2], mem[mem_addr + 0][1], mem[mem_addr + 0][0]} <= data_in_i;
        2'b01: {mem[mem_addr + 1][0], mem[mem_addr + 0][3], mem[mem_addr + 0][2], mem[mem_addr + 0][1]} <= data_in_i;
        2'b10: {mem[mem_addr + 1][1], mem[mem_addr + 1][0], mem[mem_addr + 0][3], mem[mem_addr + 0][2]} <= data_in_i;
        2'b11: {mem[mem_addr + 1][2], mem[mem_addr + 1][1], mem[mem_addr + 1][0], mem[mem_addr + 0][3]} <= data_in_i;
      endcase
    end
  end

  always_comb begin
    casez (addr_i[1:0])
      2'b00: data_out_o = {mem[mem_addr+0][3], mem[mem_addr+0][2], mem[mem_addr+0][1], mem[mem_addr+0][0]};
      2'b01: data_out_o = {mem[mem_addr+1][0], mem[mem_addr+0][3], mem[mem_addr+0][2], mem[mem_addr+0][1]};
      2'b10: data_out_o = {mem[mem_addr+1][1], mem[mem_addr+1][0], mem[mem_addr+0][3], mem[mem_addr+0][2]};
      2'b11: data_out_o = {mem[mem_addr+1][2], mem[mem_addr+1][1], mem[mem_addr+1][0], mem[mem_addr+0][3]};
    endcase
  end
endmodule
// verilator lint_on UNUSEDSIGNAL
