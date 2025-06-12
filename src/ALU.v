
module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0]A,B;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [31:0]Result;

    wire Cout;
    wire [31:0]Sum;

    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule
 
 /* module ALU(
    input [31:0] A, B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output reg Carry, OverFlow, Zero, Negative
);

    wire [31:0] Sum;
    wire Cout;

    // Calculate Sum and Carry-out
    assign {Cout, Sum} = (ALUControl == 3'b000) ? A + B :        // Addition
                         (ALUControl == 3'b001) ? A + (~B + 1) : // Subtraction (A - B)
                         32'b0;

    always @(*) begin
        // Set Result based on ALUControl
        case(ALUControl)
            3'b000: Result = Sum;            // Addition
            3'b001: Result = Sum;            // Subtraction
            3'b010: Result = A & B;          // AND
            3'b011: Result = A | B;          // OR
            3'b101: Result = {31'b0, Sum[31]}; // SLT (Set on Less Than)
            default: Result = 32'b0;
        endcase

        // Set flags
        OverFlow = ((Sum[31] ^ A[31]) & (~(ALUControl[0] ^ B[31] ^ A[31])) & (~ALUControl[1]));
        Carry = (~ALUControl[1]) & Cout;
        Zero = (Result == 32'b0);
        Negative = Result[31];
    end
endmodule
 */
 
 
 