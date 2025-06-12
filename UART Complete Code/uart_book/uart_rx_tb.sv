`timescale 1ns / 1ps

module uart_rx_tb;

    // Parameters
    localparam DBIT = 8;        // Data bits
    localparam SB_TICK = 16;    // Ticks for stop bits

    // Signals for testbench
    reg clk;                    // Clock signal
    reg reset;                  // Reset signal
    reg rx;                     // RX input signal
    reg s_tick;                 // Baud tick signal
    wire rx_done_tick;          // RX done tick output
    wire [7:0] dout;            // Received data output


    reg [7:0] data_in;
    logic sim_stop = 0;
    // DUT instantiation
    uart_rx #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK)
    ) dut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .s_tick(s_tick),
        .rx_done_tick(rx_done_tick),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus generation
    initial begin
        // Initialize signals
        reset = 1;
        rx = 1;                // Idle state (high)
        s_tick = 0;

        // Apply reset
        @(posedge clk); reset = 0;

        // Test Case 1: Transmit 8-bit data (0xA5 = 10100101)
        data_in = 8'hA5;
        send_byte(data_in);


        if(sim_stop)
            $display("-------------NORMAL STOP--------------");
            $stop;
    end

    // Task to send a byte over RX
    task send_byte(input [7:0] Byte);
        integer i;
        begin
            // Start bit (low)
            rx = 0;
            tick_delay();

            // Send data bits (LSB first)
            for (i = 0; i < DBIT; i = i + 1) begin
                rx = Byte[i];
                tick_delay();
            end

            // Stop bit (high)
            rx = 1;
            sim_stop = 1;
        end
    endtask

    // Task to generate baud ticks
    task tick_delay();
        begin
            repeat(SB_TICK) begin
                @(posedge clk); s_tick = 1; // Assert tick for one clock cycle
                @(posedge clk); s_tick = 0; // De-assert tick
            end
        end
    endtask

    // Monitor signals
    initial begin
        $monitor("data_in=%h | RX: %b | data_out: %h | rx_done_tick: %b", 
                 data_in, rx, dout, rx_done_tick);
    end

endmodule
