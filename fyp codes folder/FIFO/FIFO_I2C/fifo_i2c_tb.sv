module fifo_i2c_tb;

    // Parameters
    parameter DEPTH     = 16;
    parameter WIDTH_IN  = 32;
    parameter WIDTH_OUT = 8;

    // Testbench signals
    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH_IN-1:0]  data_in;
    logic [WIDTH_OUT-1:0] data_out;
    logic full;
    logic empty;
    logic dout_valid;

    // Instantiate the FIFO
    fifo_i2c #(
        .DEPTH    (DEPTH),
        .WIDTH_IN (WIDTH_IN),
        .WIDTH_OUT(WIDTH_OUT)
    ) DUT (
        .clk           (clk),
        .rst           (rst),
        .wr_en         (wr_en),
        .rd_en         (rd_en),
        .data_in       (data_in),
        .data_out      (data_out),
        .full          (full),
        .empty         (empty),
        .dout_valid    (dout_valid)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task to write and read data
    task automatic write_and_read(input [WIDTH_IN-1:0] input_data);
        logic [WIDTH_OUT-1:0] expected_data[3:0];
        begin
            // Split the 32-bit input data into 4 8-bit chunks
            expected_data[3] = input_data[31:24];
            expected_data[2] = input_data[23:16];
            expected_data[1] = input_data[15:8];
            expected_data[0] = input_data[7:0];

            // Write the 32-bit input data into the FIFO
            wr_en   = 1;
            data_in = input_data;
            @(posedge clk);
            wr_en   = 0;

            // Read 4 8-bit outputs sequentially from the FIFO
            rd_en = 1;
            foreach (expected_data[i]) begin
                @(posedge clk);
                wait(dout_valid); // Wait until dout_valid is asserted
                if (data_out == expected_data[i]) begin
                    $display("[TB] ---Test PASSED: Time: %0t, data_out = %h, expected = %h---", $time, data_out, expected_data[i]);
                end else begin
                    $display("[TB] ---Test FAILED: Time: %0t, data_out = %h, expected = %h---", $time, data_out, expected_data[i]);
                end
            end
            rd_en = 0;
        end
    endtask

    // Testbench logic
    initial begin
        // Initialize signals
        clk     = 0;
        rst     = 1;
        wr_en   = 0;
        rd_en   = 0;
        data_in = 0;

        // Reset the FIFO
        @(posedge clk);
        rst = 0;

        // Call the task multiple times with different input data
        write_and_read(32'hA1B2C3D4);
        // write_and_read(32'h11223344);
        // write_and_read(32'h55667788);

        // Finish simulation
        @(posedge clk);
        $stop;
    end

endmodule
