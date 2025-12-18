module IR(
    input clk,
    input ir_load,
    input rst,
    input [7:0] value_in,
    output reg [3:0]address,
    output reg [3:0] opcode,
    output reg [3:0] operand
    
);

always @(posedge clk)
begin
    if(rst) begin
    opcode <= 4'b0;
    operand <= 4'b0;
    end
    else if(ir_load) begin
    opcode <= value_in[7:4];
    operand <= value_in[3:0];
    end

end
endmodule
