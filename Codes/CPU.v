`include "PC.v"
`include "MAR.v"
`include "RAM.v"
`include "IR.v"
`include "control_unit.v"
`include "accumulator.v"
`include "register_b.v"
`include "ALU.v"
`include "t_state_counter.v"
`include "output_register.v"


module CPU(
    input clk,
    input rst
);

wire [5:0] t_states;
wire [3:0] opcode, operand;
wire [7:0] ram_data, alu_result;
wire [3:0] pc_out, mar_out;
wire [7:0] A_out, B_out,O_out;
wire w_enable;


// Control signals
wire pc_E, cp, mar_load, chip_enable, ir_load;
wire A_load, B_load, out_load;
wire [3:0] alu_op;
wire mar_sel;
wire halt;





// Timing
t_state_counter TSC(
    .clk(clk),
    .rst(rst),
    .halt(halt),
    .t(t_states)
);

// PC
PC pc(
    .clk(clk),
    .rst(rst),
    .halt(halt),
    .cp(cp),
    .pc_out(pc_out)
);

// MAR
MAR mar(
    .clk(clk),
    .rst(rst),
    .mar_load(mar_load),
    .mar_sel(mar_sel),
    .pc_addr(pc_out),
    .operand_addr(operand),
    .memory_add_out(mar_out)
);


RAM ram(
    .clk(clk),
    .chip_enable(chip_enable),
    .w_enable(w_enable),
    .data_in(A_out),
    .address(mar_out),
    .data_out(ram_data)
);


// IR
IR ir(
    .clk(clk),
    .rst(rst),
    .ir_load(ir_load),
    .value_in(ram_data),
    .opcode(opcode),
    .operand(operand)
);

// A register
accumulator A(
    .clk(clk),
    .rst(rst),
    .A_load(A_load),
    .value_in(alu_result),
    .value_out(A_out)
);

// B register
register_b B(
    .clk(clk),
    .rst(rst),
    .B_load(B_load),
    .value_in(ram_data),
    .value_out(B_out)
);

// ALU
ALU alu(
    .A(A_out),
    .B(B_out),
    .alu_op(alu_op),
    .result(alu_result)
);
//output register
output_register OR(
    .clk(clk),
    .rst(rst),
    .data_in(A_out),
    .data_out(O_out),
    .out_load(out_load)
);
// Control Unit
control_unit CU(
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    .t_states(t_states),
    .cp(cp),
    .w_enable(w_enable),  
    .mar_load(mar_load),
    .chip_enable(chip_enable),
    .ir_load(ir_load),
    .A_load(A_load),
    .B_load(B_load),
    .alu_op(alu_op),
    .out_load(out_load),
    .mar_sel(mar_sel),
    .halt(halt)
);




endmodule
