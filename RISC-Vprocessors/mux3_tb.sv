module mux3_tb;

  // Parameter for the testbench
  parameter WIDTH = 8;

  // Testbench signals
  logic [WIDTH-1:0] d0, d1, d2;
  logic [1:0] s;
  logic [WIDTH-1:0] y;

  // Instantiate the mux3 module
  mux3 #(WIDTH) dut (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .s(s),
    .y(y)
  );

  // Test procedure
  initial begin
    // Initialize inputs
    d0 = 8'h11;    // Set d0 = 0x11
    d1 = 8'h22;    // Set d1 = 0x22
    d2 = 8'h33;    // Set d2 = 0x33
    s = 2'b00;     // Select d0

    // Test case 1: s = 00, d0 should be selected
    #10;
    $display("Test 1 - s = %b, y = %h (Expected: 11)", s, y);

    // Test case 2: s = 01, d1 should be selected
    s = 2'b01;     // Select d1
    #10;
    $display("Test 2 - s = %b, y = %h (Expected: 22)", s, y);

    // Test case 3: s = 10, d2 should be selected
    s = 2'b10;     // Select d2
    #10;
    $display("Test 3 - s = %b, y = %h (Expected: 33)", s, y);

    // End simulation
    $stop;
  end

endmodule



