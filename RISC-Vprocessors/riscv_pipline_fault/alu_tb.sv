
module alu_tb;

  // Inputs
  logic [31:0] a;
  logic [31:0] b;
  logic [2:0] alucontrol;

  // Outputs
  logic [31:0] result;
  logic zero;

  // Instantiate the ALU module
  alu uut (
    .a(a), 
    .b(b), 
    .alucontrol(alucontrol), 
    .result(result), 
    .zero(zero)
  );

  initial begin
    // Initialize Inputs
    a = 0;
    b = 0;
    alucontrol = 0;

    // Test vector 1: Add
    #10 a = 32'h00000005; b = 32'h00000003; alucontrol = 3'b000;
    
    // Test vector 2: Subtract
    #10 a = 32'h00000008; b = 32'h00000003; alucontrol = 3'b001;
    
    // Test vector 3: AND
    #10 a = 32'hFFFFFFFF; b = 32'h0F0F0F0F; alucontrol = 3'b010;
    
    // Test vector 4: OR
    #10 a = 32'hAAAAAAAA; b = 32'h55555555; alucontrol = 3'b011;
    
    // Test vector 5: XOR
    #10 a = 32'h12345678; b = 32'h87654321; alucontrol = 3'b100;
    
    // Test vector 6: SLT (Set Less Than)
    #10 a = 32'h00000001; b = 32'h00000002; alucontrol = 3'b101;
    
    // Test vector 7: SLL (Shift Left Logical)
    #10 a = 32'h00000001; b = 32'h00000004; alucontrol = 3'b110;
    
    // Test vector 8: SRL (Shift Right Logical)
    #10 a = 32'h00000010; b = 32'h00000002; alucontrol = 3'b111;

    // Test vector 9: Zero result
    #10 a = 32'h00000002; b = 32'h00000002; alucontrol = 3'b001; // Subtract result is zero

    #10 $stop; // End the simulation
  end

  initial begin
    $monitor("At time %t, a = %h, b = %h, alucontrol = %b, result = %h, zero = %b", $time, a, b, alucontrol, result, zero);
  end

endmodule
