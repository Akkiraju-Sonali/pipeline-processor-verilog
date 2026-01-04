# Pipelined Processor(Verilog)
Simple pipelined processor in Verilog (Vivado)
## Overview
This project implements a simple 4-stage pipelined processor using Verilog HDL.
The processor supports basic instructions such as ADD, SUB, and LOAD.
The design is simulated using Xilinx Vivado.

## Pipeline Stages
1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Write Back (WB)

Pipeline registers are used between stages to enable concurrent instruction execution.

## Instructions Supported
- ADD
- SUB
- LOAD

## Files
- pipeline_processor.v : Verilog design of pipelined processor
- pipeline_tb.v        : Testbench for simulation
- README.md            : Project documentation
- Simulation_Report_PP.pdf : simulation report documentation
## Tools Used
- Verilog HDL
- Xilinx Vivado
- Vivado Simulator

## Simulation
Behavioral simulation was performed in Vivado.
Waveforms confirm correct pipeline operation and register updates.

## Author
Akkiraju Sonali Phani Sai
