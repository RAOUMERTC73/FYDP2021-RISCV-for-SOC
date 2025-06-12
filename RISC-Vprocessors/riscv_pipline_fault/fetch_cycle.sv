`include "mux2.sv"        // Mux module to select between PC+4 and branch target
`include "flopenr.sv"     // Flip-flop with enable and reset
`include "imem.sv"        // Instruction memory module
`include "adder.sv"       // Adder module to compute PC + 4
`include "flopenrc.sv"    // Flip-flop with enable, reset, and clear (flush)

module fetch_cycle(
    input logic clk, rst,
    input logic PCSrcE, StallF, StallD, FlushD,
    input logic [31:0] PCTargetE,
    output logic [31:0] InstrD,
    output logic [31:0] PCD, PCPlus4D
);

    // Interim wires
    logic [31:0] PC_F, PCF, PCPlus4F;
    logic [31:0] InstrF;

    // PC Mux: select between PC+4 or branch target address
    mux2 #(32) PC_MUX(
        .d0(PCPlus4F),
        .d1(PCTargetE),
        .s(PCSrcE),
        .y(PC_F)
    );

    // PC Register with enable and reset control (flopenr)
    flopenr #(32) pcreg(
        .clk(clk), 
        .reset(rst), 
        .en(~StallF), 
        .d(PC_F), 
        .q(PCF)
    );

    // Instruction Memory: fetch instruction at address PCF
    imem Instruction_Memory(
        .a(PCF),
        .rd(InstrF)
    );

    // PC Adder: compute PC + 4
    adder PC_adder(
        .a(PCF),
        .b(32'h00000004), 
        .y(PCPlus4F)
    );

    // Fetch stage register with flush and stall control (flopenrc)
    flopenrc #(96) regD(
        .clk(clk), 
        .reset(rst), 
        .clear(FlushD), 
        .en(~StallD), 
        .d({InstrF, PCF, PCPlus4F}), 
        .q({InstrD, PCD, PCPlus4D})
    );

endmodule

