///////////////////// Slave
`timescale 1ns / 1ps
 
module i2c_slave(
   input  logic clk, 
   input  logic rst,
   input  logic scl,
   inout  wire  sda,
   output logic ack_err,
   output logic done, 
   output logic [7:0] dout
);

typedef enum logic [3:0] {
   idle         = 0, 
   read_addr    = 1, 
   send_ack1    = 2, 
   send_data    = 3, 
   master_ack   = 4, 
   read_data    = 5, 
   send_ack2    = 6, 
   wait_p       = 7, 
   detect_stop  = 8
} state_type;

state_type state = idle;    

logic [7:0] mem [128];
logic [7:0] r_addr;
logic [6:0] addr;
logic       r_mem = 0;
logic       w_mem = 0;
logic [7:0] din;
logic       sda_t;
logic       sda_en;
logic [3:0] bitcnt = 0;
 
 
 
 
// Initialize memory and handle read/write
always_ff @(posedge clk) begin
   if (rst) begin
      for (int i = 0; i < 128; i++) begin
         mem[i] <= i;
      end
      dout <= 8'h0;
   end
   else if (r_mem == 1'b1) begin
      dout <= mem[addr];
   end
   else if (w_mem == 1'b1) begin
      mem[addr] <= din;
   end
end
 
///////////////////////// pulse_gen logic
parameter int sys_freq = 40_000_000;
parameter int i2c_freq = 100_000;

parameter int clk_count4 = (sys_freq / i2c_freq);
parameter int clk_count1 = clk_count4 / 4;

int count1 = 0;
logic [1:0] pulse = 0;
logic busy;

always_ff @(posedge clk) begin
   if (rst) begin
      pulse  <= 0;
      count1 <= 0;
   end
   else if (busy == 1'b0) begin
      pulse  <= 2;
      count1 <= 202;
   end
   else if (count1 == clk_count1 - 1) begin
      pulse  <= 1;
      count1 <= count1 + 1;
   end
   else if (count1 == clk_count1 * 2 - 1) begin
      pulse  <= 2;
      count1 <= count1 + 1;
   end
   else if (count1 == clk_count1 * 3 - 1) begin
      pulse  <= 3;
      count1 <= count1 + 1;
   end
   else if (count1 == clk_count1 * 4 - 1) begin
      pulse  <= 0;
      count1 <= 0;
   end
   else begin
      count1 <= count1 + 1;
   end
end
 
 
 
 
logic scl_t;
logic r_ack;
wire  start;

always_ff @(posedge clk) begin
   scl_t <= scl;
end

assign start = ~scl & scl_t;
 
always_ff @(posedge clk) begin
   if (rst) begin
      bitcnt   <= 0;
      state    <= idle;
      r_addr   <= 7'b0000000;
      sda_en   <= 1'b0;
      sda_t    <= 1'b0;
      addr     <= 0;
      r_mem    <= 0;
      din      <= 8'h00;
      ack_err  <= 0;
      done     <= 1'b0;
      busy     <= 1'b0;
   end else begin
      case (state)
         idle: begin
            if (scl == 1'b1 && sda == 1'b0) begin
               busy  <= 1'b1;
               state <= wait_p;
            end else begin
               state <= idle;
            end
         end

         wait_p: begin
            if (pulse == 2'b11 && count1 == 399)
               state <= read_addr;
            else
               state <= wait_p;
         end

         read_addr: begin
            sda_en <= 1'b0;
            if (bitcnt <= 7) begin
               case (pulse)
                  0: ;
                  1: ;
                  2: r_addr <= (count1 == 200) ? {r_addr[6:0], sda} : r_addr;
                  3: ;
               endcase
               if (count1 == clk_count1*4 - 1) begin
                  state  <= read_addr;
                  bitcnt <= bitcnt + 1;
               end else begin
                  state <= read_addr;
               end
            end else begin
               state  <= send_ack1;
               bitcnt <= 0;
               sda_en <= 1'b1;
               addr   <= r_addr[7:1];
            end
         end

         send_ack1: begin
            case (pulse)
               0: sda_t <= 1'b0;
               1: ;
               2: ;
               3: ;
            endcase
            if (count1 == clk_count1*4 - 1) begin
               if (r_addr[0] == 1'b1) begin // read
                  state <= send_data;
                  r_mem <= 1'b1;
               end else begin
                  state <= read_data;
                  r_mem <= 1'b0;
               end
            end else begin
               state <= send_ack1;
            end
         end

         read_data: begin
            sda_en <= 1'b0;
            if (bitcnt <= 7) begin
               case (pulse)
                  0: ;
                  1: ;
                  2: din <= (count1 == 200) ? {din[6:0], sda} : din;
                  3: ;
               endcase
               if (count1 == clk_count1*4 - 1) begin
                  state  <= read_data;
                  bitcnt <= bitcnt + 1;
               end else begin
                  state <= read_data;
               end
            end else begin
               state  <= send_ack2;
               bitcnt <= 0;
               sda_en <= 1'b1;
               w_mem  <= 1'b1;
            end
         end

         send_ack2: begin
            case (pulse)
               0: sda_t <= 1'b0;
               1: w_mem <= 1'b0;
               2: ;
               3: ;
            endcase
            if (count1 == clk_count1*4 - 1) begin
               state  <= detect_stop;
               sda_en <= 1'b0;
            end else begin
               state <= send_ack2;
            end
         end

         send_data: begin
            sda_en <= 1'b1;
            if (bitcnt <= 7) begin
               r_mem <= 1'b0;
               case (pulse)
                  0: ;
                  1: sda_t <= (count1 == 100) ? dout[7 - bitcnt] : sda_t;
                  2: ;
                  3: ;
               endcase
               if (count1 == clk_count1*4 - 1) begin
                  state  <= send_data;
                  bitcnt <= bitcnt + 1;
               end else begin
                  state <= send_data;
               end
            end else begin
               state  <= master_ack;
               bitcnt <= 0;
               sda_en <= 1'b0;
            end
         end

         master_ack: begin
            case (pulse)
               0: ;
               1: ;
               2: r_ack <= (count1 == 200) ? sda : r_ack;
               3: ;
            endcase
            if (count1 == clk_count1*4 - 1) begin
               if (r_ack == 1'b1) begin // nack
                  ack_err <= 1'b0;
                  state   <= detect_stop;
                  sda_en  <= 1'b0;
               end else begin
                  ack_err <= 1'b1;
                  state   <= detect_stop;
                  sda_en  <= 1'b0;
               end
            end else begin
               state <= master_ack;
            end
         end

         detect_stop: begin
            if (pulse == 2'b11 && count1 == 399) begin
               state <= idle;
               busy  <= 1'b0;
               done  <= 1'b1;
            end else begin
               state <= detect_stop;
            end
         end

         default: state <= idle;
      endcase
   end
end
 
assign sda = (sda_en == 1'b1) ? sda_t : 1'bz;

endmodule
