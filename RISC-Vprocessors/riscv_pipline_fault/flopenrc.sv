module flopenrc #(parameter WIDTH = 8) (
    input logic clk, reset, clear, en,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            q <= 0;          // Asynchronous reset
        else if (clear)
            q <= 0;          // Synchronous clear
        else if (en)
            q <= d;          // Capture input data if enabled
    end

endmodule
