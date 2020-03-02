# Integer-Array-Adder-Assembly
This project is for Computer Architecture 2 course and its purpose is to implement a program in assembly language in WinMIPS64 simulator in the smallest number of clock cycles.

## Purpose of the program
The program performs the following operation: it calculates the sum of 500 elements of a table of unsigned integers in memory (at .data segment of source code). The numbers are strictly between 0 and 127, the table is not sorted and any value can appear any number of times. At the end it prints the sum to the WinMIPS64 terminal.

## Simulator settings

  - **Forwarding** enable
  - **Branch Target Buffer** enable
  - **Branch Delay Slot** disable
  
## Implementation
Since the numbers are between 0 and 127, each one fits into one byte. So 8 numbers fit each memory address. By loading a memory address, we load 8 numbers simultaneously and with the masks: `mask1 = 0xFF00FF00FF00FF00` and` mask2 = 0x00FF00FF00FF00FF`, isolating the numbers 1,3,5,7 and 2,4,6,8 respectively.

From memory 0 we will load the numbers: 
```
0000  4a732c792a60513a  array: .byte 58, 81, 96, 42, 121, 44, 115, 74
```
to the register and after 8 bits right shift we have:
```
R20 = 007300790060003a
R21 = 004a002c002a0051
```

Adding these 2 registers, since the sum cannot exceed 4 decimal places (127 * 500 = 63500 = 0xF80C) leaving 2 zeros space we have no overflow issue. This way we add 8 numbers at once to one operation. At the end with the Reduce-Gather logic we add the numbers that have been generated to the register for the final sum.

Finally, we use loop unrolling to reduce circles even further.


## Results
The final results of this implementation are:
  - **492** Cycles 
  - **482** Instructions 
  - **1.017** Cycles Per Instruction (CPI) 

