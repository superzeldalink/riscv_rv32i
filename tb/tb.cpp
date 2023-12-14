#include <verilated.h> // Defines common routines
#include <verilated_fst_c.h>
#include <verilated_vcd_c.h> // VCD tracing
#include "Vsingle_cycle.h"   // Include the Verilator model
#include <assert.h>

VerilatedFstC *tfp = nullptr;

vluint64_t main_time = 0;              // Current simulation time
const vluint64_t sim_duration = 10000000; // Simulation duration in time units

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);

    // Initialize Verilator
    Vsingle_cycle *top = new Vsingle_cycle;

    // Enable VCD trace
    Verilated::traceEverOn(true);

    // Initialize the VCD trace file
    tfp = new VerilatedFstC;
    top->trace(tfp, 99); // Trace 99 levels of hierarchy
    tfp->open("wave.fst");

    // Set initial values
    top->clk_i = 0;
    top->rst_ni = 0;
    // Reset the circuit
    top->rst_ni = 0;
    top->eval(); // Evaluate initial values

    int prev_val = 0;
    int curr_val = 0;
    int n = 2;
    int max_n = 46;
    unsigned int expected = 0;
    unsigned int fa = 0, fb = 1, fc;

    // Simulation loop
    while (!Verilated::gotFinish() && main_time < sim_duration && n <= max_n)
    {
        top->clk_i = !top->clk_i;             // Your clock generation logic
        top->rst_ni = main_time < 20 ? 0 : 1; // Your reset generation logic

        // Evaluate the design
        top->eval();
        
        // Monitor PC_debug
        curr_val = top->io_ledr_o;

        if (curr_val != prev_val)
        {
            fc = fa + fb;
            fa = fb;
            fb = fc;
            expected = fc;
            if (curr_val == expected)
            {
                printf("%4u: n = %2u, expected = %10u, LEDR = %10u => PASSED\n", main_time, n, expected, curr_val);
            }
            else if (main_time >= sim_duration)
            {
                printf("Simulation timed out!\n");
                printf("%4u: n = %2u, expected = %10u, LEDR = %10u => FAILED\n", main_time, n, expected, curr_val);
            }
            prev_val = curr_val;
            n++;
        }

        // You can add your testbench assertions and stimulus

        // Dump waveform data
        tfp->dump(main_time);

        // Advance simulation time
        main_time += 5; // Assuming 1ps/1ps timescale, 10 time units per cyclee
    }

    // Close VCD trace file
    tfp->close();

    // Clean up
    delete top;
    exit(0);
}
