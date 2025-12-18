module MAR(
    input clk,
    input rst,
    input mar_load,
    input mar_sel,
    input wire [3:0]pc_addr,
    input [3:0] operand_addr,
    output reg [3:0]memory_add_out
);

wire [3:0] mar_in;

// MUX: select address source
assign mar_in = (mar_sel == 1'b0) ? pc_addr : operand_addr;

always @(posedge clk or posedge rst) begin
    if (rst)
        memory_add_out <= 4'b0000;
    else if (mar_load)
        memory_add_out <= mar_in;
        end

endmodule
