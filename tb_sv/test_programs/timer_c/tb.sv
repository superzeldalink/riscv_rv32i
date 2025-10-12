`timescale 1ns / 1ps

module tb;
    initial begin
     $fsdbDumpfile("top.fsdb");
     $fsdbDumpvars(0,tb, "+all");
    end

    // Parameters
    parameter SIM_DURATION = 1_200_000;
    
    // Signals
    reg clk_i;
    reg rst_ni;
    reg [31:0] io_sw_i;
    reg [31:0] io_keys_i;
    wire [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o;
    wire [31:0] io_lcd_o;
    wire [31:0] io_ledr_o;
    wire [31:0] io_ledg_o;
    wire [31:0] PC_debug;
    
    // DUT instantiation
    pipelined uut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .io_sw_i(io_sw_i),
        .io_keys_i(io_keys_i),
        .io_hex0_o(io_hex0_o),
        .io_hex1_o(io_hex1_o),
        .io_hex2_o(io_hex2_o),
        .io_hex3_o(io_hex3_o),
        .io_hex4_o(io_hex4_o),
        .io_hex5_o(io_hex5_o),
        .io_hex6_o(io_hex6_o),
        .io_hex7_o(io_hex7_o),
        .io_lcd_o(io_lcd_o),
        .io_ledr_o(io_ledr_o),
        .io_ledg_o(io_ledg_o),
        .PC_debug(PC_debug)
    );
    
    // Clock generation (10ns period)
    initial begin
        clk_i = 0;
        forever #10 clk_i = ~clk_i;
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        clk_i = 0;
        rst_ni = 0;
        io_sw_i = 0;      // Load A value
        io_keys_i = 0;    // Load B value
        
        // Apply reset sequence (rst_ni = 0 for first 20 time units)
        #20 rst_ni = 1;
        
        // Wait for simulation
        #100;
    end
    
    // Main monitoring process
    initial begin
        // Wait for reset to be released and system to stabilize
        #120;
        
        while ($time < SIM_DURATION) begin
            // Check if we got the expected result
            if (io_ledr_o == 'h2) begin
                $display("LEDR: %0d", io_ledr_o);
                $display("Total time spent: %0t", $time);
                $finish;
            end
            
            // Wait for next clock edge
            @(posedge clk_i);
        end
        
        // Timeout reached
        $display("Total time spent: %0t", $time);
        $display("Simulation timed out!");
        $finish;
    end
    
endmodule

