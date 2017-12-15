`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:33 11/21/2016 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] Addr,
    output[31:0] Out
    );
     reg [31:0] _im[2047:0];
     initial begin
         $readmemh("code.txt",_im);
     end
     wire [31:0]pc;
     assign pc = Addr-32'h00003000;
    assign Out = _im[pc[12:2]];
endmodule