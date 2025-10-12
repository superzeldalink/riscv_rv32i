#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <unistd.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <verilated.h>
#include <verilated_fst_c.h>
#include "Vpipelined.h"

//#define MAX_SIM       1000000
vluint64_t sim_unit = 0;
vluint64_t sim_time = 0;

char string[50];
struct timeval time_dia;
struct timeval time_lcd;
struct timeval time_gcd;
struct timeval time_str;
struct timeval time_twr;
struct timeval time_bin;
struct timeval time_fib;
struct timeval time_fac;
float seconds;
double run_time;
int  clc_str = 0;
int  clc_dia = 0;
int  clc_lcd = 0;
int  clc_gcd = 0;
int  clc_twr = 0;
int  clc_bin = 0;
int  clc_fib = 0;
int  clc_fac = 0;
int  flg_dia = 1;
int  flg_lcd = 1;
int  flg_gcd = 1;
int  flg_twr = 1;
int  flg_bin = 1;
int  flg_fib = 1;
int  flg_fac = 1;


void dut_clock(Vpipelined *dut, VerilatedFstC *vtrace);
void set_diagnosis(Vpipelined *dut);
void get_expected(Vpipelined *dut);
void monitor_proc(Vpipelined *dut);
void monitor_outputs(Vpipelined *dut, VerilatedFstC *vtrace);

void print_passed (char *string) {
  printf("::\033[1;32mPASSED\033[0m:: %s\n", string);
}

void print_failed (char *string) {
  printf("::\033[1;31mFAILED\033[0m:: %s\n", string);
}

void exit_fail (Vpipelined *dut, VerilatedFstC *vtrace) {
  printf("\033[1;31m::ERROR::\033[0m These instructions are NOT working properly!\n");
  printf("\033[1;31m::ERROR::\033[0m Please rework on those or check your I/O connections\n");
  printf("\n---------------------END OF FILE---------------------\n");
  printf("\033[1;31mTerminating...\033[0m\n");
  vtrace->close();
  delete dut;
  exit(EXIT_FAILURE);
}

void exit_pass (Vpipelined *dut, VerilatedFstC *vtrace) {
  printf("\nEstimated run time on FPGA:\n");
  printf("  (1) Clock 27 MHz: %10.3f ms\n", (double) sim_unit/27000.0);
  printf("  (2) Clock 50 MHz: %10.3f ms\n", (double) sim_unit/50000.0);
  printf("\n---------------------END OF FILE---------------------\n");
  vtrace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}


float get_seconds (struct timeval end, struct timeval start){
  long long milisecs;
  milisecs = (end.tv_sec - start.tv_sec)*1000 + (end.tv_usec - start.tv_usec)/1000.0;
  return (float) milisecs/1000.0;
}

void initial(Vpipelined *dut) {
}

void set_reset(Vpipelined *dut) {
  if (sim_unit < 2) {
    dut->rst_ni = 0;
    dut->eval();
  }
  else {
    dut->rst_ni = 1;
    dut->eval();
  }
}

void dut_clock(Vpipelined *dut, VerilatedFstC *vtrace) {
  sim_time = sim_unit * 10 + 1;
  if (vtrace)
    vtrace->dump(sim_time); // Dump values to update inputs

  sim_time = sim_time + 4;
  dut->clk_i = 0;
  dut->eval();
  if (vtrace)
    vtrace->dump(sim_time); // Dump values after negedge

  sim_time = sim_time + 5;
  dut->clk_i = 1;
  dut->eval();
  if (vtrace) {
    vtrace->dump(sim_time); // Dump values after posedge
    //vtrace->flush();
  }
}

void set_diagnosis(Vpipelined *dut) {
  if (sim_unit < 25) {
    dut->io_sw_i = 0xA203B3EE;
    dut->eval();
  }
  if (sim_unit >= 29) {
    dut->io_sw_i = 0x5B6123F9;
    dut->eval();
  }
}

void get_expected(Vpipelined *dut) {
}

void monitor_proc_diagnosis(Vpipelined *dut) {
}

void monitor_cycle (Vpipelined *dut, VerilatedFstC *vtrace) {

  if (dut->io_ledg_o == 0x1 && flg_dia) {
    clc_dia  = sim_unit;
    flg_dia  = 0;
    gettimeofday (&time_dia, NULL);
    seconds = get_seconds(time_dia, time_str);
    printf("\n-=- TESTBENCHES -=-\n");
    printf("  # .Status..      Name      ..  Cycles  ..  Sim-Time \n");
    printf("::0::");
    printf("\033[1;32mPASSED\033[0m");
    printf(":: Diagnosis      :: %8d :: %7.3f s\n", clc_dia, seconds);
  }

  if (dut->io_ledg_o == 0x3 && flg_lcd ) {
    clc_lcd  = sim_unit;
    flg_lcd  = 0;
    gettimeofday (&time_lcd, NULL);
    seconds = get_seconds(time_lcd, time_dia);
  }

  if (dut->io_ledg_o == 0x7 && flg_fib ) {
    clc_fib  = sim_unit;
    flg_fib  = 0;
    gettimeofday (&time_fib, NULL);
    seconds = get_seconds(time_fib, time_lcd);
    printf("::1::");
    if (dut->io_ledr_o == 0x610) {
      printf("\033[1;32mPASSED\033[0m");
    }
    else {
      printf("\033[1;31mFAILED\033[0m");
    }
    printf(":: Fibonacci      :: %8d :: %7.3f s\n", clc_fib - clc_lcd, seconds);
  }

  if (dut->io_ledg_o == 0xF && flg_fac ) {
    clc_fac  = sim_unit;
    flg_fac  = 0;
    gettimeofday (&time_fac, NULL);
    seconds = get_seconds(time_fac, time_fib);
    printf("::2::");
    if (dut->io_ledr_o == 0x40320) {
      printf("\033[1;32mPASSED\033[0m");
    }
    else {
      printf("\033[1;31mFAILED\033[0m");
    }
    printf(":: Factorial      :: %8d :: %7.3f s\n", clc_fac - clc_fib, seconds);
  }

  if (dut->io_ledg_o == 0x1F && flg_gcd ) {
    clc_gcd  = sim_unit;
    flg_gcd  = 0;
    gettimeofday (&time_gcd, NULL);
    seconds = get_seconds(time_gcd, time_fac);
    printf("::3::");
    if (dut->io_ledr_o == 0x1556) {
      printf("\033[1;32mPASSED\033[0m");
    }
    else {
      printf("\033[1;31mFAILED\033[0m");
    }
    printf(":: GCD            :: %8d :: %7.3f s\n", clc_gcd - clc_fac, seconds);
  }

  if (dut->io_ledg_o == 0x3F && flg_twr ) {
    clc_twr  = sim_unit;
    flg_twr  = 0;
    gettimeofday (&time_twr, NULL);
    seconds = get_seconds(time_twr, time_gcd);
    printf("::4::");
    if (dut->io_ledr_o == 0x1023) {
      printf("\033[1;32mPASSED\033[0m");
    }
    else {
      printf("\033[1;31mFAILED\033[0m");
    }
    printf(":: Tower of Hanoi :: %8d :: %7.3f s\n", clc_twr - clc_gcd, seconds);
  }

  if (dut->io_ledg_o == 0x7F && flg_bin ) {
    clc_bin  = sim_unit;
    flg_bin  = 0;
    gettimeofday (&time_bin, NULL);
    seconds = get_seconds(time_bin, time_twr);
    printf("::5::");
    if (dut->io_ledr_o == 0x10) {
      printf("\033[1;32mPASSED\033[0m");
    }
    else {
      printf("\033[1;31mFAILED\033[0m");
    }
    printf(":: Binary Search  :: %8d :: %7.3f s\n", clc_bin - clc_twr, seconds);
    exit_pass(dut, vtrace);
  }
}


int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

  // Instantiate the design
	Vpipelined *dut = new Vpipelined;

  // Trace generating
  Verilated::traceEverOn(true);
  VerilatedFstC *vtrace = new VerilatedFstC;
  dut->trace(vtrace, 2); // trace down to 2 hierarchy
  vtrace->open("wave.fst");
  vtrace->dump(0);

  // Initial setups
  srand(time(NULL));
  initial(dut);
  dut->eval();

  printf("\n\n---------------------REPORT FILE---------------------\n\n");

  gettimeofday (&time_str, NULL);

  // Check procedure
  //while (sim_unit){
  while (1){
    set_reset(dut);
    dut_clock(dut, vtrace);
    set_diagnosis(dut);
    dut->eval();
    monitor_proc_diagnosis(dut);
    get_expected(dut);
    monitor_cycle(dut, vtrace);
    sim_unit++;
	}

  vtrace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}
