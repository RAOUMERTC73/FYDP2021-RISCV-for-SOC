module uartrx
#(
    parameter clk_freq = 1000000,
    parameter baud_rate = 9600
)
(
    input clk, rst,
    input rx,
    output reg done,
    output reg [7:0] rxdata
);

localparam integer clkcount = clk_freq / baud_rate;

integer count = 0;
integer bit_index = 0;

reg uclk = 0;
reg [7:0] shift_reg;

typedef enum logic [1:0] {IDLE = 2'b00, START = 2'b01, RECEIVE = 2'b10, STOP = 2'b11} state_t;
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

// UART receive logic
always @(posedge uclk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        rxdata <= 8'h00;
        shift_reg <= 8'h00;
        bit_index <= 0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                done <= 1'b0;
                if (rx == 1'b0) // Start bit detected
                    state <= START;
            end
            START: begin
                if (rx == 1'b0) // Validate start bit
                    state <= RECEIVE;
                else
                    state <= IDLE;
            end
            RECEIVE: begin
                shift_reg <= {rx, shift_reg[7:1]}; // Shift data in
                if (bit_index < 7) begin
                    bit_index <= bit_index + 1;
                end else begin
                    bit_index <= 0;
                    state <= STOP;
                end
            end
            STOP: begin
                if (rx == 1'b1) begin // Stop bit check
                    rxdata <= shift_reg;
                    done <= 1'b1;
                end
                state <= IDLE;
            end
        endcase
    end
end

endmodule
