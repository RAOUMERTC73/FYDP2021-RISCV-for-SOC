
module aludec_tb;

  // Inputs
  logic opb5;
  logic [2:0] funct3;
  logic funct7b5;
  logic [1:0] ALUOp;

  // Outputs
  logic [2:0] ALUControl;

  // Instantiate the ALU Decoder module
  aludec uut (
    .opb5(opb5), 
    .funct3(funct3), 
    .funct7b5(funct7b5), 
    .ALUOp(ALUOp), 
    .ALUControl(ALUControl)
  );

  initial begin
    // Test vector 1: R-type ADD (ALUOp = 2'b10, funct3 = 3'b000, funct7b5 = 0)
    #10 opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b10;
    
    // Test vector 2: R-type SUB (ALUOp = 2'b10, funct3 = 3'b000, funct7b5 = 1)
    #10 opb5 = 1; funct3 = 3'b000; funct7b5 = 1; ALUOp = 2'b10;
    
    // Test vector 3: R-type SLT (ALUOp = 2'b10, funct3 = 3'b010, funct7b5 = 0)
    #10 opb5 = 0; funct3 = 3'b010; funct7b5 = 0; ALUOp = 2'b10;
    
    // Test vector 4: R-type OR (ALUOp = 2'b10, funct3 = 3'b110, funct7b5 = 0)
    #10 opb5 = 0; funct3 = 3'b110; funct7b5 = 0; ALUOp = 2'b10;
    
    // Test vector 5: R-type AND (ALUOp = 2'b10, funct3 = 3'b111, funct7b5 = 0)
    #10 opb5 = 0; funct3 = 3'b111; funct7b5 = 0; ALUOp = 2'b10;
    
    // Test vector 6: I-type ADDI (ALUOp = 2'b00)
    #10 opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b00;
    
    // Test vector 7: I-type SUBTRACT (ALUOp = 2'b01)
    #10 opb5 = 0; funct3 = 3'b000; funct7b5 = 0; ALUOp = 2'b01;

    // End simulation
    #10 $stop;
  end

  initial begin
    $monitor("At time %t, opb5 = %b, funct3 = %b, funct7b5 = %b, ALUOp = %b, ALUControl = %b", $time, opb5, funct3, funct7b5, ALUOp, ALUControl);
  end

endmodule


