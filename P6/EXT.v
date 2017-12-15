`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:37 11/21/2016 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] immediate,
    input [1:0] ExtSrc,
    output reg[31:0] IME
    );
always @(*) begin
    case(ExtSrc)
         2'b00: if(immediate[15]) IME={16'hffff,immediate};else IME={16'h0000,immediate};//signed exetend
          2'b01: IME={16'h0000,immediate};//zero exetend
          2'b10: IME={immediate,16'h0000};//lui
     endcase
end
endmodule