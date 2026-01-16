# SAP-1-Verilog
Verilog implementation of SAP-1 (Simple As Possible) 8-bit computer
## Introduction
SAP-1 is a 8-bit computer architecture designed to demonstrate how instructions are fetched, decoded, and executed using simple hardware blocks.
## Objectives

Understand CPU datapath and control unit design

Implement a basic instruction cycle (Fetch–Decode–Execute)

Learn how registers, memory, and ALU interact

Simulate and verify CPU behavior using testbenches

---
## SAP-1 Architecture 

### Main Components
- Program Counter (PC)
- Memory Address Register (MAR)
- Random Access Memory (RAM)
- Instruction Register (IR)
- Control Unit
- Accumulator (Register A)
- Register B
- Arithmetic Logic Unit (ALU)
- Output Register
- T-State (Timing) Counter

Each component is implemented as an individual Verilog module.

---
## Instruction Set
| Opcode | Instruction | Description |
|-------|------------|-------------|
| 0000  | LDA        | Load data from memory into accumulator |
| 0010  | ADD        | Add memory data to accumulator |
| 0011  | SUB        | Subtract memory data from accumulator |
| 1110  | OUT        | Output accumulator value |
| 1111  | HLT        | Halt program execution |

---
## Working
1. The address stored in the **Program Counter (PC)** is sent to the **Memory Address Register (MAR)**.
2. The **PC** increments which helps to point to other instruction during next cycle.
3. The **RAM** uses the address in MAR to output the instruction stored at that location.
4. The fetched instruction is loaded into the **Instruction Register (IR)**.
5. The **opcode** part of the instruction is sent from the IR to the **Control Unit**, where it is decoded.
6. The **operand** part of the instruction is sent from the IR to the **MAR** to point to the required data address.  
   This completes the **Fetch and Decode cycle**.
7. During the **Execution cycle**, the control unit generates appropriate control signals based on the opcode given above.
---
### Sample provided here

This sample program demonstrates execution of a simple SAP-1 instruction
sequence. The program loads data from memory, performs addition\ subtraction as per the instruction provided, outputs
the result, stores the result in memory address mentioned by the user, and halts execution.

### Memory Contents

```verilog
initial begin
    mem[0] = 8'b0000_0101; // LDA 4
    mem[1] = 8'b0010_0110; // ADD 5
    mem[2] = 8'b1110_0000; // OUT
    mem[3] = 8'b0011_0111; // Store result in mem[7]
    mem[4] = 8'b1111_0000; // HLT

    mem[5] = 8'b0000_0100; // 04
    mem[6] = 8'b0000_0010; // 02
end
```
---
## References
- Malvino, A. P., & Brown, J. A., *Digital Computer Electronics*, McGraw-Hill  
- Ben Eater, *Build an 8-bit Computer from Scratch* (SAP-1 inspired architecture)  
- Computer Organization and Architecture lecture notes  
