module RAM(
    input clk,
    input chip_enable,
    input w_enable,
    input [7:0]data_in,
    input [3:0] address,
    output reg [7:0] data_out

);

reg [7:0] mem [0:15];
//this is a sample input
initial begin
    mem[0] = 8'b0000_0101; // LDA 4
    mem[1] = 8'b0010_0110; // ADD 5
    mem[2] = 8'b1110_0000; // OUT
    mem[3] = 8'b0011_0111; //Write value at 6
    mem[4] = 8'b1111_0000; // HLT
    mem[5] = 8'b0000_0100; // data = 4
    mem[6] = 8'b0000_0010; //data =2
  
end

always @(posedge clk) begin
    if (chip_enable && w_enable)
        mem[address] <= data_in;
end

always @(*) 
begin
    if(chip_enable)
    data_out <= mem[address];
    else
    begin
    data_out <= 8'bzzzzzzzz;
    end
end

initial begin
    #1;
    $display("mem[7] = %h", mem[7]);

    #500
    $display("mem[7] = %h", mem[7]);

end
endmodule
