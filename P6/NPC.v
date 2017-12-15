`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:25 11/21/2016 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC4_D,
    input [31:0] INSTR,
	 input [31:0] EXT,
	 input [31:0] READ1,
    output reg[31:0] NPC
    );
always @(*)begin
    case(INSTR[31:26])
		  6'b000010: NPC = {PC4_D[31:28],INSTR[25:0],2'b00};//j
		  6'b000011: NPC = {PC4_D[31:28],INSTR[25:0],2'b00};//jal
		  6'b000000: NPC = READ1;//jr jalr
		  default: NPC = PC4_D+{EXT[29:0],2'b00}; //branch
	 endcase
end
endmodule
