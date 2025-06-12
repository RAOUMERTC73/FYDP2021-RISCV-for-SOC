module dmem_tb;

  // Inputs
  bit clk;
  logic we;
  logic [31:0] a;
  logic [31:0] wd;

  // Outputs
  logic [31:0] rd;

  // Instantiate the Data Memory module
  dmem uut (
    .clk(clk), 
    .we(we), 
    .a(a), 
    .wd(wd), 
    .rd(rd)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk = 0;
    we = 0;
    a = 0;
    wd = 0;

    // Load initial memory content from hex file
    $readmemh("riscvtest.hex", uut.RAM);

    // Test Write and Read Operations
    #10 we = 1; a = 32'h00000010; wd = 32'hDEADBEEF; // Write to address 0x10
    #10 we = 0; a = 32'h00000010;                  // Read from address 0x10

    #10 we = 1; a = 32'h00000014; wd = 32'hCAFEBABE; // Write to address 0x14
    #10 we = 0; a = 32'h00000014;                  // Read from address 0x14

    #10 $stop; // End simulation
  end

  initial begin
    $monitor("At time %t, clk = %b, we = %b, a = %h, wd = %h, rd = %h", $time, clk, we, a, wd, rd);
  end

endmodule


