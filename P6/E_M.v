`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:48:45 11/21/2016 
// Design Name: 
// Module Name:    E_M 
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
module E_M(
    input clk,
	 input reset,
    input [31:0] INSTR,
    input [31:0] PC4,
    input [31:0] ALUOUT,
    input [31:0] RT_E,
    output [31:0] IR_M,
    output [31:0] PC4_M,
    output [31:0] AO_M,
    output [31:0] RT_M
    );
reg [31:0] ir;
reg [31:0] pc4;
reg [31:0] ao;
reg [31:0] rt;

initial begin
    ir<=0;
	 pc4<=0;
	 ao<=0;
	 rt<=0;

end
always@(posedge clk)begin
    if(reset)begin
        ir<=0;
	     pc4<=0;
	     ao<=0;
	     rt<=0;

    end
    else begin
        ir<= INSTR;
        pc4<= PC4;
	     ao<= ALUOUT;
	     rt<= RT_E;

	 end
end
assign IR_M=ir;
assign PC4_M=pc4;
assign AO_M=ao;
assign RT_M=rt;

endmodule
