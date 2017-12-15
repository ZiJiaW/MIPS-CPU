`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:26 11/21/2016 
// Design Name: 
// Module Name:    MUX_2_32 
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
module MUX_2_32(
    input [31:0] A,
    input [31:0] B,
    input SEL,
    output [31:0] C
    );
assign C = SEL==0?A:B;
endmodule

module MUX_3_5(
    input [4:0] A,
     input [4:0] B,
     input [4:0] C,
     input [1:0]SEL,
     output [4:0] D
);
assign D = SEL==0?A:
           SEL==1?B:
              SEL==2?C:0;
endmodule

module MUX_3_32(
    input [31:0] A,
    input [31:0] B,
     input [31:0] C,
    input [1:0]SEL,
    output [31:0] out
    );
assign out = SEL==0?A:
             SEL==1?B:
                 SEL==2?C:0;
endmodule

module MUX_4_32(
    input [31:0] A,
    input [31:0] B,
     input [31:0] C,
     input [31:0] D,
    input [1:0]SEL,
    output [31:0] out
    );
assign out = SEL==0?A:
             SEL==1?B:
                 SEL==2?C:
                 SEL==3?D:0;
endmodule

module MUX_5_32(
    input [31:0] A,
    input [31:0] B,
     input [31:0] C,
     input [31:0] D,
     input [31:0] E,
    input [2:0]SEL,
    output [31:0] out
    );
assign out = SEL==0?A:
             SEL==1?B:
                 SEL==2?C:
                 SEL==3?D:
                 SEL==4?E:0;
endmodule

