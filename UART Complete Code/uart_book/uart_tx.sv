module uart_tx #(
    parameter DBIT = 8,      // Data bits
    parameter SB_TICK = 16   // Ticks for stop bits
)(
    input wire clk,               // Clock
    input wire reset,             // Reset
    input wire tx_start,          // Start transmission signal
    input wire s_tick,            // Stop bit tick
    input wire [7:0] din,         // Data input to be transmitted
    output reg tx_done_tick,      // TX done tick output
    output wire tx                // TX output signal
);

    // Symbolic state declaration
    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    // Signal declaration
    reg [1:0] state_reg, state_next;    // State register and next state
    reg [3:0] s_reg, s_next;            // Bit counter for state
    reg [2:0] n_reg, n_next;            // Bit counter for data bits
    reg [7:0] b_reg, b_next;            // Data shift register
    reg tx_reg, tx_next;                // TX signal register

    // FSMD state & data registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1'b1;  // TX is idle high by default
        end else begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
        end
    end

    // FSMD next-state logic & functional units
    always @(*) begin
        state_next = state_reg;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        tx_next = tx_reg;
        tx_done_tick = 1'b0;  // Default no TX done

        case(state_reg)
            IDLE: begin
                tx_next = 1'b1;  // TX idle is high
                if (tx_start) begin
                    state_next = START;
                    s_next = 0;
                    b_next = din;
                end
            end

            START: begin
                tx_next = 1'b0;  // Send start bit (low)
                if (s_tick) begin
                    if (s_reg == 15) begin
                        state_next = DATA;
                        s_next = 0;
                        n_next = 0;
                    end else begin
                        s_next = s_reg + 1;
                    end
                end
            end

            DATA: begin
                tx_next = b_reg[0];  // Send data bit
                if (s_tick) begin
                    if (s_reg == 15) begin
                        s_next = 0;
                        b_next = b_reg >> 1;  // Shift data
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
                tx_next = 1'b1;  // Send stop bit (high)
                if (s_tick) begin
                    if (s_reg == (SB_TICK - 1)) begin
                        state_next = IDLE;
                        tx_done_tick = 1'b1;
                    end else begin
                        s_next = s_reg + 1;
                    end
                end
            end
        endcase
    end

    // Output assignment
    assign tx = tx_reg;

endmodule
