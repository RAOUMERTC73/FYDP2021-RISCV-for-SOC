module uart_top
    #(
        // Default settings:
        // Baud rate: 19,200, Data bits: 8, Stop bit: 1, FIFO depth: 2^2
        parameter DBIT = 8,       // Number of data bits
                  SB_TICK = 16,   // Number of ticks for stop bits (16/24/32 for 1/1.5/2 stop bits)
                  DVSR = 163,     // Baud rate divisor (DVSR = 50M/(16 * baud rate))
                  DVSR_BIT = 8,   // Number of bits for DVSR
                  FIFO_W = 2      // Address bits for FIFO (number of words in FIFO = 2^FIFO_W)
    )
    (
        input wire clk, reset,         // Clock and reset signals
        input wire rd_uart, wr_uart,   // Read and write control signals for UART
        input wire rx,                 // UART receive input
        input wire [7:0] w_data,       // Data to be written to UART transmitter
        output wire tx_full, rx_empty, // Flags indicating if TX FIFO is full and RX FIFO is empty
        output wire tx,                // UART transmit output
        output wire [7:0] r_data       // Data read from UART receiver
    );

    // Signal declaration
    wire tick;                        // Baud rate tick signal
    wire rx_done_tick, tx_done_tick;  // Signals indicating RX and TX completion
    wire tx_empty, tx_fifo_not_empty; // TX FIFO empty and non-empty flags
    wire [7:0] tx_fifo_out;           // Data output from TX FIFO
    wire [7:0] rx_data_out;           // Data output from RX unit

    // Baud rate generator
    // Generates tick signal at specified baud rate
    mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
        (
            .clk(clk), 
            .reset(reset), 
            .q(),            // Unused output
            .max_tick(tick)  // Tick output at specified baud rate
        );

    // UART receiver
    // Receives serial data and converts it to parallel data
    uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
        (
            .clk(clk), 
            .reset(reset), 
            .rx(rx), 
            .s_tick(tick),             // Baud rate tick input
            .rx_done_tick(rx_done_tick), // Signal indicating data reception complete
            .dout(rx_data_out)          // Parallel data output from RX
        );

    // RX FIFO (Receive FIFO)
    // Buffers received data
    fifo #(.B(DBIT), .W(FIFO_W)) fifo_rx_unit
        (
            .clk(clk), 
            .reset(reset), 
            .rd(rd_uart),                 // Read control signal
            .wr(rx_done_tick),            // Write control when RX data is ready
            .w_data(rx_data_out),         // Data input from RX
            .empty(rx_empty),             // Flag indicating if RX FIFO is empty
            .full(),                      // Unused full flag
            .r_data(r_data)               // Data output to be read
        );

    // TX FIFO (Transmit FIFO)
    // Buffers data to be transmitted
    fifo #(.B(DBIT), .W(FIFO_W)) fifo_tx_unit
        (
            .clk(clk), 
            .reset(reset), 
            .rd(tx_done_tick),           // Read control when TX transmission is complete
            .wr(wr_uart),                // Write control signal
            .w_data(w_data),             // Data input to TX FIFO
            .empty(tx_empty),            // Flag indicating if TX FIFO is empty
            .full(tx_full),              // Flag indicating if TX FIFO is full
            .r_data(tx_fifo_out)         // Data output to TX unit
        );

    // UART transmitter
    // Converts parallel data to serial data for transmission
    uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit
        (
            .clk(clk), 
            .reset(reset), 
            .tx_start(tx_fifo_not_empty), // Start transmission when TX FIFO has data
            .s_tick(tick),                // Baud rate tick input
            .din(tx_fifo_out),            // Data input from TX FIFO
            .tx_done_tick(tx_done_tick),  // Signal indicating transmission complete
            .tx(tx)                       // Serial data output
        );

    // Assign TX FIFO not empty flag
    assign tx_fifo_not_empty = ~tx_empty;

endmodule
