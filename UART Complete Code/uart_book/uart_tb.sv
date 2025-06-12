module uart_tb;

    // Parameters for UART configuration
    localparam DBIT = 8;        // Number of data bits
    localparam SB_TICK = 16;    // Number of ticks for stop bits
    localparam DVSR = 163;      // Baud rate divisor
    localparam DVSR_BIT = 8;    // Number of bits for DVSR
    localparam FIFO_W = 2;      // Address bits for FIFO

    // Testbench signals
    reg clk;                     // Clock signal
    reg reset;                   // Reset signal
    reg rd_uart;                 // Read control signal for UART
    reg wr_uart;                 // Write control signal for UART
    reg rx;                      // UART receive input
    reg [7:0] w_data;            // Data to be transmitted
    wire tx_full;                // TX FIFO full flag
    wire rx_empty;               // RX FIFO empty flag
    wire tx;                     // UART transmit output
    wire [7:0] r_data;           // Data received from UART

    // Instantiate the UART top module
    uart_top #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK),
        .DVSR(DVSR),
        .DVSR_BIT(DVSR_BIT),
        .FIFO_W(FIFO_W)
    ) uut (
        .clk(clk),
        .reset(reset),
        .rd_uart(rd_uart),
        .wr_uart(wr_uart),
        .rx(rx),
        .w_data(w_data),
        .tx_full(tx_full),
        .rx_empty(rx_empty),
        .tx(tx),
        .r_data(r_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    // Test procedure
    initial begin
        // Initialize signals
        reset = 1;
        rd_uart = 0;
        wr_uart = 0;
        rx = 1; // Idle state for UART RX
        w_data = 8'h00;

        // Reset the system
        @(posedge clk); reset = 0;

        // Simulate UART transmission and reception
        @(posedge clk); wr_uart = 1; 
        w_data = 8'hA5; // Write a byte to UART
        @(posedge clk); wr_uart = 0;

        // Wait for TX to complete
        wait (!tx_full);

        // Simulate receiving data
        @(posedge clk); rx = 0; // Start bit
        @(posedge clk); rx = 1; // Transmit bits (mock data)
        @(posedge clk); rx = 0;
        @(posedge clk); rx = 1;
        @(posedge clk); rx = 0;
        @(posedge clk); rx = 1;
        @(posedge clk); rx = 0;
        @(posedge clk); rx = 1;
        @(posedge clk); rx = 1; // Stop bit

        // Wait for RX data to be available
        wait (!rx_empty);
        rd_uart = 1; 
        @(posedge clk); rd_uart = 0; // Read data


        $display("data_in=%b, data_out=%b", w_data, w_data);
        // End simulation
        @(posedge clk); $stop;
    end

endmodule
