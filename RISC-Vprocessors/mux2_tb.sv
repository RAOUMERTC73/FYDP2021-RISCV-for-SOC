module mux2_tb;

  // Parameter for the testbench
  parameter WIDTH = 8;

  // Testbench signals
  logic [WIDTH-1:0] d0, d1;
  logic s;
  logic [WIDTH-1:0] y;

  // Instantiate the mux2 module
  mux2 #(WIDTH) dut (
    .d0(d0),
    .d1(d1),
    .s(s),
    .y(y)
  );

  // Test procedure
  initial begin
    // Test case 1: s = 0, d0 should be selected
    d0 = 8'hAA;    // Set d0 = 0xAA
    d1 = 8'h55;    // Set d1 = 0x55
    s = 0;         // Select d0
    #10;
    $display("Test 1 - s = %b, y = %h (Expected: AA)", s, y);

    // Test case 2: s = 1, d1 should be selected
    s = 1;         // Select d1
    #10;
    $display("Test 2 - s = %b, y = %h (Expected: 55)", s, y);

    // Test case 3: Change d0 and d1 values
    d0 = 8'h0F;    // Set d0 = 0x0F
    d1 = 8'hF0;    // Set d1 = 0xF0
    s = 0;         // Select d0
    #10;
    $display("Test 3 - s = %b, y = %h (Expected: 0F)", s, y);

    // End the simulation
    $stop;
  end

endmodule



