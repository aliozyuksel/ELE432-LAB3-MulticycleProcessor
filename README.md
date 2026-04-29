# ELE 432 Lab 3: Multicycle RISC-V Processor

This repository contains the SystemVerilog RTL implementation, testbench, and simulation files for a **Multicycle RISC-V Processor**. This project was developed as Preliminary Work 3 for the ELE 432 (Digital Design & Computer Architecture) course at Hacettepe University.

## Project Description
The processor is designed using a multicycle architecture, which divides the execution of an instruction into multiple clock cycles (FETCH, DECODE, EXECUTE, MEMORY, WRITEBACK). Unlike a single-cycle processor, this design utilizes a **Unified Memory** for both instructions and data, significantly improving hardware utilization.

The control unit is driven by an FSM (Finite State Machine) that dynamically generates the necessary control signals for the datapath components across different clock cycles.

## Repository Structure

The project is structured hierarchically. The main modules are:

* **`top.sv`**: The highest-level wrapper module that instantiates the RISC-V processor core and the Unified Memory.
* **`riscv.sv`**: The processor core, connecting the `controller` and `datapath` modules.
* **`controller.sv`**: The brain of the processor. It includes:
    * `mainfsm.sv`: The main state machine controlling the multi-cycle flow.
    * `aludec.sv`: The ALU control decoder.
    * `instrdec.sv`: The immediate extender decoder.
* **`datapath.sv`**: The physical data routing structure, consisting of registers, multiplexers, and the ALU.
* **`utility.sv`**: Contains reusable basic building blocks (`mux2`, `mux3`, `flopr`, `flopenr`, `alu`, `regfile`, `extend`).
* **`mem.sv`**: The unified memory module that reads instructions/data from `riscvtest2.txt`.
* **`riscv_testbench.sv`**: The provided testbench to simulate the processor and verify memory write operations.
* **`riscvtest2.txt`**: The machine language instructions (Hex format) loaded into the memory at startup.

## Supported Instructions
The current FSM and Datapath support the following RISC-V base instructions:
* **I-Type:** `addi`, `lw`
* **R-Type:** `add`, `sub`, `and`, `or`, `slt`
* **S-Type:** `sw`
* **B-Type:** `beq`
* **J-Type:** `jal`

## How to Simulate (ModelSim)

To run the simulation and observe the waveforms, follow these steps:

1.  Clone this repository to your local machine:
    ```bash
    git clone [https://github.com/aliozyuksel/ELE432-LAB3-MulticycleProcessor.git](https://github.com/aliozyuksel/ELE432-LAB3-MulticycleProcessor.git)
    ```
2.  Open **ModelSim** (or QuestaSim).
3.  Change the directory to the cloned folder and compile all SystemVerilog (`.sv`) files.
4.  Start the simulation by selecting the `testbench` module (DO NOT start from `top.sv`):
    ```tcl
    vsim -voptargs="+acc" work.testbench
    ```
5.  Add the necessary signals to the Waveform window (you can use the following command in the transcript to add and format key signals):
    ```tcl
    add wave -radix binary /testbench/clk
    add wave -radix binary /testbench/reset
    add wave -radix hex /testbench/dut/core/dp/PC
    add wave -radix hex /testbench/dut/core/dp/Instr
    add wave /testbench/dut/core/c/fsm/state
    add wave -radix hex /testbench/dut/core/dp/ALUResult
    add wave -radix hex /testbench/dut/DataAdr
    add wave -radix hex /testbench/dut/WriteData
    add wave -radix binary /testbench/dut/MemWrite
    ```
6.  Run the simulation:
    ```tcl
    run -all
    ```
7.  If the simulation is successful run, you will see the `Simulation succeeded` message in the console, verifying that the value `25` (Hex: 19) was correctly written to address `100` (Hex: 64).

## Author
**Ali Özyüksel** Hacettepe University - Department of Electrical and Electronics Engineering
