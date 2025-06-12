//`timescale 1ns / 1ps
module i2c_top_tb;

reg clk = 0, rst = 0, newd = 0, op;
reg stretch = 0;
reg [6:0] addr;
reg [7:0] din;
wire [7:0] dout;
wire busy,ack_err;
wire done;
i2c_top dut (clk,rst, newd, op,stretch, addr, din, dout, busy, ack_err, done);

always #5 clk = ~clk;

initial begin
rst = 1;
repeat(5) @(posedge clk);
rst = 0;
//////////// write operation

@(posedge clk);
newd = 1;
stretch = 0;
op = 0;
addr = $urandom_range(0,10);
din  =  $urandom_range(1,5);
repeat(5) @(posedge clk);
@(posedge done);
$display("[WR] din : %0d addr: %0d",din, addr);
@(posedge clk);



@(posedge clk);
newd = 1;
stretch = 1;
op = 0;
addr = $urandom_range(0,10);
din  =  $urandom_range(1,5);
wait(dut.master.state == 3);
repeat(1200)@(posedge clk);
stretch = 0;
@(posedge done);
$display("[WR] din : %0d addr: %0d",din, addr);
$stop;
end

endmodule