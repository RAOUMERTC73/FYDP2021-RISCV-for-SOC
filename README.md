# FYDP2021-RISCV-for-SOC
---
## 👨‍💻 Authors
 Final Year Design Project – Telecommunication Engineering TC-431 
 NED University of Engineering & Technology  
 GitHub: [RAOUMERTC73](https://github.com/RAOUMERTC73)

# RISC-V System-on-Chip (SoC) for Communication

Welcome to the RISC-V SoC for Communication project! This repository contains the design, implementation, and testbenches for a custom RISC-V-based System-on-Chip (SoC) tailored for communication systems. This project was developed as part of the Final Year Design Project (FYDP-11) for 2021.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Directory Structure](#directory-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

This project implements a RISC-V-based SoC, focusing on communication applications. The design aims to provide a customizable, open-source hardware solution for research and development in digital communication systems.

### Objectives

- Develop a RISC-V CPU core compatible with the RV32I instruction set.
- Integrate communication peripherals (UART, SPI, etc.) for real-world interfacing.
- Provide testbenches and simulation support for verification.
- Enable extensibility for future enhancements or custom accelerators.

## Features

- **RISC-V CPU Core:** Implements the base RV32I instruction set.
- **Communication Peripherals:** UART, SPI, and other modules for data transfer.
- **Memory Subsystem:** On-chip RAM and support for memory-mapped I/O.
- **Verilog HDL:** All modules written in synthesizable Verilog.
- **Testbenches:** Simulation environments for module verification.
- **Documentation:** Source code is documented for ease of understanding and extension.

## Directory Structure

```
.
├── rtl/             # RTL (Register Transfer Level) Verilog source code
├── tb/              # Testbenches for simulation
├── docs/            # Documentation and project reports
├── scripts/         # Simulation and build scripts
├── synthesis/       # Synthesis results and constraints
└── README.md        # Project README (this file)
```

## Getting Started

### Prerequisites

- Verilog simulator (e.g., Icarus Verilog, ModelSim)
- Make (for build automation)
- Python (optional, for scripts)

### Cloning the Repository

```bash
git clone https://github.com/kashaf619/FYDP-11-2021-RISC-V-SoC-for-Communication.git
cd FYDP-11-2021-RISC-V-SoC-for-Communication
```

## Usage

### Simulating the SoC

1. Navigate to the `tb/` directory.
2. Run the simulation using your preferred tool (e.g., Icarus Verilog):

```bash
cd tb
make
```

### Synthesizing the Design

Check the `synthesis/` folder for synthesis scripts and instructions for your preferred FPGA/ASIC toolchain.

## Testing

Testbenches are provided in the `tb/` directory for key modules. Use your Verilog simulator to verify functionality:

```bash
cd tb
make test
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests to help improve the project.

1. Fork this repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes.
4. Open a pull request describing your modifications.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

*Developed as part of FYDP-11 (2021) by [kashaf619](https://github.com/kashaf619).*  
