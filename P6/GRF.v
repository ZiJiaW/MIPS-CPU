`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:24 11/21/2016 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input RegWrite,
    input [31:0] WData,
    output [31:0] READ1,
    output [31:0] READ2
    );
integer i;
reg [31:0]grf [31:0];
initial begin
    for(i=0;i<32;i=i+1)
	     grf[i]<=0;
end
always @(posedge clk)begin
    if(reset) begin
	     for(i=0;i<32;i=i+1)
	         grf[i]<=0;
	 end
	 else if(RegWrite) begin
	     if(rd!=0)begin
	         $display("$%d <= %h",rd,WData);
	         grf[rd]<=WData;
		  end
	 end
end
assign READ1= rs==0?0:
              rs==rd&&RegWrite? WData: grf[rs];
assign READ2= rt==0?0:
              rt==rd&&RegWrite? WData: grf[rt];
endmodule
