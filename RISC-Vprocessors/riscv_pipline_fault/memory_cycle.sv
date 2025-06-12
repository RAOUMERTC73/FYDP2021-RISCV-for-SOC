`include "dmem.sv"       // Data memory module
//`include "flopr.sv"      // Flip-flop with reset

module memory_cycle(
    input logic clk, rst, 
    input logic MemWriteM,
    input logic [4:0] RdM,
    input logic [31:0] PCPlus4M, WriteDataM, ALUResultM,
    output logic [4:0] RdW,
    output logic [31:0] PCPlus4W, ALUResultW, ReadDataW
);

    // Interim wire for memory read data
    logic [31:0] ReadDataM;

    // Instantiate data memory module
    dmem Data_Memory(
        .clk(clk), 
        .we(MemWriteM), 
        .a(ALUResultM), 
        .wd(WriteDataM), 
        .rd(ReadDataM)
    );

    // Memory stage pipeline register 
    // Stores ALU result, read data from memory, RdM, and PC+4
    flopr #(101) regM(
        .clk(clk), 
        .reset(rst), 
        .d({ALUResultM, ReadDataM, RdM, PCPlus4M}),
        .q({ALUResultW, ReadDataW, RdW, PCPlus4W})
    );

endmodule



/* module memory_cycle(clk, rst,MemWriteM, RdM, PCPlus4M, WriteDataM, ALUResultM, RdW, PCPlus4W, ALUResultW, ReadDataW);
    
    // Declaration of I/Os
    input logic clk, rst, MemWriteM;
    input logic [4:0] RdM; 
    input logic [31:0] PCPlus4M, WriteDataM, ALUResultM;

    output logic [4:0] RdW;
    output logic [31:0] PCPlus4W, ALUResultW, ReadDataW;

    // Declaration of Interim Wires
    wire [31:0] ReadDataM;

    // Declaration of Module Initiation
    dmem Data_Memory(.clk(clk), .we(MemWriteM),.a(ALUResultM),.wd(WriteDataM),.rd(ReadDataM));

    // Memory Stage Register Logic
    //Memory stage pipeline register 
	flopr #(101) regM(clk,rst,{ALUResultM,ReadDataM,RdM,PCPlus4M},{ALUResultW,WriteDataW,RdW,PCPlus4W});



endmodule
 */