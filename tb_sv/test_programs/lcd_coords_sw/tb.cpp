#include <verilated.h> // Defines common routines
#include <verilated_fst_c.h>
#include <verilated_vcd_c.h> // VCD tracing
#include "Vpipelined.h"   // Include the Verilator model
#include <assert.h>

VerilatedFstC *tfp = nullptr;

vluint64_t main_time = 0;                 // Current simulation time
const vluint64_t sim_duration = 80000000; // Simulation duration in time units

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

    int data_c = -1;
    vluint64_t push_time = 0;

    // Simulation loop
    while (!Verilated::gotFinish() && main_time < sim_duration)
    {
        top->clk_i = !top->clk_i;             // Your clock generation logic
        top->rst_ni = main_time < 20 ? 0 : 1; // Your reset generation logic

        if (main_time == 8000000 || main_time == 14000000 || main_time == 22000000 || main_time == 30000000 || main_time == 36000000 || main_time == 43000000)
        {
            top->io_keys_i = ~0x1;
            push_time = main_time;
        }
        else if (main_time == push_time + 400)
        {
            data_c++;
        }
        else if (main_time > push_time + 200)
        {
            top->io_keys_i = ~0x0;
        }

        switch (data_c)
        {
        case 0:
            top->io_sw_i = 2;
            break;
        case 1:
            top->io_sw_i = 5;
            break;
        case 2:
            top->io_sw_i = 7;
            break;
        case 3:
            top->io_sw_i = 3;
            break;
        case 4:
            top->io_sw_i = 1;
            break;
        case 5:
            top->io_sw_i = 2;
            break;
        }

        // Evaluate the design
        top->eval();

        // Monitor PC_debug
        // printf("%d: PC_debug = %08x\n", main_time, top->PC_debug);

        // You can add your testbench assertions and stimulus

        // Dump waveform data
        tfp->dump(main_time);

        // Advance simulation time
        main_time += 10; // Assuming 1ps/1ps timescale, 10 time units per cyclee
    }

    // Close VCD trace file
    tfp->close();

    // Clean up
    delete top;
    exit(0);
}
