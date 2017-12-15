`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:52 11/21/2016 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
     input EN,
    input [31:0] NPC,
    output [31:0] PC
    );
reg [31:0]_pc;
initial begin
    _pc <= 32'h00003000;
end
always @(posedge clk)begin
    if(reset)
         _pc<=32'h00003000;
     else if(EN)
         _pc <= NPC;
end
assign PC = _pc;
endmodule
