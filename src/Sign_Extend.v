/* module Sign_Extend (In,Imm_Ext,ImmSrc);

    input [31:0]In;
    input ImmSrc;
    output [31:0]Imm_Ext;

    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}},In[31:25],In[11:7]}):
                                        {{20{In[31]}},In[31:20]};
                                
endmodule  */


module Sign_Extend (
    input [31:0] In,
    input [1:0] ImmSrc,
    output reg [31:0] Imm_Ext
);

    always @(*) begin
        case(ImmSrc) 
            // I-type 
            2'b00: Imm_Ext = {{20{In[31]}}, In[31:20]};  
            // S-type (stores)
            2'b01: Imm_Ext = {{20{In[31]}}, In[31:25], In[11:7]}; 
            // B-type (branches)
            2'b10: Imm_Ext = {{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0}; 
            // J-type (jal)
            2'b11: Imm_Ext = {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0}; 
            default: Imm_Ext = 32'bx; // undefined
        endcase
    end             
endmodule
