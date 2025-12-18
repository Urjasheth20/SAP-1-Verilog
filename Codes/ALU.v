module ALU(
    input [7:0]A,
    input [7:0]B,
    input [3:0]alu_op,
    output reg [7:0]result

);

always @(*) begin
    case (alu_op)

        
        4'b0011: result = A - B; 

        default: result = A + B;  
    endcase
end
    
endmodule
