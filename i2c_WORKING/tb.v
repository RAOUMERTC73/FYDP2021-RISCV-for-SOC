module tb;
reg clk =0; 
reg rst = 0;
reg newd = 0;
reg [6:0] addr = 0;
reg op = 0;
reg [7:0] din;
wire [7:0] dout;
wire sda,scl;
wire busy;
wire ack_err;

i2c_master dut (clk, rst , newd, addr, op,sda, scl, din, dout, busy, ack_e);
always #5 clk = ~clk;

initial begin
rst = 1;
repeat(5) @(posedge clk);
rst = 0;
newd = 1;
op = 0;
addr = 7'b1111000;
din = 8'hff;
@(negedge busy);
repeat(5) @(posedge clk);
$stop;
end



endmodule