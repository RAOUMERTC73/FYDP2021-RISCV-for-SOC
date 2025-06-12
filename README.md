# FYDP2021-RISCV-for-SOC
# RISCV for System on Chip (SoC)

This project implements a 32-bit RISC-V processor-based System on Chip (SoC) that communicates with external devices through UART and I2C serial communication protocols. The system is designed for efficient processing and transfer of 32-bit data words using a pipelined RISC-V core integrated with memory, UART, and I2C interfaces.

---

## 🚀 Overview

The system allows a user (master) to send 32-bit data to the RISC-V processor through a UART interface. The processor then executes instructions from an instruction memory (IMEM) to process the data. The resulting data is sent back to a slave device via the I2C protocol. External memory modules (IMEM & DMEM) are used for instruction and data storage.

---

## 🧠 Features

- Custom 32-bit RISC-V core developed using **SystemVerilog**
- **5-stage pipeline architecture** to optimize performance
- **UART protocol** for receiving input data from the user (master)
- **I2C protocol** for sending processed output to external peripherals (slaves)
- Modular system integration on **FPGA**
- Verified through simulation and real-time FPGA implementation

---

## 🧩 System Architecture

### 1. **RISC-V Processor Design**
- Implemented in SystemVerilog
- Adheres to RISC-V ISA specifications
- Performs arithmetic, logic, control flow, and memory operations
- Integrated with external instruction and data memory blocks

### 2. **UART Communication**
- Used to transmit 32-bit input data from the master (user) to the processor
- Supports serial data transfer with adaptive baud rate
- Input data stored temporarily in a memory bank before processing

### 3. **I2C Communication**
- Retrieves and transmits processed data to the slave/output device
- Ensures synchronized communication with peripheral devices
- Allows integration with sensors or additional SoC modules

### 4. **System Integration and Testing**
- RISC-V, UART, and I2C modules integrated and tested under various conditions
- Verified via simulation and FPGA-based validation

---

## 🔁 Functional Flow

1. **Data Input (UART)**  
   Master sends 32-bit data words to the processor through UART.

2. **Instruction Execution (RISC-V)**  
   Processor fetches instructions from IMEM and processes input data accordingly.

3. **Data Output (I2C)**  
   Output data is sent to the slave device using I2C protocol.

---

## 🧪 Simulation and Validation

- Testbenches created for individual modules (UART, I2C, RISC-V)
- Simulated using ModelSim / Vivado
- Real-time FPGA implementation for integration testing

---
## 👨‍💻 Authors
 Final Year Design Project – Telecommunication Engineering TC-431 
 NED University of Engineering & Technology  
 GitHub: [RAOUMERTC73](https://github.com/RAOUMERTC73)

## 📌 License

This project is developed for educational purposes under academic fair use. For other uses, please contact the author.

