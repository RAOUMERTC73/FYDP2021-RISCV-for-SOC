

module imem(input  logic [31:0] a,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

 
  assign rd = RAM[a[31:2]]; // word aligned

   initial begin
    //$readmemh("memfile.hex",mem);
    $readmemh("riscvtest.hex",RAM);
  end
 

/* 
  initial begin
   // mem[0] = 32'hFFC4A303; //FOR LW
   // mem[1] = 32'h00832383; // FOR LW
   //  mem[0] = 32'h0064A423; // FOR SW
   //  mem[1] = 32'h00B62423; // FOR SW
   //  mem[0] = 32'h0062E233; // FOR R Type
   // mem[1] = 32'h00B62423; // FOR R Type 

  end */


endmodule
