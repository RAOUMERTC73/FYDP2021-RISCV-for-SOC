`timescale 1ns / 1ps
module i2c_top_tb;

  // Interface signals
  logic clk; 
  logic rst; 
  logic newd; 
  logic op;
  logic [6:0] addr;
  logic [7:0] din; 
  logic [7:0] dout_mstr;
  logic [7:0] dout_slv;
  logic busy; 
  logic ack_err;
  logic done;
  logic dout_valid;

  // DUT instantiation
  i2c_top dut (
    .clk(clk),
    .rst(rst),
    .newd(newd),
    .op(op),
    .addr(addr),
    .din(din),
    .dout_mstr(dout_mstr),
    .dout_slv(dout_slv),
    .busy(busy),
    .ack_err(ack_err),
    .done(done), 
    .dout_valid(dout_valid)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset task
  task reset();
    rst = 1;
    newd = 0;
    op = 0;
    addr = 0;
    din = 0;
    repeat(10) @(posedge clk);
    rst = 0;
    $display("[TB] Reset complete");
  endtask

  // Write task
  task write(input [6:0] wr_addr, input [7:0] wr_data);
    @(posedge clk);
    newd = 1;
    op = 0; // Write operation
    addr = wr_addr;
    din = wr_data;
    @(posedge clk);
    newd = 0;
    wait(done);
    $display("[TB] ---Write: Addr=%0d, Data=%0d---", wr_addr, wr_data);
  endtask

  // Read task
  task read(input [6:0] rd_addr, output [7:0] rd_data);
    @(posedge clk);
    newd = 1;
    op = 1; // Read operation
    addr = rd_addr;
    din = 0;
    @(posedge clk);
    newd = 0;
    wait(done);
    rd_data = dout_slv;
    $display("[TB] ---Read: Addr=%0d, Data=%0d---", rd_addr, rd_data);
  endtask

  // Verification task
  task verify(input [6:0] addr, input [7:0] expected_data);
    if (dout_slv === expected_data) begin
      $display("[TB] ---Verification PASSED: Addr=%0d, Data=%0d---", addr, dout_slv);
      $display("[TB] ################################################");
    end 
    else begin
      $display("[TB] ---Verification FAILED: Addr=%0d, Expected=%0d, Received=%0d---", addr, expected_data, dout_slv);
    end
  endtask

  // Test sequence
  initial begin

    // Testbench sequence
    reset();

    // Write and read operations
    write(7'h02, 8'hAA);
    read(7'h02, dout_slv);
    verify(7'h02, 8'hAA);

    // write(7'h03, 8'h55);
    // read(7'h03, dout_slv);
    // verify(7'h03, 8'h55);

    // End simulation
    $stop;
  end

endmodule
