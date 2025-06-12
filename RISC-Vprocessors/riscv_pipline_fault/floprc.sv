/* module floprc #(parameter WIDTH = 8) (
    input logic clk, reset, clear,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            q <= 0;          // Asynchronous reset
        else if (clear)
            q <= 0;          // Synchronous clear
        else
            q <= d;          // Capture input data
    end

endmodule
 */
 module floprc #(parameter WIDTH = 8) (
    input logic clk,            // Clock signal
    input logic reset,          // Asynchronous reset
    input logic clear,          // Synchronous clear
    input logic [WIDTH-1:0] d,  // Input data
    output logic [WIDTH-1:0] q  // Output data
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;             // Asynchronous reset
        else if (clear)
            q <= 0;             // Synchronous clear
        else
            q <= d;             // Capture input data
    end

endmodule
