// i2c_top.sv

`timescale 1ns / 1ps

module i2c_top (
    input  logic        clk,
    input  logic        rst,
    input  logic        newd,
    input  logic        op,
    input  logic [6:0]  addr,
    input  logic [7:0]  din,
    output logic [7:0]  dout_mstr,
    output logic [7:0]  dout_slv,
    output logic        busy,
    output logic        ack_err,
    output logic        done, 
    output logic        dout_valid
);

    wire sda, scl;
    logic ack_errm, ack_errs;
    logic SDA;
    logic SCL;

    i2c_master master (
        .clk      (clk),
        .rst      (rst),
        .newd     (newd),
        .addr     (addr),
        .op       (op),
        .sda      (sda),
        .scl      (scl),
        .din      (din),
        .dout     (dout_mstr),
        .busy     (busy),
        .ack_err  (ack_errm),
        .done     (done)
    );

    i2c_slave slave (
        .scl      (scl),
        .clk      (clk),
        .rst      (rst),
        .sda      (sda),
        .ack_err  (ack_errs),
        .dout     (dout_slv),
        .done     ()
    );

    assign ack_err = ack_errs | ack_errm;
    assign dout_valid = (done && !ack_err) ? 1'b1 : 1'b0;

    assign SDA = (sda) ? 1'bz : 1'b0; // Tri-state buffer for SDA line
    assign SCL = (scl) ? 1'bz : 1'b0; // Tri-state buffer for SDA line

endmodule
