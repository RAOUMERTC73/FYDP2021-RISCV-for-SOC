`timescale 1ns / 1ps

module uart_tx_tb;

    // Parameters
    localparam DBIT = 8;        // Data bits
    localparam SB_TICK = 16;    // Ticks for stop bits

    // Signals for testbench
    reg clk;                    // Clock signal
    reg reset;                  // Reset signal
    reg tx_start;               // Start transmission signal
    reg s_tick;                 // Baud tick signal
    reg [7:0] din;              // Data to be transmitted
    wire tx_done_tick;          // TX done tick output
    wire tx;                    // Transmitted signal

    // DUT instantiation
    uart_tx #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK)
    ) dut (
        .clk(clk),
        .reset(reset),
        .tx_start(tx_start),
        .s_tick(s_tick),
        .din(din),
        .tx_done_tick(tx_done_tick),
        .tx(tx)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        reset = 1;
        tx_start = 0;
        s_tick = 0;
        din = 0;

        // Reset the system
        @(posedge clk);
        reset = 0;
        @(posedge clk);

        // Test Case 1: Transmit a single byte
        din = 8'hA5;            // Test data: 10100101
        tx_start = 1;           // Start transmission
        @(posedge clk);
        tx_start = 0;       // De-assert start signal

        // Simulate baud ticks
        repeat (160) begin
            @(posedge clk) s_tick = 1;     // Assert tick for one cycle
            @(posedge clk) s_tick = 0;
        end

        // Wait for TX done
        wait(tx_done_tick);
        @(posedge clk);

        // End simulation
        $stop;
    end

    // Monitor signals
    initial begin
        $monitor(" tx_start: %b | din: %b | tx_done_tick: %b | tx: %b", 
                 tx_start, din, tx_done_tick, tx);
    end

endmodule
