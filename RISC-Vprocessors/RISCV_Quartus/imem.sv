module imem(input logic [31:0] a,
            output logic [31:0] rd);

  logic [7:0] RAM[128:0];


 assign rd = {RAM[a + 3], RAM[a + 2], RAM[a + 1], RAM[a]};


    initial begin
    RAM[0]  = 8'h13; // 00500113
    RAM[1]  = 8'h01;
    RAM[2]  = 8'h50;
    RAM[3]  = 8'h00;

    RAM[4]  = 8'h93; // 00C00193
    RAM[5]  = 8'h01;
    RAM[6]  = 8'hC0;
    RAM[7]  = 8'h00;

    RAM[8]  = 8'h93; // FF718393
    RAM[9]  = 8'h83;
    RAM[10] = 8'h71;
    RAM[11] = 8'hFF;

    RAM[12] = 8'h33; // 0023E233
    RAM[13] = 8'hE2;
    RAM[14] = 8'h23;
    RAM[15] = 8'h00;

    RAM[16] = 8'hB3; // 0041F2B3
    RAM[17] = 8'hF2;
    RAM[18] = 8'h41;
    RAM[19] = 8'h00;

    RAM[20] = 8'hB3; // 004282B3
    RAM[21] = 8'h82;
    RAM[22] = 8'h42;
    RAM[23] = 8'h00;

    RAM[24] = 8'h63; // 02728863
    RAM[25] = 8'h88;
    RAM[26] = 8'h72;
    RAM[27] = 8'h02;

    RAM[28] = 8'h33; // 0041A233
    RAM[29] = 8'hA2;
    RAM[30] = 8'h41;
    RAM[31] = 8'h00;

    RAM[32] = 8'h63; // 00020463
    RAM[33] = 8'h04;
    RAM[34] = 8'h02;
    RAM[35] = 8'h00;

    RAM[36] = 8'h93; // 00000293
    RAM[37] = 8'h02;
    RAM[38] = 8'h00;
    RAM[39] = 8'h00;

    RAM[40] = 8'h33; // 0023A233
    RAM[41] = 8'hA2;
    RAM[42] = 8'h23;
    RAM[43] = 8'h00;

    RAM[44] = 8'hB3; // 005203B3
    RAM[45] = 8'h03;
    RAM[46] = 8'h52;
    RAM[47] = 8'h00;

    RAM[48] = 8'hB3; // 402383B3
    RAM[49] = 8'h83;
    RAM[50] = 8'h23;
    RAM[51] = 8'h40;

    RAM[52] = 8'h23; // 0471AA23
    RAM[53] = 8'hAA;
    RAM[54] = 8'h71;
    RAM[55] = 8'h04;

    RAM[56] = 8'h03; // 06002103
    RAM[57] = 8'h21;
    RAM[58] = 8'h00;
    RAM[59] = 8'h06;

    RAM[60] = 8'hB3; // 005104B3
    RAM[61] = 8'h04;
    RAM[62] = 8'h51;
    RAM[63] = 8'h00;
    
    RAM[64] = 8'hEF; // 008001EF
    RAM[65] = 8'h01;
    RAM[66] = 8'h80;
    RAM[67] = 8'h00;

    RAM[68] = 8'h13; // 00100113
    RAM[69] = 8'h01;
    RAM[70] = 8'h10;
    RAM[71] = 8'h00;

    RAM[72] = 8'h33; // 00910133
    RAM[73] = 8'h01;
    RAM[74] = 8'h91;
    RAM[75] = 8'h00;

    RAM[76] = 8'h23; // 0221A023
    RAM[77] = 8'hA0;
    RAM[78] = 8'h21;
    RAM[79] = 8'h02;

    RAM[80] = 8'h63; // 00210063
    RAM[81] = 8'h00;
    RAM[82] = 8'h21;
    RAM[83] = 8'h00;
  end

endmodule



//
//
//module imem(input  logic [31:0] a,
//            output logic [31:0] rd);
//
// /// logic [31:0] RAM[63:0];
//    
//
// 
//   assign rd = RAM[a[31:2]]; // word aligned
//
//
////   initial begin
////    $readmemh("riscvtestj.hex",RAM);    //$readmemh("riscvtest.txt",RAM);
////   end
// 
//
//
//endmodule
