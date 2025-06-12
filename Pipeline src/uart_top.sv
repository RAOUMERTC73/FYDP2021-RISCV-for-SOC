module uart_top
#(
    parameter clk_freq = 1000000,
    parameter baud_rate = 9600
)
(
    input clk, rst, 
    input rx,
    input [7:0] dintx,
    input newd,
    output tx, 
    output [7:0] doutrx,
    output donetx,
    output donerx
);

uarttx 
#(
    .clk_freq(clk_freq),
    .baud_rate(baud_rate)
) 
utx (
    .clk(clk), 
    .rst(rst), 
    .newd(newd), 
    .tx_data(dintx), 
    .tx(tx), 
    .donetx(donetx)
);   

uartrx 
#(
    .clk_freq(clk_freq),
    .baud_rate(baud_rate)
)
rtx (
    .clk(clk), 
    .rst(rst), 
    .rx(rx), 
    .done(donerx), 
    .rxdata(doutrx)
);

endmodule
