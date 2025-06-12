module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0];
  
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];
 
 /*  initial begin
   // $readmemh("memfile.hex",mem);
  // $readmemh("test_inst.hex",mem);
   // $readmemh("riscvtest.hex",mem);
  end    */
 

 
  initial begin
     mem[0] = 32'hFFC4A303; //FOR LW
     mem[1] = 32'h00832383; // FOR LW
     mem[2] = 32'h0064A423; // FOR SW
    mem[3] = 32'h00B62423; // FOR SW
    mem[4] = 32'h0062E233; // FOR R Type
    mem[5] = 32'h00B62423; // FOR R Type 
  //  mem[6] = 32'hFE420AE3; // FOR B Type
  // mem[7] = 32'h00B62423; // FOR B Type 
  end 

endmodule




