`include "mux3.sv"       // Include file for 3-input multiplexer
//`include "mux2.sv"       // Include file for 2-input multiplexer
`include "alu.sv"        // Include file for the ALU module
//`include "adder.sv"      // Include file for the Adder module
`include "flopr.sv"      // Include file for the pipeline register (flopr)

module execute_cycle(
    input logic clk, rst, ALUSrcE, 
    input logic [2:0] ALUControlE,
    input logic [31:0] RD1_E, RD2_E, ImmExtE, PCE, PCPlus4E, ResultW, 
    input logic [1:0] ForwardAE, ForwardBE,
    input logic [4:0] RdE,
    output logic ZeroE,
    output logic [4:0] RdM, 
    output logic [31:0] PCPlus4M, WriteDataM, ALUResultM,
    output logic [31:0] PCTargetE
);

    // Declaration of Interim Wires
    logic [31:0] SrcAE, WriteDataE, SrcBE;
    logic [31:0] ALUResultE;
    
    // Muxes for forwarding: 3 by 1 Mux for Source A (SrcAE)
    mux3 #(32) faemux(
        .d0(RD1_E), 
        .d1(ResultW), 
        .d2(ALUResultM), 
        .s(ForwardAE), 
        .y(SrcAE)
    );

    // Muxes for forwarding: 3 by 1 Mux for Source B (WriteDataE)
    mux3 #(32) fbemux(
        .d0(RD2_E), 
        .d1(ResultW), 
        .d2(ALUResultM), 
        .s(ForwardBE), 
        .y(WriteDataE)
    );

    // SrcB Mux to select between forwarded WriteDataE and immediate value (ImmExtE)
    mux2 #(32) srcBmux(
        .d0(WriteDataE), 
        .d1(ImmExtE), 
        .s(ALUSrcE), 
        .y(SrcBE)
    );

    // ALU Unit: performs arithmetic/logical operations
    alu Alu(
        .a(SrcAE), 
        .b(SrcBE), 
        .alucontrol(ALUControlE), 
        .result(ALUResultE), 
        .zero(ZeroE)
    );

    // Adder to calculate branch target address (PCTargetE)
    adder branchadd(
        .a(PCE), 
        .b(ImmExtE), 
        .y(PCTargetE)
    );

    // Memory stage pipeline register
    flopr #(101) regM(
        .clk(clk), 
        .reset(rst), 
        .d({ALUResultE, WriteDataE, RdE, PCPlus4E}),
        .q({ALUResultM, WriteDataM, RdM, PCPlus4M})
    );

endmodule
