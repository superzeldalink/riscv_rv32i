#include <verilated.h> // Defines common routines
#include <verilated_fst_c.h>
#include <verilated_vcd_c.h> // VCD tracing
#include "Vpipelined.h"   // Include the Verilator model
#include <assert.h>

VerilatedFstC *tfp = nullptr;

vluint64_t main_time = 0;             // Current simulation time
const vluint64_t sim_duration = 1000; // Simulation duration in time units
vluint64_t time_unit = 0; 

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
        top->rst_ni = main_time < 20 ? 0 : 1; // Your reset generation logic
        top->io_sw_i = 0xACBD;
        // Evaluate the design
        top->eval();

        if (top->clk_i)
        {
            // Monitor PC_debug
            printf("%d: PC_debug = %08x, time_unit = %d\n", main_time, top->PC_debug, time_unit);
            // lw and addi
            // if(time_unit == 5) {
            //     assert(top->io_ledr_o == top->io_sw_i);
            // } else if(time_unit == 9) {
            //     assert(top->io_ledg_o == top->io_sw_i + 10);
            // } 
            if(time_unit == 9) {
                top->io_ledr_o == top->io_sw_i - 3;
            // sub and add
            }
            time_unit = main_time < 20 ? 0 : time_unit + 1;
            
        }
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


// #include <verilated.h> // Defines common routines
// #include <verilated_fst_c.h>
// #include <verilated_vcd_c.h> // VCD tracing
// #include "Vpipelined.h"   // Include the Verilator model
// #include <assert.h>

// char string[50];

// VerilatedFstC *tfp = nullptr;

// vluint64_t main_time = 0;            // Current simulation time
// const vluint64_t sim_duration = 1000; // Simulation duration in time units

// vluint64_t time_unit = 0; // Current simulation time

// void exit_fail (Vpipelined *top, VerilatedFstC *vtrace) {
//   printf("\033[1;31m::ERROR::\033[0m These instructions are NOT working properly!\n");
//   printf("\033[1;31m::ERROR::\033[0m Please rework on those or check your I/O connections\n");
//   printf("\n---------------------END OF FILE---------------------\n");
//   printf("\033[1;31mTerminating...\033[0m\n");
//   vtrace->close();
//   delete top;
//   exit(EXIT_FAILURE);
// }

// void exit_pass (Vpipelined *top, VerilatedFstC *vtrace) {
//   printf("\n---------------------END OF FILE---------------------\n");
//   vtrace->close();
//   delete top;
//   exit(EXIT_SUCCESS);
// }

// void print_passed (char *string) {
//   printf("::\033[1;32mPASSED\033[0m:: %s\n", string);
// }

// void print_failed (char *string) {
//   printf("::\033[1;31mFAILED\033[0m:: %s\n", string);
// }

// int main(int argc, char **argv)
// {
//     Verilated::commandArgs(argc, argv);

//     // Initialize Verilator
//     Vpipelined *top = new Vpipelined;

//     // Enable VCD trace
//    Verilated::traceEverOn(true);

//     // Initialize the VCD trace file
//     VerilatedFstC *vtrace = new VerilatedFstC;
//     top->trace(vtrace, 2); // trace down to 2 hierarchy
//     vtrace->open("wave.fst");
//     vtrace->dump(0);
//     // Set initial values
//     top->clk_i = 0;
//     top->rst_ni = 0;
//     // Reset the circuit
//     top->rst_ni = 0;
//     top->io_sw_i = 0xABCDE;
//     top->eval(); // Evaluate initial values
//     strcpy(string, "LW, SW");

//     // Simulation loop
//     while (!Verilated::gotFinish() && main_time < sim_duration)
//     {
//         top->clk_i = !top->clk_i;             // Your clock generation logic
//         top->rst_ni = main_time < 20 ? 0 : 1; // Your reset generation logic
        
//         // Evaluate the design
//         top->eval();

//         if (top->clk_i)
//         {
//             // Monitor PC_debug
//             printf("%d: PC_debug = %08x, time_unit = %d\n", main_time, top->PC_debug, time_unit);
//             // lw and addi
//             // if(time_unit == 5) {
//             //     assert(top->io_ledr_o == top->io_sw_i);
//             // } else if(time_unit == 9) {
//             //     assert(top->io_ledg_o == top->io_sw_i + 10);
//             // } 

//             // sub and add
            
//             if(time_unit == 9 && (top->io_ledr_o == top->io_sw_i - 3)) {
//                 // assert(top->io_ledr_o == top->io_sw_i - 3);
//                 print_passed(string);
//             } else {
//                 print_failed(string);
//                 exit_fail(top, vtrace);
//             }
//             time_unit = main_time < 20 ? 0 : time_unit + 1;
            
//         }

//         // You can add your testbench assertions and stimulus

//         // Dump waveform data
//         vtrace->dump(main_time);

//         // Advance simulation time
//         main_time += 10; // Assuming 1ps/1ps timescale, 10 time units per cyclee
//     }

//     // // Close VCD trace file
//     // vtrace>close();

//     // Clean up
//     delete top;
//     exit(EXIT_SUCCESS);
// }
