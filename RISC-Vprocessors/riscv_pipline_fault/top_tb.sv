module top_tb();

  bit clk;
  logic reset;

  logic [31:0] WriteData, DataAdr;
  logic       MemWrite;

  // instantiate device to be tested
  Pipeline_top dut(clk, reset, WriteData, DataAdr, MemWrite);
  
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
        if(DataAdr === 44 & WriteData === -3) begin
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
        $dumpfile("Cycle Compelete.vcd");
        $dumpvars(0);
        #300ps;
  end
endmodule