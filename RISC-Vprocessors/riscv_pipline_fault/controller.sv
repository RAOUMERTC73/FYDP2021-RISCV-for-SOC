`include "maindec.sv"      // Main decoder
`include "aludec.sv"       // ALU decoder
//`include "flopr.sv"        // Flip-flop register
`include "floprc.sv"       // Flip-flop register with reset and clear

module controller(
    input logic clk, rst,

    // Decode stage control signals
    input logic [6:0] opD,
    input logic [2:0] funct3D,
    input logic funct7b5D,

    // Execute stage control signals
    input logic FlushE,
    input logic ZeroE,
    output logic PCSrcE, // for datapath and Hazard Unit
    output logic [2:0] ALUControlE,
    output logic ALUSrcE,
    output logic ResultSrcE0, // for Hazard Unit

    // Memory stage control signals
    output logic MemWriteM,
    output logic RegWriteM, // for Hazard Unit

    // Writeback stage control signals
    output logic RegWriteW, // for datapath and Hazard Unit
    output logic [1:0] ResultSrcW,
    output logic [1:0] ImmSrcD
);

    // Pipelined control signals
    logic RegWriteD, RegWriteE;
    logic [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
    logic MemWriteD, MemWriteE;
    logic JumpD, JumpE;
    logic BranchD, BranchE;
    logic [1:0] ALUOpD;
    logic [2:0] ALUControlD;
    logic ALUSrcD; 

    // Decode stage logic
    maindec md(
        .op(opD), 
        .ResultSrc(ResultSrcD), 
        .MemWrite(MemWriteD), 
        .Branch(BranchD), 
        .ALUSrc(ALUSrcD), 
        .RegWrite(RegWriteD), 
        .Jump(JumpD), 
        .ImmSrc(ImmSrcD), 
        .ALUOp(ALUOpD)
    );

    aludec ad(
        .opb5(opD[5]), 
        .funct3(funct3D), 
        .funct7b5(funct7b5D), 
        .ALUOp(ALUOpD), 
        .ALUControl(ALUControlD)
    );

    floprc #(10) controlregE(
    .clk(clk), 
    .reset(rst),     
    .clear(FlushE), 
    .d({RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD}),
    .q({RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE})  );


    assign PCSrcE = (BranchE & ZeroE) | JumpE;
    assign ResultSrcE0 = ResultSrcE[0];

    // Memory stage pipeline control register
    flopr #(4) controlregM(
    .clk(clk), 
    .reset(rst),  
    .d({RegWriteE, ResultSrcE, MemWriteE}),
    .q({RegWriteM, ResultSrcM, MemWriteM})  );

    // Writeback stage control register
    flopr #(3) controlregW(
    .clk(clk), 
    .reset(rst),  
    .d({RegWriteM, ResultSrcM}),
    .q({RegWriteW, ResultSrcW})  );


endmodule












/* `include "maindec.sv"
`include "aludec.sv"
`include "floprc.sv"
`include "flopr.sv"

module controller(
    input logic clk, rst,

    // Decode stage control signals
    input logic [6:0] opD,
    input logic [2:0] funct3D,
    input logic funct7b5D,
    input logic [1:0] ImmSrcD,

    // Execute stage control signals
    input logic  FlushE,
    input logic ZeroE,
    output logic PCSrcE, // for datapath and Hazard Unit
    output logic [2:0] ALUControlE,
    output logic ALUSrcE,
    output logic ResultSrcEbO, // for Hazard Unit

    // Memory stage control signals
    output logic MemWriteM,
    output logic RegWriteM, // for Hazard Unit

    // Writeback stage control signals
    output logic RegWriteW, // for datapath and Hazard Unit
    output logic [1:0] ResultSrcW);

    // Pipelined control signals
    logic RegWriteD, RegWriteE;
    logic [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
    logic MemWriteD, MemWriteE;
    logic JumpD, JumpE;
    logic BranchD, BranchE;
    logic [1:0] ALUOpD;
    logic [2:0] ALUControlD;
    logic ALUSrcD; 
    
    // Decode stage logic
    maindec md(.op(opD), .ResultSrc(ResultSrcD), .MemWrite(MemWriteD), .Branch(BranchD), .ALUSrc(ALUSrcD),.RegWrite(RegWriteD), .Jump(JumpD), .ImmSrc(ImmSrcD), .ALUOp(ALUOpD));

    aludec ad(.opb5(opD[5]), .funct3(funct3D), .funct7b5(funct7b5D), .ALUOp(ALUOpD), .ALUControl(ALUControlD));

    // Execute stage pipeline control register and logic
    floprc #(10) controlregE(clk, rst, FlushE, 
        {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD},
        {RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE});

    assign PCSrcE = (BranchE & ZeroE) | JumpE;
    assign ResultSrcEbO = ResultSrcE[0];

    // Memory stage pipeline control register
    flopr #(4) controlregM(clk, rst, 
        {RegWriteE, ResultSrcE, MemWriteE},
        {RegWriteM, ResultSrcM, MemWriteM});

    // Writeback stage control register
    flopr #(3) controlregW(clk, rst, 
        {RegWriteM, ResultSrcM},
        {RegWriteW, ResultSrcW});

endmodule

 */

/* `include "maindec.sv"
`include "aludec.sv"

module controller(input  logic [6:0] op,
                  input  logic [2:0] funct3,
                  input  logic       funct7b5,
                  input  logic       Zero,
                  output logic [1:0] ResultSrc,
                  output logic       MemWrite,
                  output logic       PCSrc, ALUSrc,
                  output logic       RegWrite, Jump,
                  output logic [1:0] ImmSrc,
                  output logic [2:0] ALUControl);

  logic [1:0] ALUOp;
  logic       Branch;

  maindec md(op, ResultSrc, MemWrite, Branch,
             ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);
  aludec  ad(op[5], funct3, funct7b5, ALUOp, ALUControl);

  assign PCSrc = Branch & Zero | Jump;
endmodule
 */