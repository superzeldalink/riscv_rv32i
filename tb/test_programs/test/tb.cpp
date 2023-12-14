#include <verilated.h> // Defines common routines
#include <verilated_fst_c.h>
#include <verilated_vcd_c.h> // VCD tracing
#include "Vpipelined.h"   // Include the Verilator model
#include <assert.h>

VerilatedFstC *tfp = nullptr;

vluint64_t main_time = 0;              // Current simulation time
const vluint64_t sim_duration = 10000; // Simulation duration in time units

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);

    // Initialize Verilator
    Vpipelined *top = new Vpipelined;

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

    // Simulation loop
    while (!Verilated::gotFinish() && main_time < sim_duration)
    {
        top->clk_i = !top->clk_i;             // Your clock generation logic
        top->rst_ni = main_time < 25 ? 0 : 1; // Your reset generation logic

        // Evaluate the design
        top->eval();

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
