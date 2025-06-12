`timescale 1 ps / 1 ps
module rom_tb;
  
  parameter ADDRESS_WIDTH = 8;
  parameter DATA_WIDTH = 32;

  reg [ADDRESS_WIDTH-1:0] address;
  reg clock;

  wire [DATA_WIDTH-1:0] q;

  rom dut(.address(address),.clock(clock),.q(q));

  initial begin
    address =0;
    clock = 0;
  end

  always #5 clock = ~clock;


  always @(posedge clock) begin
    $display("Addess = %h, Data = %h",address,q);
    address = address + 4;
  end
  

  initial #300 $stop;
  
endmodule
