# The CEFHALIC PRNG Package

* The CEFHALIC PRNG Package is a set of high-performance Pseudo-Random Number Generators for FPGAs.
* The firmware is implemented in VHDL-2008 for maximum portability.
* The firmware has been tested in simulation using MENTOR/SIEMENS ModelSim SE-64 2019.2 and tested for implementation in Xilinx Vivado 2020.2.
* Software emulations of the firmware is provided, implemented in C++-11, and a Makefile is provided for compiling the software with GCC.
* The Makefile includes automated installation of the TestU01, PractRand and GJrand random-number test-suites.
* The software includes executables for testing the software emulations with TestU01 and PractRand.
* In simulation, the firmware includes debugging output for testing with PractRand, or with TestU01 via the included executable.

More details on usage can be found in the documentation: https://github.com/Cefhalic/PRNG/blob/master/documentation/documentation.pdf

Details of the algorithms, their implementation, resource usage, performance, etc. may be found in the paper, which is currently still in preparation.
