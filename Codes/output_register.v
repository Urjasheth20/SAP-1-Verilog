module output_register(
    input clk,
    input rst,
    input out_load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        data_out <= 8'b0;
    else if (out_load)
        data_out <= data_in;
end

endmodule
