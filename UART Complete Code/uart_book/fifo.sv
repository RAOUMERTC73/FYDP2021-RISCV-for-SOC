module fifo #(
    parameter B = 8,  // Number of bits in a word
    parameter W = 4   // Number of address bits
)(
    input wire clk,
    input wire reset,
    input wire rd,
    input wire wr,
    input wire [B-1:0] w_data,
    output wire empty,
    output wire full,
    output wire [B-1:0] r_data
);

    // Signal declarations
    reg [B-1:0] array_reg [2**W-1:0]; // Register array
    reg [W-1:0] w_ptr_reg, w_ptr_next, w_ptr_succ; // Write pointers
    reg [W-1:0] r_ptr_reg, r_ptr_next, r_ptr_succ; // Read pointers
    reg full_reg, empty_reg, full_next, empty_next; // Full and empty flags
    wire wr_en;

    // Body

    // Register file write operation
    always @(posedge clk) begin
        if (wr_en)
            array_reg[w_ptr_reg] <= w_data;
    end

    // Register file read operation
    assign r_data = array_reg[r_ptr_reg];

    // Write enable: active only when FIFO is not full
    assign wr_en = wr & ~full_reg;

    // FIFO control logic
    // Register updates for read and write pointers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr_reg <= 0;
            r_ptr_reg <= 0;
            full_reg <= 1'b0;
            empty_reg <= 1'b1;
        end else begin
            w_ptr_reg <= w_ptr_next;
            r_ptr_reg <= r_ptr_next;
            full_reg <= full_next;
            empty_reg <= empty_next;
        end
    end

    // Next-state logic for read and write pointers
    always @* begin
        // Successive pointer values
        w_ptr_succ = w_ptr_reg + 1;
        r_ptr_succ = r_ptr_reg + 1;

        // Default: keep old values
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        full_next = full_reg;
        empty_next = empty_reg;

        case ({wr, rd})
            2'b00: ; // No operation
            2'b01: // Read
                if (~empty_reg) begin
                    r_ptr_next = r_ptr_succ;
                    full_next = 1'b0;
                    if (r_ptr_succ == w_ptr_reg)
                        empty_next = 1'b1;
                end
            2'b10: // Write
                if (~full_reg) begin
                    w_ptr_next = w_ptr_succ;
                    empty_next = 1'b0;
                    if (w_ptr_succ == r_ptr_reg)
                        full_next = 1'b1;
                end
            2'b11: // Write and read
                begin
                    w_ptr_next = w_ptr_succ;
                    r_ptr_next = r_ptr_succ;
                end
        endcase
    end

    // Output assignments
    assign full = full_reg;
    assign empty = empty_reg;

endmodule
