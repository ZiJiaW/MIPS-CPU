`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:56:40 11/21/2016 
// Design Name: 
// Module Name:    M_W 
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
module M_W(
    input clk,
	 input reset,
    input [31:0] IR_M,
    input [31:0] PC4_M,
    input [31:0] AO_M,
    input [31:0] DM,
    output [31:0] IR_W,
    output [31:0] PC4_W,
    output [31:0] AO_W,
    output [31:0] DR_W
    );
reg [31:0]ir;
reg [31:0]pc4;
reg [31:0]ao;
reg [31:0]dm;
reg rw;
initial begin
    ir<=0;
	 pc4<=0;
	 ao<=0;
	 dm<=0;
end
always @(posedge clk)begin
    if(reset)begin
	     ir<=0;
	     pc4<=0;
	     ao<=0;
	     dm<=0; 	  
    end
    else begin
        ir<= IR_M;
	     pc4<= PC4_M;
	     ao<= AO_M;
	     dm<= DM;
	 end
end
assign IR_W = ir;
assign PC4_W = pc4;
assign AO_W = ao;
assign DR_W = dm;
endmodule
