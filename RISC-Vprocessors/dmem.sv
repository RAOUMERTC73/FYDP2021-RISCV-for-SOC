

module dmem(input  logic        clk, we,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always_ff @(posedge clk)
    if (we) RAM[a[31:2]] <= wd;



// initial begin
    //     mem[28] = 32'h00000020;
    //     mem[40] = 32'h00000002;
    // end



endmodule




