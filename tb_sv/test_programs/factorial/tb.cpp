#include <verilated.h> // Defines common routines
#include <verilated_fst_c.h>
#include <verilated_vcd_c.h> // VCD tracing
#include "Vpipelined.h"   // Include the Verilator model
#include <assert.h>

int factorial(int n)
{
    // single line to find factorial
    return (n == 1 || n == 0) ? 1 : n * factorial(n - 1);
}

VerilatedFstC *tfp = nullptr;

int runtest(int n)
{

    vluint64_t main_time = 0;              // Current simulation time
    const vluint64_t sim_duration = 11000; // Simulation duration in time units

    // Initialize Verilator
    Vpipelined *top = new Vpipelined;

    // Initialize the VCD trace file
    tfp = new VerilatedFstC;
    top->trace(tfp, 99); // Trace 99 levels of hierarchy
    tfp->open("wave.fst");

    int expected = factorial(n);

    printf("%4d -- N=%2d, expected: %u\n", main_time, n, expected);

    // Set initial values
    top->clk_i = 0;
    top->rst_ni = 0;
    // Reset the circuit
    top->rst_ni = 0;
    top->io_sw_i = n;
    top->eval(); // Evaluate initial values

    // Simulation loop
    while (1)
    {
        top->clk_i = !top->clk_i;             // Your clock generation logic
        top->rst_ni = main_time < 20 ? 0 : 1; // Your reset generation logic

        // Evaluate the design
        top->eval();

        // Dump waveform data
        tfp->dump(main_time);

        // Monitor PC_debug
        // printf("%u: PC_debug = %08x\n", main_time, top->PC_debug);

        // You can add your testbench assertions and stimulus
        if (top->io_ledr_o == expected)
        {
            printf("%4d --    LEDR output: %u => PASSED\n", main_time, top->io_ledr_o);
            printf("Total time spent: %d\n", main_time);
            break;
        }
        else if (main_time >= sim_duration)
        {
            printf("Simulation timed out!\n");
            printf("%4d --    LEDR output: %u => FAILED\n", main_time, top->io_ledr_o);
            tfp->close();
            return 0;
        }

        // Advance simulation time
        main_time += 5; // Assuming 1ps/1ps timescale, 10 time units per cycle
    }
           
    tfp->close();

    // Clean up
    delete top;
    return 1;
}

int main()
{
    for (int i = 12; i < 13; i++)
    {
        // Enable VCD trace
        Verilated::traceEverOn(true);

        int status = runtest(i);
        
        if(status == 0) break;
    }

    exit(0);
}