`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:23:45 11/21/2016 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] D1,
    input [31:0] D2,
    output equal,
     output greater,
     output greater_or_equal
    );
assign equal = (D1==D2);
assign greater = (D1[31]==0)&(D1!=0);
assign greater_or_equal= D1[31]==0;
endmodule
