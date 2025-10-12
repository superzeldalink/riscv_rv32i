// verilator lint_off UNUSEDSIGNAL
module inst_mem #(
    parameter DEPTH = 2048  // Depth of the memory, default is 2048=2KB
) (
    input      [$clog2(DEPTH)-1:0] addr_i,     // Address input
    output reg [             31:0] data_out_o  // Data output
);

  wire [$clog2(DEPTH/4)-1:0] mem_addr;
  assign mem_addr = addr_i[$clog2(DEPTH)-1:2];

  reg [31:0] imem[DEPTH/4];  // 32-bit memory array

  initial begin
    for (int i = 0; i < DEPTH; i += 1) begin
      imem[i] = '0;
    end
    $readmemh("imem.hex", imem);
  end

  always_comb begin : proc_data
    data_out_o = imem[mem_addr];
  end

endmodule

// verilator lint_on UNUSEDSIGNAL
