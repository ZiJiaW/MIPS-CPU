`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:58 11/21/2016 
// Design Name: 
// Module Name:    IF_ID 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IF_ID(
    input clk,
	 input reset,
    input EN,
    input [31:0] INSTR,
    input [31:0] PC4,
    output [31:0] IR_D,
    output [31:0] PC4_D
    );
reg [31:0] ir;
reg [31:0] pc4;
initial begin
    ir<=0;
	 pc4<=0;
end
always @(posedge clk)begin
    if(reset) begin
	     ir<=0;
	     pc4<=0;
	 end
	 else if(EN) begin
	     ir<=INSTR;
		  pc4<= PC4;
	 end
end
assign IR_D = ir;
assign PC4_D = pc4;
endmodule
