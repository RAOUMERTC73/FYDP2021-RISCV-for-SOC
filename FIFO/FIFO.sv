
module FIFO #(parameter    WIDTH = 4,
              parameter    DEPTH = 8 //8 
  )( clk, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter );

input  rst, clk, wr_en, rd_en;   
input [WIDTH-1:0]  buf_in;                   
output[WIDTH-1:0]  buf_out;                  
output buf_empty, buf_full;      
//output[6:0] fifo_counter;  

output[3:0] fifo_counter;  

logic [WIDTH-1:0] buf_out;
logic buf_empty, buf_full;
//logic [6:0] fifo_counter;
//logic [6:0] rd_ptr, wr_ptr;  

logic [3:0] fifo_counter;
logic [3:0] rd_ptr, wr_ptr;      
          
logic [WIDTH-1:0] buf_mem[DEPTH-1:0];   

always @(fifo_counter)     // gives the status flage
begin
   buf_empty = (fifo_counter== 0);
   buf_full = (fifo_counter== DEPTH-1);

end
// this is fifo conuter  which counts data
always @(posedge clk or posedge rst)
begin
   if( rst )
       fifo_counter <= 0;

   else if( (!buf_full && wr_en) && ( !buf_empty && rd_en ) )
       fifo_counter <= fifo_counter;

   else if( !buf_full && wr_en )
       fifo_counter <= fifo_counter + 1;

   else if( !buf_empty && rd_en )
       fifo_counter <= fifo_counter - 1;
   else
      fifo_counter <= fifo_counter;
end
//fecthing data from the fifo
always @( posedge clk or posedge rst)
begin
   if( rst )
      buf_out <= 0;
   else
   begin
      if( rd_en && !buf_empty )
         buf_out <= buf_mem[rd_ptr];

      else
         buf_out <= buf_out;

   end
end
//writing data  into the fifo
always @(posedge clk)
begin

   if( wr_en && !buf_full )
      buf_mem[ wr_ptr ] <= buf_in;

   else
      buf_mem[ wr_ptr ] <= buf_mem[ wr_ptr ];
end
//manage the pointer  and buffer location
always@(posedge clk or posedge rst)
begin
   if( rst )
   begin
      wr_ptr <= 0;
      rd_ptr <= 0;
   end
   else begin
      if( !buf_full && wr_en )begin
         wr_ptr <= wr_ptr + 1;
       end   
      else begin
         wr_ptr <= wr_ptr;
      end
      if( !buf_empty && rd_en )begin
         rd_ptr <= rd_ptr + 1;
      end
      else begin
         rd_ptr <= rd_ptr;
      end
   end

end
endmodule

