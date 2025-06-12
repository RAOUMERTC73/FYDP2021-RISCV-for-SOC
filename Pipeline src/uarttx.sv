module uarttx
#(
    parameter clk_freq = 1000000,
    parameter baud_rate = 9600
)
(
    input clk, rst,
    input newd,
    input [7:0] tx_data,
    output reg tx,
    output reg donetx
);

localparam integer clkcount = clk_freq / baud_rate;

integer count = 0;
integer bit_index = 0;

reg uclk = 0;
reg [9:0] shift_reg; // 1 start bit, 8 data bits, 1 stop bit

typedef enum logic [1:0] {IDLE = 2'b00, LOAD = 2'b01, TRANSFER = 2'b10} state_t;
state_t state = IDLE;

// UART clock generation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        uclk <= 0;
    end else if (count < clkcount / 2) begin
        count <= count + 1;
    end else begin
        count <= 0;
        uclk <= ~uclk;
    end
end

// UART transmit logic
always @(posedge uclk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        tx <= 1'b1;
        donetx <= 1'b0;
        shift_reg <= 10'b1111111111;
        bit_index <= 0;
    end else begin
        case (state)
            IDLE: begin
                tx <= 1'b1;
                donetx <= 1'b0;
                if (newd) begin
                    shift_reg <= {1'b1, tx_data, 1'b0}; // Stop bit, data, start bit
                    state <= LOAD;
                end
            end
            LOAD: begin
                state <= TRANSFER;
            end
            TRANSFER: begin
                tx <= shift_reg[0];
                shift_reg <= {1'b1, shift_reg[9:1]}; // Shift right
                if (bit_index < 9) begin
                    bit_index <= bit_index + 1;
                end else begin
                    bit_index <= 0;
                    donetx <= 1'b1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
