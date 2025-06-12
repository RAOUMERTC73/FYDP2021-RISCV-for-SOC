//////////TESTBENCH///////////////

`timescale 1ns/1ps
module FIFO_tb ();
  parameter    WIDTH = 4;//4 
  parameter    DEPTH = 8; //8

  bit                    clk;                          // clock
  logic                  reset, wr_en, rd_en;          // input signals 
  logic      [WIDTH-1:0] data_in;                      // 32bit input word length
  logic      [WIDTH-1:0] data_out;                     // 32bit output word length
  logic                  full, empty;                  // output indicator signals for full / empty

 // logic [6:0] fifo_counter;
 logic [3:0] fifo_counter;
  logic      [WIDTH-1:0] data_out_svd_fifo [DEPTH:0];  //temporary variable to store the contents of the read mode of FIFO
  logic      [WIDTH-1:0] data_out_svd_q [DEPTH:0];  //temporary variable to store the contents of the POP mode of QUEUE


  //generating CLOCK
  always #10 clk = ~clk;
 
//   // Instantiate the FIFO module
  FIFO dut (
    .clk(clk),
    .rst(reset),
    .buf_in(data_in),
    .buf_out(data_out),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .buf_empty(empty),
    .buf_full(full),
    .fifo_counter(fifo_counter)
  );


  // Queue implementation
   logic [31:0] queue [$];
  //logic [WIDTH-1:0] queue[$:DEPTH-1]; // sample bounded empty queue
  int i = 0;



integer ridle;

  // initial block 
  initial begin 
  
    reset = 1'b1; 
    wr_en = 0;
    rd_en = 0;
    #16;
    reset = 1'b0;
    @(posedge clk);

    fork
      begin
        repeat(10000) begin
          wr_en   = 1;
          data_in = i+1;
          @(posedge clk); 
          wr_en = 0;
          ridle = $random%10;
          if (ridle > 0)
          repeat (ridle)
            @(posedge clk);
          i++;
        end
      end

    // repeat (5)
    //   @(posedge clk);
      begin
        repeat(10000) begin
          rd_en   = ~empty;
          @(posedge clk);
          rd_en = 0;
          ridle = $random%10;
          if (ridle > 0)
          repeat (ridle)
            @(posedge clk);
        end
      end
    join
    
    #1000 
    $display("---------------- NORMAL STOP-------------",);
    $stop;
  end   

logic rd_en_d;
always @(posedge clk)
  rd_en_d <= rd_en & ~empty;

int rcnt;
logic [WIDTH-1:0] mdl_data;
always @(posedge clk)
if (rd_en_d) begin
  rcnt <= rcnt + 1;
  mdl_data =  queue.pop_front();
  if (mdl_data != data_out)
  $display("RD %3d MISMATCH RTL %d EXPTD %d",rcnt,data_out,mdl_data);
  if (mdl_data != data_out)
    $stop;
end






// if wr_en asserted
always_ff @(posedge clk) 
  begin
  if(wr_en & !full)
    begin
       queue.push_back(data_in);
       $display("queue = %p",queue);
    end
  end


endmodule : FIFO_tb








































// module FIFO_tb;

//   // Signals
//   bit clk = 0;
//   reg reset = 1;
//   reg wr = 0;
//   reg rd = 0;
//   reg [31:0] w_data;
//   reg [31:0] r_data;
//   wire buf_empty, buf_full;
//   reg [6:0] fifo_counter;
//   reg [31:0] stored_data_fifo[0:127]; // Array to store all queue values
//   // Instantiate the FIFO module
//   FIFO dut (
//     .clk(clk),
//     .rst(reset),
//     .buf_in(w_data),
//     .buf_out(r_data),
//     .wr_en(wr),
//     .rd_en(rd),
//     .buf_empty(buf_empty),
//     .buf_full(buf_full),
//     .fifo_counter(fifo_counter)
//   );
  
// task flagcheck();
//   begin
//     if (buf_empty == 1 && queue.size() == 0)begin
//         $display("fifo is empty");
//         $display("Queue is empty");
//     end
//     else if (buf_full == 1 && queue.size() == 128)begin
//          $display("fifo is full");
//         $display("Queue is full");
//     end
//     else begin
//          $display("fifo is neither full nor empty");
//          $display("Queue is neither full nor empty");
//     end
//   end
// endtask : flagcheck


//   // Clock generation
//   always #5 clk = ~clk;

//   // Queue implementation
//   logic [31:0] queue [$:127];



// int wt;
// int wrcnt;
// int rdcnt;

//   // // Test stimulus for FIFO module
  
// initial begin
//     // Reset
//     #10 reset = 0;
//     // Test full and empty flags
//     #5;
//     flagcheck();
//     // Write data into the FIFO
//     #10;
//     $display("========================= Write data into the FIFO ==============================");

//     for (int i = 0; i < 128; i = i + 1) begin
//         wr = 1;
//         w_data = i + 2;
//         //w_data = $random;
//         $display("i=%d ,Write data into the FIFO = %d", i, w_data);
//         queue.push_back(w_data); // Write data into the queue
//         $display(" i =%d ,Writing to queue: w_data = %d", i, w_data);
//         #10;
//         wr = 0;
//         #10;
//     end
//     $display("========================= Write data into the FIFO finish =========================");
//      // Test full and empty flags
//     #5;
//     flagcheck();
//     // Read data from the FIFO and store it in stored_data_fifo
//     #10;
//     $display("========================= Read data from the FIFO =================================");

//     for (int i = 0; i < 128; i = i + 1) begin
//         rd = 1;
//         #10;
//         stored_data_fifo[i] = r_data; // Store value in the array
//         $display("i=%d ,Read data from the FIFO = %d ", i, r_data);
//         rd = 0;
//         #10;
//     end
     
//     // Read data from the queue
//     #1;i
//     $display("=========================Read data from the queue =================================");

//     // foreach (queue[i]) begin
//     //    $display("queue[%0d] = %d", i, queue[i]);
//     // end
//         $display("queue = %p",queue );
    
//     //  // Test full and empty flags
//     #5;
//     if (buf_empty)
//         $display("fifo is empty");
//     else if (buf_full)
//         $display("fifo is full");
//     else
//         $display("fifo is neither full nor empty");


//       // Test full and empty flags using queue.size()
//     #5;
//     if (queue.size() == 0)
//          $display("Queue is empty");
//     else if (queue.size() == 128)
//          $display("Queue is full");
//     else
//        $display("Queue is neither full nor empty");

//     // $display("///////////////////////////////  fork start /////////////////////////");

//     // // Stimulate reads and writes concurrently
//     // fork
//     // begin : WR_DRIVE
//     //     repeat (50)
//     //         wr = ~buf_full;
//     //         //#5;
//     //         //wr = 1;
//     //         w_data = $random;
//     //         @(posedge clk);
//     //         wr = 0;
//     //         wt = $random%10;
//     //         if (wt > 0)
//     //             repeat (wt)
//     //                 @(posedge clk);
//     // end
//     // begin : RD_DRIVE
//     //     repeat (50)
//     //           rd = ~buf_empty;
//     //         //rd = 1;
//     //         @(posedge clk);
//     //         rd = 0;
//     //         wt = $random%10;
//     //         if (wt > 0)
//     //             repeat (wt)
//     //                 @(posedge clk);
//     // end
//     // join

//     // repeat (10)
//     //     @(posedge clk)
//     // $stop;

//     // $display("/////////////////////////////// end fork////////////////////////////////////////////////");
//     // #10;


//     // Display stored_data_fifo
//     #5;
//     $display("=========================Read data from the stored_data_fifo ======================");

//     for (int i = 0; i < 128; i = i + 1) begin
//         $display("stored_data_fifo[%0d] = %d ", i, stored_data_fifo[i]);
//         #10;
//     end
//     #5;
//     for (int i = 0; i < 128; i++) begin
//        if (stored_data_fifo[i] == queue[i]) begin
//           $display("queue[%0d]            = %d", i, queue[i]);
//           $display("stored_data_fifo[%0d] = %d", i, stored_data_fifo[i]);
//           $display("TEST PASSED ");

//        end
//        else begin
//          $display("=======================TEST FAIL TRY AGAIN====================================");
//          $display("queue[%0d] =            %d", i, queue[i]);
//          $display("stored_data_fifo[%0d] = %d", i, stored_data_fifo[i]);
         
//        end
//     end
//     // checking the some queue function 
//     $display("===================checking the some queue function ========================");
//     // checking the some queue function 
//     #5;
//     // Display queue after insertion
//      // Test full and empty flags
//     #5;
//     if (buf_empty)
//         $display("fifo is empty");
//     else if (buf_full)
//         $display("fifo is full");
//     else
//         $display("fifo is neither full nor empty");

//       // Test full and empty flags using queue.size()
//     #5;
//     if (queue.size() == 0)
//          $display("Queue is empty");
//     else if (queue.size() == 128)
//          $display("Queue is full");
//     else
//        $display("Queue is neither full nor empty");

//     // Removal using pop_front()
//     #10;
//     $display("=============== Remove data from the front of the queue ================");
//     for (int i = 0; i < 60; i = i + 1) begin
//         logic [31:0] removed_data;
//         removed_data = queue.pop_front();
//         $display("Removed data from front: %d", removed_data);
//     end

//     // Display queue after removal from the front
//     $display("=============== Queue after removal from the front ================");
//     // foreach (queue[i]) begin
//     //    $display("queue[%0d] = %d", i, queue[i]);
//     // end
//     $display("queue = %p",queue );

//     //Removal using pop_back()
//     #10;
//     $display("=============== Remove data from the back of the queue ================");
//     for (int i = 0; i < 60; i = i + 1) begin
//        logic [31:0] removed_data;
//        removed_data = queue.pop_back();
//        $display("Removed data from back: %d", removed_data);
//     end

//     // Display queue after removal from the back
//     $display("=============== Queue after removal from the back ================");
//     // foreach (queue[i]) begin
//     //    $display("queue[%0d] = %d", i, queue[i]);
//     // end
//     $display("queue = %p",queue );

//     // Deletion using delete()
//     #10;
//     $display("=============== Delete the queue ================");
//     queue.delete();
    
//     // Display queue after deletion
//     $display("=============== Queue after deletion ================");
//     // foreach (queue[i]) begin
//     //     $display("queue[%0d] = %d", i, queue[i]);
//     // end
//     $display("queue = %p",queue );
//       // Test full and empty flags using queue.size()
//     #5;
//     if (queue.size() == 0)
//          $display("Queue is empty");
//     else if (queue.size() == 128)
//          $display("Queue is full");
//     else
//        $display("Queue is neither full nor empty");



//     $display("--------------------------- Simulation End ------------------------------------------------------");
//     #1000;
//     $stop;
// end  



// // always @(posedge clk)begin
// // if (wr) begin
// //     queue.push_back(w_data);
// //     wrcnt <= wrcnt + 1;
// // end
// // end
// // always @(posedge clk)begin
// // if (rd) begin
// //     rdcnt <= rdcnt + 1;
// //     if (r_data !== queue[rdcnt]) begin
// //         $display("RD CNT %3d RTL %3d EXPTD %3d", rdcnt, r_data, queue[rdcnt]);
// //         $stop;
// //     end
// // end
// // end

// endmodule










// `timescale 1ns / 1ps

// module FIFO_tb;

//   // Parameters
//   parameter CLK_PERIOD = 10; // Clock period in nanoseconds
  
//   // Signals
//   reg clk = 0;
//   reg reset = 1;
//   reg wr = 0;
//   reg rd = 0;
//   reg [31:0] w_data;
//   wire [31:0] r_data;
//   wire buf_empty, buf_full;
//   wire [6:0] fifo_counter;
  
//   // Instantiate the FIFO module
//   FIFO dut (
//     .clk(clk),
//     .rst(reset),
//     .buf_in(w_data),
//     .buf_out(r_data),
//     .wr_en(wr),
//     .rd_en(rd),
//     .buf_empty(buf_empty),
//     .buf_full(buf_full),
//     .fifo_counter(fifo_counter)
//   );
  
//   // Clock generation
//   always #((CLK_PERIOD)/2) clk <= ~clk;
  
//   /// Test stimulus
// initial begin

//     #10 reset = 0;

//     // Write data into the FIFO
//     #20;
//     for (int i = 0; i <128; i = i + 1) begin
//         wr = 1;
//         w_data = i + 1;
//         $display("w_data = %d ,i = %d",w_data,i);
//         #10;
//         wr = 0;
//         #10;
//     end

//     // Read data from the FIFO
//     #50;
//     for (int i = 0; i <128; i = i + 1) begin
//         rd = 1;
//         $display("r_data = %d , i = %d",r_data,i);
//         #10;
//         rd = 0;
//         #10;
//     end
    

//     // End simulation
//     #10;
//     $display("--------------------- Normal stop------------------------------------------------------");
//     $stop;
// end

// endmodule



