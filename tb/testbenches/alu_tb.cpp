#include <stdio.h>
#include <assert.h>
#include <verilated.h>
#include <verilated_fst_c.h>
#include <iostream>
#include <ctime>
#include <cstdlib>
#include "Valu.h"

// ALU operations
#define ADD 0
#define SUB 8
#define SLT 2
#define SLTU 3
#define XOR 4
#define OR 6
#define AND 7
#define SLL 1
#define SRL 5
#define SRA 13
#define B 9
#define MAX_SIM 1000

VerilatedFstC *tfp = nullptr;
// ALU function
int alu_tb(int inputA, int inputB, int sel)
{
    switch (sel)
    {
    case ADD:
        return inputA + inputB;
    case SUB:
        return inputA - inputB;
    case SLT:
        return (inputA < inputB) ? 1 : 0;
    case SLTU:
        return (unsigned)inputA < (unsigned)inputB ? 1 : 0;
    case XOR:
        return inputA ^ inputB;
    case OR:
        return inputA | inputB;
    case AND:
        return inputA & inputB;
    case SLL:
        return inputA << (inputB & 0x1F);
    case SRL:
        return (unsigned)inputA >> (inputB & 0x1F);
    case SRA:
        return inputA >> (inputB & 0x1F);
    case B:
        return inputB;
    default:
        return 0; // Invalid operation
    }
}

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true); // Enable waveform tracing

    // Instantiate the DUT (Design Under Test)
    Valu *alu = new Valu;

    // Initialize the VCD trace file
    tfp = new VerilatedFstC;
    alu->trace(tfp, 99); // Trace all levels
    tfp->open("wave.fst");

    // Seed the random number generator
    std::srand(std::time(nullptr));

    int expected_output, output;

    for (int i = 0; i < MAX_SIM; i++)
    {

        alu->inA = rand();
        alu->inB = rand();

        for (int j = 0; j < 16; j++)
        {
            alu->sel = j;

            alu->eval();

            output = alu->data;
            expected_output = alu_tb(alu->inA, alu->inB, alu->sel);

            printf("%x\t%x\t%x\t%x\t%x\n", alu->inA, alu->inB, alu->sel, output, expected_output);
            assert(output == expected_output);
        }
    }

    printf("All tests passed!\n");

    // Close the VCD trace file and clean up
    tfp->close();
    delete alu;
    delete tfp;
    return 0;
}
