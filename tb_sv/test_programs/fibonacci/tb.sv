`timescale 1ns / 1ps

module tb;
    initial begin
     $fsdbDumpfile("top.fsdb");
     $fsdbDumpvars(0,tb, "+all");
    end

    // Time parameters (matching the C++ timing)
    parameter SIM_DURATION = 10_000_000;
    
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
    
    // Fibonacci tracking variables
    integer prev_val = 0;
    integer curr_val = 0;
    integer n = 2;
    integer max_n = 46;
    integer fa = 0;
    integer fb = 1;
    integer fc;
    integer expected;
    
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
    
    // Clock generation (5ns period, matching main_time += 5)
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        clk_i = 0;
        rst_ni = 0;
        io_sw_i = 32'h0;
        io_keys_i = 32'h0;
        
        // Apply reset sequence (matches C++: rst_ni = 0 for first 20 time units)
        #20 rst_ni = 1;
        
        // Wait a bit for stable operation
        #100;
    end
    
    // Main monitoring process
    initial begin
        // Wait for reset to be released and system to stabilize
        #120;
        
        while (n <= max_n && $time < SIM_DURATION) begin
            // Wait for output change
            wait(io_ledr_o !== prev_val);
            
            // Sample current value
            curr_val = io_ledr_o;
            
            // Calculate expected Fibonacci value
            fc = fa + fb;
            fa = fb;
            fb = fc;
            expected = fc;
            
            // Check and report result
            if (curr_val == expected) begin
                $display("%0t: n = %0d, expected = %0d, LEDR = %0d => PASSED", 
                         $time, n, expected, curr_val);
            end else begin
                $display("%0t: n = %0d, expected = %0d, LEDR = %0d => FAILED", 
                         $time, n, expected, curr_val);
            end
            
            // Update tracking variables
            prev_val = curr_val;
            n++;
            
            // Small delay to avoid race conditions
            #1;
        end
        
        // Check for timeout
        if ($time >= SIM_DURATION) begin
            $display("Simulation timed out!");
        end
        
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #SIM_DURATION;
        if (n <= max_n) begin
            $display("Simulation timed out at time %0t!", $time);
            $finish;
        end
    end
    
endmodule

