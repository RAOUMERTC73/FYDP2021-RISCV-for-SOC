
`include "hazard.sv"
`include "imem.sv"
`include "dmem.sv"
`include "controller.sv"
//`include "datapath.sv"

module top(input  logic clk, reset, 
           output logic [31:0] WriteData, ALUResultM, 
           output logic MemWriteM);

  logic [31:0] PCF, InstrF, ReadData;
  logic [1:0] ForwardAE, ForwardBE;
  logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
  logic PCSrcE, RegWriteM, RegWriteW, StallF, StallD, FlushD, FlushE;
  logic [6:0] opD;
  logic [2:0] funct3D, ImmSrcD, ALUControlE,ResultSrcW;
  logic funct7b5D;
  logic ALUSrcAE, ALUSrcBE, ResultSrcEbO;
  logic ZeroE;

  // Instantiate instruction memory
  imem imem(PCF, InstrF);

  // Instantiate data memory
  dmem dmem(clk, MemWriteM, ALUResultM, WriteData, ReadData);

  // Instantiate hazard detection unit
  hazard hazard(
    .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW),
    .PCSrcE(PCSrcE), .ResultSrcEbO(ResultSrcEbO),
    .RegWriteM(RegWriteM), .RegWriteW(RegWriteW),
    .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
    .StallF(StallF), .StallD(StallD), .FlushD(FlushD), .FlushE(FlushE)
  );
// Instantiate datapath
  datapath datapath(
    .clk(clk), .reset(reset),
    .StallF(StallF), .PCF(PCF), .InstrF(InstrF),
    .opD(opD), .funct3D(funct3D), .funct7b5D(funct7b5D), 
    .StallD(StallD), .FlushD(FlushD), .ImmSrcD(ImmSrcD),
    .FlushE(FlushE), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), 
    .PCSrcE(PCSrcE), .ALUControlE(ALUControlE), .ALUSrcAE(ALUSrcAE), 
    .ALUSrcBE(ALUSrcBE), .ZeroE(ZeroE),
    .MemWriteM(MemWrite), .WriteDataM(WriteData), .ALUResultM(ALUResultM), 
    .ReadDataM(ReadData),
    .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW),
    .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), 
    .RdE(RdE), .RdM(RdM), .RdW(RdW)
  );
  // Instantiate controller
  controller controller(
    .clk(clk), .reset(reset),
    .opD(opD), .funct3D(funct3D), .funct7b5D(funct7b5D), .ImmSrcD(ImmSrcD),
    .FlushE(FlushE), .ZeroE(ZeroE),
    .PCSrcE(PCSrcE), .ALUControlE(ALUControlE),
    .ALUSrcBE(ALUSrcBE), .ALUSrcAE(ALUSrcAE), .ResultSrcEbO(ResultSrcEbO),
    .MemWriteM(MemWrite), .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW)
  );

  

endmodule

/* 
module top(input  logic        clk, reset, 
           output logic [31:0] WriteData, DataAdr, 
           output logic        MemWrite);

  logic [31:0] PC, Instr, ReadData;
  
  // instantiate processor and memories
  riscvsingle rvsingle(clk, reset, PC, Instr, MemWrite, DataAdr, 
                       WriteData, ReadData);

  riscvpipline rvpipline(clk, reset,PC,Instr, ReadDataM, ALUResultM,WriteDataM);

  imem imem(PC, Instr);
  dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);


  
endmodule
 */