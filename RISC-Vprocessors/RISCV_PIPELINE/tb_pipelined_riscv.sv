
// TEST BENCH (TOP MODULE)
module tb_pipelined_riscv();
  bit clk;
  logic reset;

  logic [31:0] WriteData, DataAdr;
  logic       MemWrite;

  // instantiate device to be tested
  pipelined_riscv dut(clk, reset, WriteData, DataAdr,MemWrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(MemWrite) begin
        if(MemWrite) begin
          $display("Simulation succeeded");
          $stop;
        end 
        else if (DataAdr !== 96) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end
  initial begin
        $dumpfile("pipelined_riscv.vcd");
        $dumpvars(0);
        #300;
  end
endmodule