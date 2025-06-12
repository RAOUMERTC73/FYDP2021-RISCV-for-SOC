module fifo_uart_tb;

    // Parameters
    parameter DEPTH = 16;
    parameter WIDTH_IN = 8;
    parameter WIDTH_OUT = 32;

    // Testbench signals
    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH_IN-1:0] data_in;
    logic [WIDTH_OUT-1:0] data_out;
    logic full;
    logic empty;
    logic data_out_valid;

    // Instantiate the FIFO
    fifo #(
        .DEPTH(DEPTH),
        .WIDTH_IN(WIDTH_IN),
        .WIDTH_OUT(WIDTH_OUT)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty),
        .data_out_valid(data_out_valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task to write and read data
    task automatic write_and_read(
        input [WIDTH_OUT-1:0] input_data
    );
        logic [WIDTH_IN-1:0] data_in1, data_in2, data_in3, data_in4;

        begin
            // Split the 32-bit input data into 4 8-bit chunks
            data_in1 = input_data[31:24];
            data_in2 = input_data[23:16];
            data_in3 = input_data[15:8];
            data_in4 = input_data[7:0];

            // Write 4 data values into the FIFO
            wr_en = 1;
            data_in = data_in1; @(posedge clk);
            data_in = data_in2; @(posedge clk);
            data_in = data_in3; @(posedge clk);
            data_in = data_in4; @(posedge clk);
            wr_en = 0;

            // Read the concatenated 32-bit data
            rd_en = 1;
            @(posedge clk);
            wait(data_out_valid); // Wait until data_out_valid is asserted
            rd_en = 0;

            // Check the output and show actual vs expected data
            if (data_out_valid && (data_out == input_data)) begin
                $display("[TBs] ---Test PASSED: data_out = %h, expected = %h", data_out, input_data);
            end else begin
                $display("[TB] ---Test FAILED: data_out = %h, expected = %h", data_out, input_data);
            end
        end
    endtask

    // Testbench logic
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Reset the FIFO
        @(posedge clk);
        rst = 0;

        // Call the task multiple times with different input data
        write_and_read(32'hA1B2C3D4);
        write_and_read(32'h11223344);
        write_and_read(32'h55667788);

        // Finish simulation
        @(posedge clk);
        $stop;
    end

endmodule
