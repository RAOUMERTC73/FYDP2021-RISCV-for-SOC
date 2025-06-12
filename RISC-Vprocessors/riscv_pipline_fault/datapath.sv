
`include "flopr.sv"
`include "adder.sv"
`include "mux2.sv"
`include "mux3.sv"
`include "regfile.sv"
`include "extend.sv"
`include "alu.sv"
`include "floprc.sv"
`include "flopenr.sv"
`include "flopenrc.sv"

module datapath(
    input logic clk, reset,

    // Fetch stage signals
    input logic StallF,
    output logic [31:0] PCF,
    output logic [31:0] InstrF,

    // Decode stage signals
    output logic [6:0] opD,
    output logic [2:0] funct3D,
    output logic funct7b5D,
    input logic StallD, FlushD,
    input logic [2:0] ImmSrcD,

    // Execute stage signals
    input logic FlushE,
    input logic [1:0] ForwardAE, ForwardBE,
    input logic PCSrcE,
    input logic [2:0] ALUControlE,
    input logic ALUSrcAE, // needed for lui
    input logic ALUSrcBE,
    output logic ZeroE,

    // Memory stage signals
    input logic MemWriteM,
    output logic [31:0] WriteDataM, ALUResultM,
    input logic [31:0] ReadDataM,

    // Writeback stage signals
    input logic RegWriteW,
    input logic [1:0] ResultSrcW,

    // Hazard Unit signals
    output logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
    output logic [4:0] RdE, RdM, RdW
);

    // Fetch stage signals
    logic [31:0] PCNextF, PCPlus4F;

    // Decode stage signals
    logic [31:0] InstrD;
    logic [31:0] PCD, PCPlus4D;
    logic [4:0] RD1D, RD2D;
    logic [31:0] ImmExtD;
    logic [4:0] RdD;

    // Execute stage signals
    logic [31:0] RD1E, RD2E;
    logic [31:0] PCE, ImmExtE;
    logic [31:0] SrcAE, SrcBE;
    logic [31:0] SrcAEForward, SrcBEForward;
    logic [31:0] ALUResultE;
    logic [31:0] WriteDataE, PCPlus4E;
    logic [31:0] PCTargetE;

    // Memory stage signals
    logic [31:0] PCPlus4M;

    // Writeback stage signals
    logic [31:0] ALUResultW;
    logic [31:0] ReadDataW;
    logic [31:0] PCPlus4W;
    logic [31:0] ResultW;

    // Fetch pipeline stage register and logic
    mux2 #(32) pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNextF);
    flopenr #(32) pcreg(clk, reset, ~StallF, PCNextF, PCF);
    adder pcadd(PCF, 32'h4, PCPlus4F);

    // Decode stage and fetch pipline signal  pipeline register and logic
    flopenrc #(96) regD(clk, reset, FlushD, ~StallD, 
        {InstrF, PCF, PCPlus4F}, 
        {InstrD, PCD, PCPlus4D});
    assign opD = InstrD[6:0];
    assign funct3D = InstrD[14:12];
    assign funct7b5D = InstrD[30];
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];

    regfile rf(clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
    extend ext(InstrD[31:7], ImmSrcD, ImmExtD);

    // Execute stage pipeline register and logic
    floprc #(175) regE(clk, reset, FlushE, 
        {RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D}, 
        {RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E});
    mux3 #(32) faemux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAEForward);
    mux2 #(32) srcamux(SrcAEForward, 32'b0, ALUSrcAE, SrcAE); // for lui
    mux3 #(32) fbemux(RD2E, ResultW, ALUResultM, ForwardBE, SrcBEForward);
    mux2 #(32) srcbmux(WriteDataE, ImmExtE, ALUSrcBE, SrcBE);

    alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
    adder branchadd(ImmExtE, PCE, PCTargetE);
	//Memory stage pipeline register 
	flopr #(101) regM(clk,reset,{ALUResultE,WriteDataE,RdE,PCPlus4E},{ALUResultM,WriteDataM,RdM,PCPlus4M});
    
	//Writeback stage pipeline register and logic
	flopr #(101) regW(clk,reset,{ALUResultM,ReadDataM,RdM,PCPlus4M},{ALUResultW,ReadDataW,RdW,PCPlus4W});
	mux3 #(32) resultmux(ALUResultW,ReadDataW,PCPlus4W,ResultSrcW,ResultW);
	
endmodule


/* 
`include "flopr.sv"
`include "adder.sv"
`include "mux2.sv"
`include "mux3.sv"
`include "regfile.sv"
`include "extend.sv"
`include "alu.sv"

module datapath(input  logic        clk, reset,
                input  logic [1:0]  ResultSrc, 
                input  logic        PCSrc, ALUSrc,
                input  logic        RegWrite,
                input  logic [1:0]  ImmSrc,
                input  logic [2:0]  ALUControl,
                output logic        Zero,
                output logic [31:0] PC,
                input  logic [31:0] Instr,
                output logic [31:0] ALUResult, WriteData,
                input  logic [31:0] ReadData);

  logic [31:0] PCNext, PCPlus4, PCTarget;
  logic [31:0] ImmExt;
  logic [31:0] SrcA, SrcB;
  logic [31:0] Result;

  // next PC logic
  flopr #(32) pcreg(clk, reset, PCNext, PC); 
  adder       pcadd4(PC, 32'd4, PCPlus4);
  adder       pcaddbranch(PC, ImmExt, PCTarget);
  mux2 #(32)  pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
 
  // register file logic
  regfile     rf(clk, RegWrite, Instr[19:15], Instr[24:20], 
                 Instr[11:7], Result, SrcA, WriteData);
  extend      ext(Instr[31:7], ImmSrc, ImmExt);

  // ALU logic
  mux2 #(32)  srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
  alu         alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
  mux3 #(32)  resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);

  
endmodule
 */