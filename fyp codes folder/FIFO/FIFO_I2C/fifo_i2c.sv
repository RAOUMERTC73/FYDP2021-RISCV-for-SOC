module fifo_i2c #(
    parameter DEPTH = 16,         // Depth of the FIFO
    parameter WIDTH_IN = 32,      // Width of the input data
    parameter WIDTH_OUT = 8       // Width of the output data
)(
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   wr_en,
    input  logic                   rd_en,
    input  logic [WIDTH_IN-1:0]    data_in,
    output logic [WIDTH_OUT-1:0]   data_out,
    output logic                   full,
    output logic                   empty,
    output logic                   dout_valid
);

    // Internal signals
    logic [WIDTH_IN-1:0] mem [0:DEPTH-1]; // FIFO memory
    logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr; // Write and read pointers
    logic [$clog2(DEPTH):0] count;           // Element count
    logic [1:0] byte_counter;                // Byte counter for output
    logic [WIDTH_IN-1:0] current_data;       // Holds the current 32-bit word
    logic output_active;                     // Indicates outputting bytes from a popped word
    logic output_active_d, output_active_d2;                   // Delayed output_active for dout_valid

    // Write operation
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // Read and output operation
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            count <= 0;
            byte_counter <= 0;
            current_data <= 0;
            data_out <= 0;
            output_active <= 0;
        end else begin
            // Pop a word if requested and not empty, and not already outputting
            if (rd_en && !empty && !output_active) begin
                current_data <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
                byte_counter <= 0;
                output_active <= 1;
            end

            // Output bytes from the current_data if output_active
            if (output_active) begin
                case (byte_counter)
                    2'd0: data_out <= current_data[31:24];
                    2'd1: data_out <= current_data[23:16];
                    2'd2: data_out <= current_data[15:8];
                    2'd3: data_out <= current_data[7:0];
                endcase
                byte_counter <= byte_counter + 1;
                if (byte_counter == 2'd3) begin
                    output_active <= 0;
                end
            end
        end
    end

    // Delay output_active by 1 clk cycle for dout_valid
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            output_active_d <= 0;
            output_active_d2 <= 0;
        end else begin
            output_active_d <= output_active;
            output_active_d2 <= output_active_d;
        end
    end

    assign dout_valid = output_active_d;

    // Full and empty flags
    assign full = (count == DEPTH);
    assign empty = (count == 0);

    // Count management (write increments, pop decrements)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // already reset above
        end else begin
            if (wr_en && !full) count <= count + 1;
            // count-- is handled above on pop
        end
    end

endmodule
