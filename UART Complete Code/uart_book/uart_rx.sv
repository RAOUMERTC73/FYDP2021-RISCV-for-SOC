module uart_rx #(
    parameter DBIT = 8,      // Data bits
    parameter SB_TICK = 16   // Ticks for stop bits
)(
    input wire clk,              // Clock
    input wire reset,            // Reset
    input wire rx,               // RX data input
    input wire s_tick,           // Stop bit tick
    output reg rx_done_tick,     // RX done tick output
    output reg [7:0] dout        // Data output
);

    // Symbolic state declaration
    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    // Signal declaration
    reg [1:0] state_reg, state_next;      // State register and next state
    reg [3:0] s_reg, s_next;              // Bit counter for state
    reg [2:0] n_reg, n_next;              // Bit counter for data bits
    reg [7:0] b_reg, b_next;              // Data shift register

    // FSMD state & data registers always @ (posedge clk or posedge reset)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
        end else begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
        end
    end

    // FSMD next-state logic
    always @(state_reg or rx or s_tick or n_reg or s_reg or b_reg) begin
        state_next = state_reg;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        rx_done_tick = 1'b0; // Default no RX done

        case(state_reg)
            IDLE: begin
                if (~rx) begin
                    state_next = START;
                    s_next = 0;
                end
            end

            START: begin
                if (s_tick) begin
                    if (s_reg == 7) begin
                        state_next = DATA;
                        s_next = 0;
                        n_next = 0;
                    end else begin
                        s_next = s_reg + 1;
                    end
                end
            end

            DATA: begin
                if (s_tick) begin
                    if (s_reg == 15) begin
                        s_next = 0;
                        b_next = {rx, b_reg[7:1]};
                        if (n_reg == (DBIT - 1)) begin
                            state_next = STOP;
                        end else begin
                            n_next = n_reg + 1;
                        end
                    end else begin
                        s_next = s_reg + 1;
                    end
                end
            end

            STOP: begin
                if (s_tick) begin
                    if (s_reg == (SB_TICK - 1)) begin
                        state_next = IDLE;
                        rx_done_tick = 1'b1;
                    end else begin
                        s_next = s_reg + 1;
                    end
                end
            end
        endcase
    end

    // Output assignment
    assign dout = b_reg;

endmodule
