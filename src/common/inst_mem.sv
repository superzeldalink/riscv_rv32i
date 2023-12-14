// verilator lint_off UNUSEDSIGNAL
module inst_mem #(parameter DEPTH = 8192 // Depth of the memory, default is 8192
) (
  input      [$clog2(DEPTH)-1:0] addr_i    , // Address input
  output reg [             31:0] data_out_o  // Data output
);

  wire [$clog2(DEPTH)-3:0] mem_addr;
  assign mem_addr = addr_i[$clog2(DEPTH)-1:2];

  reg [3:0][7:0] imem[DEPTH/4]; // 32-bit memory array

  initial begin
    $readmemh("imem.hex", imem);
  end

  always_comb begin : proc_data
    data_out_o = imem[mem_addr][3:0];
  end

endmodule

// verilator lint_on UNUSEDSIGNAL
