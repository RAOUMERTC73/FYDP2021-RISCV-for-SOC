module uart_top_tb;

    // Parameters for simulation
    parameter TICKS_PER_BIT = 87; // Clock ticks per baud period

    // Clock period for 50 MHz clock
    localparam CLK_PERIOD = 20; // 20 ns

    logic clk;
    logic reset;
    logic start;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic busy;

    // Instantiate the DUT
    uart_top #(
        .TICKS_PER_BIT(TICKS_PER_BIT)
    ) uart_top (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .data_out(data_out),
        .busy(busy)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Test procedure to send data
    task automatic send();
        // Initialize inputs
        reset = 1;
        start = 0;

        // Apply reset
        @(posedge clk);
        reset = 0;
        // data_in = 8'b11111111;   // Worst case scenarios
        // data_in = 8'b00000000;   // Worst case scenarios
        // data_in = 8'b10101010;   // Worst case scenarios
        // data_in = 8'b01010101;   // Worst case scenarios
        // data_in = 8'b01111110;   // Worst case scenarios
        // data_in = 8'b10000001;   // Worst case scenarios
        // data_in = 8'b11110000;   // Worst case scenarios
        data_in = $random() % $random() + $random();
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge clk);
        wait(~busy);
        if(data_in != data_out)
            $display("-----FAILED-----Data tx: %h, Data rx: %h", data_in, data_out);
        else
            $display("-----SUCCESS-----Data tx: %h, Data rx: %h", data_in, data_out);
    endtask //automatic




    initial begin
        repeat(10) // Number of transmissions
        send(); // Send data
        $stop; // Stop simulation
    end

endmodule
