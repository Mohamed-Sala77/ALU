# ALU Project

## Description

This project implements an Arithmetic Logic Unit (ALU) capable of performing various arithmetic and logical operations. The ALU is designed to take in two signed 5-bit inputs and generate a signed 6-bit output. It supports different operations controlled by input signals.

## Features

- **5-bit signed inputs** (A and B)
- **6-bit signed output**
- **Supports multiple arithmetic and logical operations**:
  - Addition
  - Subtraction
  - Bitwise AND, OR, XOR, and NOR
  - Logical operations based on enable signals
- **Enable signals to control execution of operations**
- **Clock and reset functionality**

## Input and Output Signals

| Signal Name | Type   | Width (bits) | Description                               |
| ----------- | ------ | ------------ | ----------------------------------------- |
| A           | Input  | 5            | Signed 5-bit input data                   |
| B           | Input  | 5            | Signed 5-bit input data                   |
| A\_en       | Input  | 1            | Enable signal for A operations            |
| A\_op       | Input  | 3            | 3-bit operation selector for A operations |
| B\_en       | Input  | 1            | Enable signal for B operations            |
| B\_op       | Input  | 2            | 2-bit operation selector for B operations |
| Rst\_n      | Input  | 1            | Active-low reset signal                   |
| Clk         | Input  | 1            | System clock signal                       |
| ALU\_en     | Input  | 1            | Overall system enable signal              |
| Output      | Output | 6            | Signed 6-bit output data                  |

## Supported Operations

### A Operations (Controlled by A\_op)

| Operation | Code | Description           |
| --------- | ---- | --------------------- |
| ADD       | 000  | Summation of inputs   |
| SUB       | 001  | Subtraction (A - B)   |
| XOR       | 010  | Bitwise XOR operation |
| AND       | 011  | Bitwise AND operation |
| OR        | 100  | Bitwise OR operation  |
| NOR       | 101  | Bitwise NOR operation |

### B Operations (Controlled by B\_op)

| Operation | Code | Description          |
| --------- | ---- | -------------------- |
| NOT       | 00   | Bitwise NOT of input |
| ADD       | 01   | Addition of inputs   |
| SUB       | 10   | Subtraction (B - A)  |
| INC       | 11   | Increment input by 1 |

## Functional Verification

The project includes test cases to verify correct functionality. Tests include:

1. Generating inputs to create required test environments
2. Monitoring outputs based on test inputs
3. Checking expected outputs against actual results

## How to Use

1. Clone the repository:
   ```sh
   git clone <repo-url>
   cd ALU_Project
   ```
2. Load the project files into your preferred simulation environment.
3. Run test cases to verify functionality.
4. Modify the ALU design if needed and re-run the tests.

## Contributing

If you'd like to contribute:

- Fork the repository
- Create a new branch
- Make your modifications
- Submit a pull request

## License

This project is licensed under the MIT License.

