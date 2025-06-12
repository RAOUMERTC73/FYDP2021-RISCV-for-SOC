`include "regfile.sv"    // Include file for the Register File module
`include "extend.sv"     // Include file for the Immediate Extension module
//`include "floprc.sv"     // Include file for Flip-flop with reset and enable (floprc)

module decode_cycle(
    input logic clk, rst, RegWriteW, FlushE,
    input logic [1:0] ImmSrcD,
    input logic [4:0] RdW,
    input logic [31:0] InstrD, PCD, PCPlus4D, ResultW,

    output logic [31:0] RD1_E, RD2_E, ImmExtE,
    output logic [4:0] Rs1E, Rs2E, RdE,
    output logic [31:0] PCE, PCPlus4E
);
    wire [4:0] Rs1D,Rs2D;
    // Interim wires
    logic [31:0] RD1_D, RD2_D, ImmExtD;

    // Assign Rs1 and Rs2 from instruction
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];

    // Register File: read values from register file
    regfile Register_File(
        .clk(clk), 
        .we3(RegWriteW), 
        .a1(InstrD[19:15]),   // Rs1
        .a2(InstrD[24:20]),   // Rs2
        .a3(RdW),             // Rd for write-back
        .wd3(ResultW),        // Write-back data
        .rd1(RD1_D),          // Output register value for Rs1
        .rd2(RD2_D)           // Output register value for Rs2
    );

    // Immediate Extension: sign-extend immediate field based on instruction type
    extend Sign_extension(
        .instr(InstrD[31:7]), 
        .immsrc(ImmSrcD), 
        .immext(ImmExtD)
    );

    // // Execute stage pipeline register logic with flush control
floprc #(32) regE_RD1_E   (.clk(clk), .reset(rst), .clear(FlushE), .d(RD1_D), .q(RD1_E));
floprc #(32) regE_RD2_E   (.clk(clk), .reset(rst), .clear(FlushE), .d(RD2_D), .q(RD2_E));
floprc #(32) regE_PCPlus4E(.clk(clk), .reset(rst), .clear(FlushE), .d(PCPlus4D), .q(PCPlus4E));
floprc #(32) regE_ImmExtE (.clk(clk), .reset(rst), .clear(FlushE), .d(ImmExtD), .q(ImmExtE));
floprc #(32) regE_PCE     (.clk(clk), .reset(rst), .clear(FlushE), .d(PCD), .q(PCE));
floprc #(5)  regE_Rs1E    (.clk(clk), .reset(rst), .clear(FlushE), .d(Rs1D), .q(Rs1E));
floprc #(5)  regE_Rs2E    (.clk(clk), .reset(rst), .clear(FlushE), .d(Rs2D), .q(Rs2E));
floprc #(5)  regE_RdE     (.clk(clk), .reset(rst), .clear(FlushE), .d(InstrD[11:7]), .q(RdE));


endmodule


/* 
module decode_cycle(clk, rst, InstrD,FlushE,PCD, PCPlus4D,ImmSrcD, RegWriteW, RdW, ResultW,Rs1D,Rs2D, RD1_E, RD2_E, ImmExtE, RdE, PCE, PCPlus4E, Rs1E, Rs2E);

    // Declaring I/O
    input logic clk, rst, RegWriteW,FlushE;
    input logic[1:0] ImmSrcD;
    input logic[4:0] RdW;
    input logic[31:0] InstrD, PCD, PCPlus4D, ResultW;

    output logic[2:0] ALUControlE;
    output logic[31:0] RD1_E, RD2_E, ImmExtE;
    output logic[4:0] Rs1E, Rs2E, RdE;
    output logic[31:0] PCE, PCPlus4E;

    // Declare Interim Wires
    wire [1:0] ImmSrcD;
    wire [31:0] RD1_D, RD2_D, ImmExtD;


    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];


    // Initiate the modules
    // Control Unit
    Control_Unit_Top control (
                            .Op(InstrD[6:0]),
                            .RegWrite(RegWriteD),
                            .ImmSrc(ImmSrcD),
                            .ALUSrc(ALUSrcD),
                            .MemWrite(MemWriteD),
                            .ResultSrc(ResultSrcD),
                            .Branch(BranchD),
                            .funct3(InstrD[14:12]),
                            .funct7(InstrD[31:25]),
                            .ALUControl(ALUControlD)
                            );
    controller Control_Unit_Top(.op(InstrD[6:0]),.funct3(InstrD[14:12]),.funct7b5(InstrD[30]),.Zero(),.ResultSrc,.MemWrite,.PCSrc, .ALUSrc,.RegWrite, .Jump,.ImmSrc,.ALUControl);


 

    // Register File
    regfile  Register_File(.clk(clk), .we3(RegWriteW), .a1(InstrD[19:15]), .a2(InstrD[24:20]),.a3(RdW),.wd3(ResultW), .rd1(RD1_D), .rd2(RD2_D));

    // Sign Extension
    extend Sign_extension(.instr(InstrD[31:7]),.immsrc(ImmSrcD),.immext(ImmExtD));

    // Declaring Register Logic
     // Execute stage pipeline register and logic
    floprc #(32) regE_RD1_E(clk, reset, FlushE, RD1_D,RD1_E);
    floprc #(32) regE_RD2_E(clk, reset, FlushE, RD2_D,RD2_E);
    floprc #(32) regE_PCPlus4D_r(clk, reset, FlushE, PCPlus4D,PCPlus4E);
    floprc #(32) regE_ImmExtD_r(clk, reset, FlushE,ImmExtD,ImmExtE);
    floprc #(32) regE_PCD_r(clk, reset, FlushE,PCD,PCE);
    floprc #(5) regE_Rs1D_r(clk, reset, FlushE,InstrD[19:15],Rs1E);
    floprc #(5) regE_Rs2D_r(clk, reset, FlushE,InstrD[24:20],Rs2E);
    floprc #(5) regE_RdD_r(clk, reset, FlushE,InstrD[11:7],RdE);


    
endmodule */