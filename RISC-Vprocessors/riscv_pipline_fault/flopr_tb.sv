module  flopr_tb;

  // Parameters
  parameter WIDTH = 8;

  // Inputs
  logic clk;
  logic reset;
  logic [WIDTH-1:0] d;

  // Outputs
  logic [WIDTH-1:0] q;

  // Instantiate the Flip-Flop module
  flopr #(WIDTH) uut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    d = 0;

    // Test vector 1: Apply reset
    #10 reset = 1; d = 8'b10101010;
    #10 reset = 0;

    // Test vector 2: Normal operation
    #10 d = 8'b11001100;
    #10 d = 8'b11110000;

    // Test vector 3: Apply reset again
    #10 reset = 1;
    #10 reset = 0;

    // Test vector 4: Normal operation again
    #10 d = 8'b00001111;

    // End simulation
    #10 $stop;
  end

  initial begin
    $monitor("At time %t, clk = %b, reset = %b, d = %b, q = %b", $time, clk, reset, d, q);
  end

endmodule
