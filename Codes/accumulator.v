module accumulator(
    input clk,
    input rst,
    input A_load,
    input [7:0] value_in,
    output reg [7:0]value_out
);

always @(posedge clk)
begin
if(rst)
value_out <= 8'b00000000;
if(A_load)
value_out <= value_in;
end

endmodule
