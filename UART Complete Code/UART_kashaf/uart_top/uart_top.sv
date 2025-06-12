// Example: 10 MHz Clock, 115200 baud UART
// CLKS_PER_BIT = (Frequency of clk) / (Frequency of UART)
// (10000000)/(115200) = 87


module uart_top #(
    parameter TICKS_PER_BIT = 87    // Clock ticks per baud period
)(
    input logic clk,                 // System clock
    input logic reset,               // Synchronous reset
    input logic start,               // Start signal for transmission
    input logic [7:0] data_in,       // 8-bit parallel data to transmit
    output logic [7:0] data_out,     // 8-bit parallel data output
    output logic busy                // Busy signal
);

    logic line;                     // UART transmission line signal (output of tx and input of rx)

    // Instantiate the UART transmitter
    uart_tx #(
        .TICKS_PER_BIT(TICKS_PER_BIT)
    ) uart_tx (
        .clk(clk),                // System clock
        .reset(reset),          // Synchronous reset
        .start(start),        // Start signal for transmission
        .data_in(data_in),  // 8-bit parallel data to transmit
        .tx(line),            // UART transmission line signal
        .busy(busy)         // Busy signal
    );

    // Instantiate the UART receiver
    uart_rx #(
        .TICKS_PER_BIT(TICKS_PER_BIT)
    ) uart_rx (
        .clk(clk),              // System clock
        .reset(reset),      // Synchronous reset
        .rx(line),          // UART transmission line signal
        .valid(valid),       // Data valid signal
        .data_out(data_out) // 8-bit parallel data output
    );

endmodule