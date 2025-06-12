// Example: 10 MHz Clock, 115200 baud UART
// CLKS_PER_BIT = (Frequency of clk) / (Frequency of UART)
// (10000000)/(115200) = 87

module uart_rx #(
    parameter TICKS_PER_BIT = 87    // Clock ticks per baud period
)(
    input logic clk,                 // System clock
    input logic reset,               // Synchronous reset
    input logic rx,                  // Serial data input
    output logic [7:0] data_out,     // 8-bit parallel data received
    output logic valid               // Indicates if received data is valid
);

    logic [7:0] baud_counter;        // Counter for baud rate timing
    logic [3:0] bit_index;            // Current bit being received
    logic [9:0] shift_reg;            // Shift logic register (start + data + stop bits)
    logic [7:0] d_out;                // Data output

    typedef enum logic [1:0] {
        IDLE,       // Idle state
        RX,         // Receiving state
        CLEANUP     // Cleanup state
    } state_t;

    state_t state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            d_out <= 0;
            valid <= 1'b0;
            baud_counter <= 0;
            bit_index <= 0;
            shift_reg <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    valid <= 1'b0;
                    if (rx == 1'b0) begin // Start bit detected
                        baud_counter <= TICKS_PER_BIT / 2; // To sample in the middle of the bit
                        bit_index <= 0;
                        state <= RX;
                    end else begin
                        state <= IDLE;
                    end
                end

                RX: begin
                    if (baud_counter == TICKS_PER_BIT - 1) begin
                        if (bit_index == 9) begin
                            valid <= 1'b1;
                            d_out <= shift_reg[8:1];
                            state <= CLEANUP;
                        end else begin
                            baud_counter <= 0;
                            shift_reg[bit_index] <= rx;
                            bit_index <= bit_index + 1;
                            state <= RX;
                        end
                    end else begin
                        baud_counter <= baud_counter + 1;
                    end
                end

                CLEANUP: begin
                    if (baud_counter == TICKS_PER_BIT - 1) begin
                        baud_counter <= 0;
                        if (rx == 1'b1) begin
                            state <= IDLE;
                        end
                    end else begin
                        baud_counter <= baud_counter + 1;
                    end
                end
            endcase
        end
    end
    assign data_out = d_out;
endmodule
