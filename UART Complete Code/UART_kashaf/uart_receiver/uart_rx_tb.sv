module uart_rx_tb();
    parameter TICKS_PER_BIT = 87; // Clock ticks per baud period

    // Clock period for 50 MHz clock
    localparam CLK_PERIOD = 20; // 20 ns

    logic clk;
    logic reset;
    logic rx;
    logic [7:0] data_out;
    logic valid;
    logic [7:0] din;    // Data to be transmitted
    logic [9:0] shift_reg;

    uart_rx #(
        .TICKS_PER_BIT(TICKS_PER_BIT)
    ) uart_rx_DUT (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_out(data_out),
        .valid(valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Task to send data
task automatic send();
    
    // reset the DUT
    reset = 1;
    rx = 1;
    @(posedge clk); 
    reset = 0;
    @(posedge clk);
    
    din = $random();
    // din = 8'b10010011;
    shift_reg = {1'b1,din,1'b0};
    for(int i=0;i<9;i++) begin
        rx = shift_reg[i];
        repeat(TICKS_PER_BIT) @(posedge clk);   // means give a delay of 1 baud period after every bit.
    end
    wait(valid);

    if(data_out == din) begin
        $display("------------SUCCESS: Data Tx: %h, Data Rx: %h------------", din, data_out);
    end else begin
        $display("------------FAILED: Data Tx: %h, Data Rx: %h------------", din, data_out);
    end
    endtask //automatic



initial begin

    // transmitt the data 
    repeat(10) begin
        send();
    end
    $stop;
end

endmodule