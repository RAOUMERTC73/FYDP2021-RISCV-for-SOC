module mod_m_counter
#(
    parameter N = 4,   // Number of bits in counter
    parameter M = 10   // Modulus M
)
(
    input wire clk, reset,
    output wire max_tick,
    output wire [N-1:0] q
);

// Signal declaration
reg [N-1:0] r_reg;
wire [N-1:0] r_next;

// Body
// Register
always @(posedge clk, posedge reset) begin
    if (reset)
        r_reg <= 0;
    else
        r_reg <= r_next;
end

// Next-state logic
assign r_next = (r_reg == (M - 1)) ? 0 : r_reg + 1;

// Output logic
assign q = r_reg;
assign max_tick = (r_reg == (M - 1)) ? 1'b1 : 1'b0;

endmodule
