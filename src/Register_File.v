module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [31:0]WD3;
    output [31:0]RD1,RD2;

    reg [31:0] Register [31:0];

    always @ (posedge clk)
    begin
        if(WE3 & (A3 != 5'h00))
            Register[A3] <= WD3;
    end

    assign RD1 = (rst==1'b0) ? 32'd0 : Register[A1];
    assign RD2 = (rst==1'b0) ? 32'd0 : Register[A2];

    initial begin
        Register[0] = 32'h00000000;
    end

    /*   initial begin
      Register[9] = 32'h00000020;  //LW
      Register[6] = 32'h00000040;  //LW
      Register[11] = 32'h00000028; //SW
      Register[12] = 32'h00000030; //SW
      Register[5] = 32'h00000006; //R TYPE
      Register[6] = 32'h0000000A; // R TYPE
     Register[4] = 32'h00000005; //R TYPE
     Register[4] = 32'h00000004; // R TYPE
        
    end */


endmodule