//`include "mux3.sv"   // 3-input multiplexer module

module writeback_cycle(
    input logic clk, rst,
    input logic [1:0] ResultSrcW,
    input logic [31:0] PCPlus4W, ALUResultW, ReadDataW,
    output logic [31:0] ResultW
);

    // Mux for selecting the result in the writeback stage
    mux3 #(32) resultmux(
        .d0(ALUResultW),
        .d1(ReadDataW),
        .d2(PCPlus4W),
        .s(ResultSrcW),
        .y(ResultW)
    );

endmodule
