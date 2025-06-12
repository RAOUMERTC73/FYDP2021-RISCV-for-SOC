
// module uart_tx #(
//     parameter TICKS_PER_BIT = 87;    // Clock ticks per baud period
// )(
//     input logic clk,                 // System clock
//     input logic reset,               // Synchronous reset
//     input logic start,               // Start signal for transmission
//     input logic [7:0] data_in,       // 8-bit parallel data to transmit
//     output logic tx,                  // Serial data output
//     output logic busy                 // Indicates if transmission is ongoing
// );

//     // Calculating clock ticks per baud period
//     localparam TICKS_PER_BIT = CLK_FREQ / BAUD_RATE;

//     logic [15:0] baud_counter;        // Counter for baud rate timing
//     logic [3:0] bit_index;            // Current bit being transmitted
//     logic [9:0] shift_reg;            // Shift logic register (start + data + stop bits)

//     typedef enum logic {
//         IDLE,       // Idle state
//         TX          // Transmission state
//     } state_t;

//     state_t state;

//     always @(posedge clk or posedge reset) begin
//         if (reset) begin
//             tx <= 1'b1;                 // Idle state (UART line high)
//             busy <= 1'b0;
//             baud_counter <= 0;
//             bit_index <= 0;
//             shift_reg <= 0;
//             state <= IDLE;
//         end else begin
//             case (state)
//                 IDLE: begin
//                     tx <= 1'b1;         // Line remains high
//                     busy <= 1'b0;
//                     if (start) begin
//                         busy <= 1'b1;
//                         shift_reg <= {1'b1, data_in, 1'b0}; // Stop, data, Start bits
//                         bit_index <= 0;
//                         state <= TX;
//                     end
//                 end

//                 TX: begin
//                     if (baud_counter == TICKS_PER_BIT - 1) begin
//                         baud_counter <= 0;
//                         tx <= shift_reg[bit_index];
//                         bit_index <= bit_index + 1;

//                         if (bit_index == 10) begin
//                             state <= IDLE; // All bits transmitted
//                             tx <= 1'b1;
//                         end
//                     end else begin
//                         baud_counter <= baud_counter + 1;
//                     end
//                 end
//             endcase
//         end
//     end
// endmodule






// Example: 10 MHz Clock, 115200 baud UART
// CLKS_PER_BIT = (Frequency of clk) / (Frequency of UART)
// (10000000)/(115200) = 87


module uart_tx #(
    parameter TICKS_PER_BIT = 87    // Clock ticks per baud period
)(
    input logic clk,                 // System clock
    input logic reset,               // Synchronous reset
    input logic start,               // Start signal for transmission
    input logic [7:0] data_in,       // 8-bit parallel data to transmit
    output logic tx,                  // Serial data output
    output logic busy                 // Indicates if transmission is ongoing
);

    logic [7:0] baud_counter;        // Counter for baud rate timing
    logic [3:0] bit_index;            // Current bit being transmitted
    logic [9:0] shift_reg;            // Shift logic register (start + data + stop bits)

    typedef enum logic {
        IDLE,       // Idle state
        TX          // Transmission state
    } state_t;

    state_t state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1'b1;                 // Idle state (UART line high)
            busy <= 1'b0;
            baud_counter <= 0;
            bit_index <= 0;
            shift_reg <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;         // Line remains high
                    busy <= 1'b0;
                    if (start) begin
                        busy <= 1'b1;
                        shift_reg <= {1'b1, data_in, 1'b0}; // Stop, data, Start bits
                        bit_index <= 0;
                        state <= TX;
                    end
                end

                TX: begin
                    if (baud_counter == TICKS_PER_BIT - 1) begin    // 1 tick before the end of the baud period
                        baud_counter <= 0;
                        tx <= shift_reg[bit_index];
                        bit_index <= bit_index + 1;

                        if (bit_index == 10) begin
                            state <= IDLE; // All bits transmitted
                            tx <= 1'b1;
                        end
                    end else begin
                        baud_counter <= baud_counter + 1;
                    end
                end
            endcase
        end
    end
endmodule