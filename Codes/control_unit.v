
module control_unit(
    input clk,
    input rst,
    input [3:0]opcode,
    input [5:0] t_states,

    output reg cp,
    output reg mar_load,
    output reg chip_enable,
    output reg w_enable,
    output reg ir_load,
    output reg A_load,
    output reg B_load,
    output reg out_load,
    output reg [3:0] alu_op,
    output reg mar_sel,
    output reg halt
);


 always @(*)
 begin
      
        cp = 0; 
        mar_load = 0;
        ir_load = 0;
        chip_enable = 0;
        A_load = 0; 
        B_load = 0;
        alu_op=4'b0000;
        out_load = 0;
        mar_sel  = 0;
        w_enable = 0;
      

     if (rst || halt) begin
        //nothing active
    end

    
    else begin
        case (t_states)

// T0
            6'b000001: begin //this is the address state
                mar_sel = 0;
                mar_load = 1;
                
                
            end
// T1
            6'b000010: begin//this is the increment state
                cp = 1;
            end
// T2
            6'b000100 : begin //this is the memory state
                chip_enable=1;
                ir_load = 1;
            end
// T3
            6'b001000: begin    
                mar_sel  = 1;       
                mar_load = 1;  
                    
            end

// T4
6'b010000: begin
    case (opcode)
        4'b0000: begin // LDA
            chip_enable = 1;
            B_load = 1;
        end

        4'b0010: begin // ADD
            chip_enable = 1;
            B_load = 1;
        end

        4'b0001: begin // SUB
            chip_enable = 1;
            B_load = 1;
        end
    endcase
end

// T5
6'b100000: begin
    case (opcode)
        4'b0000: begin // LDA
            A_load = 1;
        end

        4'b0010: begin // ADD
            alu_op = 4'b0001;
            A_load = 1;
        end

        4'b0001: begin // SUB
            alu_op = 4'b0010;
            A_load = 1;
        end

        4'b1110: begin // OUT
            out_load = 1;
        end

        4'b0011: begin // STORE
            chip_enable = 1;
            w_enable = 1;
        end
    endcase
end

        endcase
end
    end



 always @(posedge clk or posedge rst) begin
    if (rst)
        halt <= 1'b0;
    else if (t_states == 6'b100000 && opcode == 4'b1111)
        halt <= 1'b1;   // latch HALT forever
end



endmodule
