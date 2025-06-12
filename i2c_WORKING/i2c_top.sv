////////////////Top Module
//`timescale 1ns / 1ps
`include "i2c_master.sv"
`include "i2c_Slave.sv"
module i2c_top(
input clk, rst, newd, op, stretch,
input [6:0] addr,
input [7:0] din,
output [7:0] dout,
output busy,ack_err,
output done
);
wire sda, scl;
wire ack_errm, ack_errs;

i2c_master master (clk, rst, newd, addr, op, sda, scl, din, dout, busy, ack_errm , done);
i2c_Slave slave (clk, rst, stretch, sda, scl, ack_errs, );

assign ack_err = ack_errs | ack_errm;


endmodule
