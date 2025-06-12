
`include "fetch_cycle.sv"
`include "decode_cycle.sv"
`include "execute_cycle.sv"
`include "memory_cycle.sv"
`include "writeback_cycle.sv"
`include "controller.sv"
`include "hazard.sv"
module Pipeline_top(input  logic clk, rst, output logic [31:0] WriteDataM, ALUResultM, output logic MemWriteM);
   
    // Declaration of Interim Wires
    // Internal signals for interconnecting modules
    logic [31:0] InstrD, PCD, PCPlus4D;
    logic [31:0] RD1_E, RD2_E, ImmExtE, PCE, PCPlus4E;
    logic [31:0] PCPlus4M, ReadDataW;
    logic [31:0] PCPlus4W, ALUResultW, ResultW;
    logic [31:0] PCTargetE;

    logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    logic [2:0] ALUControlE;
    logic [1:0] ImmSrcD, ResultSrcW, ForwardAE, ForwardBE;
    logic ALUSrcE, RegWriteW, RegWriteM, ResultSrcE0;
    logic FlushE, FlushD, StallF, StallD, ZeroE, PCSrcE;
    

    // Module Initiation
    // Fetch Stage
    // Instantiate the fetch_cycle module
    fetch_cycle fetch_cycle_inst (
        .clk(clk), 
        .rst(rst), 
        .PCSrcE(PCSrcE), 
        .StallF(StallF), 
        .StallD(StallD), 
        .FlushD(FlushD), 
        .PCTargetE(PCTargetE), 
        .InstrD(InstrD), 
        .PCD(PCD), 
        .PCPlus4D(PCPlus4D)
    );


    // Decode Stage
    // Instantiate the decode_cycle module
    decode_cycle decode_cycle_inst (
        .clk(clk),                // Connect the clock signal
        .rst(rst),                // Connect the reset signal
        .RegWriteW(RegWriteW),    // Connect the register write-back signal
        .FlushE(FlushE),          // Connect the flush signal for the execute stage
        .ImmSrcD(ImmSrcD),        // Connect the immediate source control signal
        .RdW(RdW),                // Connect the destination register for write-back
        .InstrD(InstrD),          // Connect the instruction from fetch stage
        .PCD(PCD),                // Connect the Program Counter from fetch stage
        .PCPlus4D(PCPlus4D),      // Connect PC + 4 from fetch stage
        .ResultW(ResultW),        // Connect the result from write-back stage

        .RD1_E(RD1_E),           // Output the read data 1 for execute stage
        .RD2_E(RD2_E),           // Output the read data 2 for execute stage
        .ImmExtE(ImmExtE),       // Output the extended immediate for execute stage
        .Rs1E(Rs1E),             // Output the source register 1 for execute stage
        .Rs2E(Rs2E),             // Output the source register 2 for execute stage
        .RdE(RdE),               // Output the destination register for execute stage
        .PCE(PCE),               // Output the Program Counter for execute stage
        .PCPlus4E(PCPlus4E)      // Output PC + 4 for execute stage
    );

    // Execute Stage
    // Instantiate the execute_cycle module
    execute_cycle execute_cycle_inst (
        .clk(clk),                // Connect the clock signal
        .rst(rst),                // Connect the reset signal
        .ALUSrcE(ALUSrcE),        // Connect the ALU source control signal
        .ALUControlE(ALUControlE),// Connect the ALU control signals
        .RD1_E(RD1_E),            // Connect the first register read data
        .RD2_E(RD2_E),            // Connect the second register read data
        .ImmExtE(ImmExtE),        // Connect the extended immediate value
        .PCE(PCE),                // Connect the Program Counter value
        .PCPlus4E(PCPlus4E),      // Connect PC + 4 value
        .ResultW(ResultW),        // Connect the result from write-back stage
        .ForwardAE(ForwardAE),    // Connect the forwarding control signal for Source A
        .ForwardBE(ForwardBE),    // Connect the forwarding control signal for Source B
        .RdE(RdE),                // Connect the destination register for execute stage
        .ZeroE(ZeroE),            // Output the zero flag from ALU
        .RdM(RdM),                // Output the destination register for memory stage
        .PCPlus4M(PCPlus4M),      // Output PC + 4 value for memory stage
        .WriteDataM(WriteDataM),  // Output the write data for memory stage
        .ALUResultM(ALUResultM),  // Output the ALU result for memory stage
        .PCTargetE(PCTargetE)     // Output the branch target address
    );
    // Memory Stage
    // Instantiate the memory_cycle module
    memory_cycle memory_cycle_inst (
        .clk(clk),            // Connect the clock signal
        .rst(rst),            // Connect the reset signal
        .MemWriteM(MemWriteM),// Connect the memory write enable signal
        .RdM(RdM),            // Connect the destination register for memory stage
        .PCPlus4M(PCPlus4M),  // Connect PC + 4 value for memory stage
        .WriteDataM(WriteDataM), // Connect the data to be written to memory
        .ALUResultM(ALUResultM), // Connect the ALU result for address calculation
        .RdW(RdW),            // Output the destination register for write-back stage
        .PCPlus4W(PCPlus4W),  // Output the PC + 4 value for write-back stage
        .ALUResultW(ALUResultW), // Output the ALU result for write-back stage
        .ReadDataW(ReadDataW)  // Output the read data from memory
    );

    // Write Back Stage
     // Instantiate the writeback_cycle module
    writeback_cycle writeback_cycle_inst (
        .clk(clk),              // Connect the clock signal
        .rst(rst),              // Connect the reset signal
        .ResultSrcW(ResultSrcW), // Connect the result source control signal
        .PCPlus4W(PCPlus4W),    // Connect the PC + 4 value for the writeback stage
        .ALUResultW(ALUResultW),// Connect the ALU result for the writeback stage
        .ReadDataW(ReadDataW),  // Connect the data read from memory for the writeback stage
        .ResultW(ResultW)       // Output the final result for the writeback stage
    );

     // Instantiation of the controller module
    controller controller_inst (
        .clk(clk), 
        .rst(rst),

        // Decode stage control signals
        .opD(InstrD[6:0]), 
        .funct3D(InstrD[14:12]), 
        .funct7b5D(InstrD[30]), 
     
        // Execute stage control signals
        .FlushE(FlushE), 
        .ZeroE(ZeroE), 
        .PCSrcE(PCSrcE), 
        .ALUControlE(ALUControlE), 
        .ALUSrcE(ALUSrcE), 
        .ResultSrcE0(ResultSrcE0),

        // Memory stage control signals
        .MemWriteM(MemWriteM), 
        .RegWriteM(RegWriteM),

        // Writeback stage control signals
        .RegWriteW(RegWriteW), 
        .ResultSrcW(ResultSrcW),
        .ImmSrcD(ImmSrcD)
    );
    
    // Instantiation of the hazard module
    hazard hazard_inst (
        .Rs1D(Rs1D), 
        .Rs2D(Rs2D), 
        .Rs1E(Rs1E), 
        .Rs2E(Rs2E), 
        .RdE(RdE), 
        .RdM(RdM), 
        .RdW(RdW),
        .PCSrcE(PCSrcE), 
        .ResultSrcE0(ResultSrcE0),
        .RegWriteM(RegWriteM), 
        .RegWriteW(RegWriteW),
        .ForwardAE(ForwardAE), 
        .ForwardBE(ForwardBE),
        .StallF(StallF), 
        .StallD(StallD), 
        .FlushD(FlushD), 
        .FlushE(FlushE)
    );

endmodule
