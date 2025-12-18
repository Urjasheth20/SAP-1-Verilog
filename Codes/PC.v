module PC
( input wire clk, 
 input rst, 
 input halt,
 input cp,
  output reg [3:0]pc_out
   ); 

  always @(posedge clk) 
  begin
     if(rst)
     pc_out <= 4'b0000;

     if(!halt && cp)
     pc_out <= pc_out +1;
  end
     endmodule
