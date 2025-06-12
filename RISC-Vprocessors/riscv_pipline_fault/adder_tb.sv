module adder_tb ;
  logic [31-0:0] a ,b,c;

  adder dut(.a(a),.b(b),.y(c));

    
  initial begin
        
    // Initialize Inputs
    a = 0;
    b = 0;

    // Apply test vectors
    #10 a = 32'h00000001; b = 32'h00000001;
    #10 a = 32'hFFFFFFFF; b = 32'h00000001;
    #10 a = 32'h12345678; b = 32'h87654321;
    #10 a = 32'hA5A5A5A5; b = 32'h5A5A5A5A;
    #10 a = 32'h0000FFFF; b = 32'hFFFF0000;
    #10 $stop; // End the simulation
  end

  initial begin
    $monitor("At time %t, a = %h, b = %h, y = %h", $time, a, b, y);
  end
    
endmodule