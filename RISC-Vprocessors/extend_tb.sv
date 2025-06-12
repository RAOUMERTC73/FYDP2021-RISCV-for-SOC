module extend_tb;

  // Inputs
  logic [31:7] instr;
  logic [1:0] immsrc;

  // Outputs
  logic [31:0] immext;

  // Instantiate the Extend module
  extend uut (
    .instr(instr), 
    .immsrc(immsrc), 
    .immext(immext)
  );

  initial begin
    // Initialize Inputs
    instr = 0;
    immsrc = 0;

    // Test vector 1: I-type instruction (e.g., addi)
    #10 instr = 25'h00FFF; immsrc = 2'b00;
    
    // Test vector 2: S-type instruction (e.g., sw)
    #10 instr = 25'h1F123; immsrc = 2'b01;
    
    // Test vector 3: B-type instruction (e.g., beq)
    #10 instr = 25'h0FFFE; immsrc = 2'b10;
    
    // Test vector 4: J-type instruction (e.g., jal)
    #10 instr = 25'h07F45; immsrc = 2'b11;
    
    // End simulation
    #10 $stop;
  end

  initial begin
    $monitor("At time %t, instr = %h, immsrc = %b, immext = %h", $time, instr, immsrc, immext);
  end

endmodule



