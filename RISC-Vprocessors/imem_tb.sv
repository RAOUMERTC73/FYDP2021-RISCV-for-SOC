module imem_tb;

  // Testbench signals
  logic [31:0] a;
  logic [31:0] rd;

  // Instantiate the imem module
  imem dut (
    .a(a),
    .rd(rd)
  );

  // Test procedure
  initial begin
    // Initialize the address signal
    a = 32'b0;

    // Wait for the memory to be initialized
    #10;
    $display("Testing memory reads...");

    // Apply different addresses and check the read data
    a = 32'd0;
    #10;
    $display("Address: %h, Data: %h", a, rd);

    a = 32'd4;  // Since the address is word-aligned (4 bytes)
    #10;
    $display("Address: %h, Data: %h", a, rd);

    a = 32'd8;
    #10;
    $display("Address: %h, Data: %h", a, rd);

    a = 32'd12;
    #10;
    $display("Address: %h, Data: %h", a, rd);

    // Test with another address to read data
    a = 32'd16;
    #10;
    $display("Address: %h, Data: %h", a, rd);

    // End simulation
    $finish;
  end

  // Monitor changes in address and data
  initial begin
    $monitor("At time %t, Address: %h, Read Data: %h", $time, a, rd);
  end

endmodule




