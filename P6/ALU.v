`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:11 11/21/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] data1,
    input [31:0] data2,
	 input [4:0] sa,
    input [3:0] ALUOp,
    output reg[31:0] Ret
    );
    always@(*) begin
		  case(ALUOp) 
		  4'b0000: Ret = data1+data2;//add
		  4'b0001: Ret = data1-data2;//sub
		  4'b0010: Ret = data1|data2;//or
		  4'b0011: Ret = data1&data2;//and
		  4'b0100: Ret = data1^data2;//xor
		  4'b0101: Ret = data2<<sa;//sll
		  4'b0110: Ret = data2>>sa;//srl
		  4'b0111: Ret = data2[31]==1?{32'hffffffff,data2}>>sa:{32'h00000000,data2}>>sa;//sra
		  4'b1000: Ret = data2<<data1[4:0];//sllv
		  4'b1001: Ret = data2>>data1[4:0];//srlv
		  4'b1010: Ret = data2[31]==1?{32'hffffffff,data2}>>data1[4:0]:{32'h00000000,data2}>>data1[4:0];//srav
		  4'b1011: Ret = ~(data1|data2);//nor
		  4'b1100: Ret = $signed(data1)<$signed(data2);//slt
		  4'b1101: Ret = data1<data2;//sltu
		  endcase
	 end
endmodule