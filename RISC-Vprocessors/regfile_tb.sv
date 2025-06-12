module regfile_tb;

  // Testbench signals
  logic clk;
  logic we3;
  logic [4:0] a1, a2, a3;
  logic [31:0] wd3;
  logic [31:0] rd1, rd2;

  // Instantiate the regfile module
  regfile dut (
    .clk(clk),
    .we3(we3),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .wd3(wd3),
    .rd1(rd1),
    .rd2(rd2)
  );

  // Clock generation
  always #5 clk = ~clk;  // Clock with period of 10ns

  // Test procedure
  initial begin
    // Initialize signals
    clk = 0;
    we3 = 0;
    a1 = 0;
    a2 = 0;
    a3 = 0;
    wd3 = 0;

    // Wait for reset
    #10;

    // Write test case 1: Write 32'hABCD1234 to register 1
    a3 = 5'd1;     // Select register 1 for writing
    wd3 = 32'hABCD1234; // Write data
    we3 = 1;       // Enable write
    #10;           // Wait for one clock cycle
    we3 = 0;       // Disable write

    // Read test case 1: Read from register 1
    a1 = 5'd1;     // Select register 1 for reading on rd1
    #10;
    $display("Test 1 - Read register 1: rd1 = %h (Expected: ABCD1234)", rd1);

    // Write test case 2: Write 32'h12345678 to register 2
    a3 = 5'd2;     // Select register 2 for writing
    wd3 = 32'h12345678; // Write data
    we3 = 1;       // Enable write
    #10;           // Wait for one clock cycle
    we3 = 0;       // Disable write

    // Read test case 2: Read from register 2
    a2 = 5'd2;     // Select register 2 for reading on rd2
    #10;
    $display("Test 2 - Read register 2: rd2 = %h (Expected: 12345678)", rd2);

    // Test register 0 (which should always read 0)
    a1 = 5'd0;     // Select register 0 for reading
    #10;
    $display("Test 3 - Read register 0: rd1 = %h (Expected: 0)", rd1);

    // Write test case 3: Write 32'hDEADBEEF to register 3
    a3 = 5'd3;     // Select register 3 for writing
    wd3 = 32'hDEADBEEF; // Write data
    we3 = 1;       // Enable write
    #10;           // Wait for one clock cycle
    we3 = 0;       // Disable write

    // Read test case 3: Read from register 3
    a1 = 5'd3;     // Select register 3 for reading
    a2 = 5'd1;     // Also read register 1 at the same time
    #10;
    $display("Test 4 - Read register 3: rd1 = %h (Expected: DEADBEEF)", rd1);
    $display("Test 4 - Read register 1: rd2 = %h (Expected: ABCD1234)", rd2);

    // End simulation
    $finish;
  end

endmodule



