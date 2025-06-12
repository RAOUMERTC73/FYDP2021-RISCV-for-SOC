module maindec_tb;

  // Testbench signals
  logic [6:0] op;
  logic [1:0] ResultSrc;
  logic MemWrite;
  logic Branch, ALUSrc;
  logic RegWrite, Jump;
  logic [1:0] ImmSrc;
  logic [1:0] ALUOp;

  // Instantiate the maindec module
  maindec dut (
    .op(op),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
  );

  // Test procedure
  initial begin
    // Test for lw instruction (opcode = 0000011)
    op = 7'b0000011;
    #10;
    $display("Opcode: lw");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for sw instruction (opcode = 0100011)
    op = 7'b0100011;
    #10;
    $display("Opcode: sw");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for R-type instruction (opcode = 0110011)
    op = 7'b0110011;
    #10;
    $display("Opcode: R-type");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for beq instruction (opcode = 1100011)
    op = 7'b1100011;
    #10;
    $display("Opcode: beq");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for I-type ALU instruction (opcode = 0010011)
    op = 7'b0010011;
    #10;
    $display("Opcode: I-type ALU");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for jal instruction (opcode = 1101111)
    op = 7'b1101111;
    #10;
    $display("Opcode: jal");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // Test for an unknown opcode
    op = 7'b1111111;
    #10;
    $display("Opcode: unknown");
    $display("RegWrite: %b, ImmSrc: %b, ALUSrc: %b, MemWrite: %b, ResultSrc: %b, Branch: %b, ALUOp: %b, Jump: %b", 
              RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);

    // End the simulation
    $finish;
  end

endmodule



