module hazard(
    input logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    input logic PCSrcE, ResultSrcE0,
    input logic RegWriteM, RegWriteW,
    output logic [1:0] ForwardAE, ForwardBE,
    output logic StallF, StallD, FlushD, FlushE
);

logic lwStallD;

// Forwarding logic
always_comb begin
    ForwardAE = 2'b00;
    ForwardBE = 2'b00;

    if (Rs1E != 5'b0) begin
        if ((Rs1E == RdM) & RegWriteM) ForwardAE = 2'b10;
        else if ((Rs1E == RdW) & RegWriteW) ForwardAE = 2'b01;
    end

    if (Rs2E != 5'b0) begin
        if ((Rs2E == RdM) & RegWriteM) ForwardBE = 2'b10;
        else if ((Rs2E == RdW) & RegWriteW) ForwardBE = 2'b01;
    end
end

// Stalls and flushes
assign lwStallD = ResultSrcE0 & ((Rs1D == RdE) | (Rs2D == RdE));
assign StallF = lwStallD;
assign StallD = lwStallD;
assign FlushD = PCSrcE;
assign FlushE = lwStallD | PCSrcE;

endmodule
