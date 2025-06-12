module fifo_uart #(
    parameter DEPTH = 16, // Depth of the FIFO
    parameter WIDTH_IN = 8,  // Width of the input data
    parameter WIDTH_OUT = 32 // Width of the output data
)(
    input logic clk,
    input logic rst,
    input logic wr_en,
    input logic rd_en,
    input logic [WIDTH_IN-1:0] data_in,
    output logic [WIDTH_OUT-1:0] data_out,
    output logic full,
    output logic empty,
    output logic data_out_valid // New signal for valid output
);

    // Internal signals
    logic [WIDTH_IN-1:0] mem [0:DEPTH-1]; // FIFO memory
    logic [$clog2(DEPTH):0] wr_ptr;       // Write pointer
    logic [$clog2(DEPTH):0] rd_ptr;       // Read pointer
    logic [$clog2(DEPTH):0] count;        // Number of elements in FIFO
    logic [WIDTH_OUT-1:0] concat_buffer;  // Buffer for concatenated output
    logic [1:0] concat_count;             // Counter for concatenation (0 to 3)

    // Write operation
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read and concatenate operation
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            data_out <= 0;
            concat_buffer <= 0;
            concat_count <= 0;
            data_out_valid <= 0; // Reset valid signal
        end else if (rd_en && !empty) begin
            concat_buffer <= {concat_buffer[WIDTH_OUT-WIDTH_IN-1:0], mem[rd_ptr]};
            rd_ptr <= rd_ptr + 1;
            concat_count <= concat_count + 1;

            if (concat_count == 2'b11) begin
                data_out <= {concat_buffer[WIDTH_OUT-WIDTH_IN-1:0], mem[rd_ptr]};
                concat_buffer <= 0;
                concat_count <= 0;
                data_out_valid <= 1; // Set valid signal when output is ready
            end else begin
                data_out_valid <= 0; // Clear valid signal otherwise
            end
        end else begin
            data_out_valid <= 0; // Clear valid signal when not reading
        end
    end

    // Count management
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
        end else begin
            case ({wr_en, rd_en})
                2'b10: if (!full) count <= count + 1; // Write only
                2'b01: if (!empty) count <= count - 1; // Read only
                default: count <= count; // No operation or simultaneous read/write
            endcase
        end
    end

    // Full and empty flags
    assign full = (count == DEPTH);
    assign empty = (count == 0);

endmodule