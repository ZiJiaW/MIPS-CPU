`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:44 11/21/2016 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
    input [31:0] IR_D,
    input [31:0] PC4_D,
    input [31:0] READ1,
    input [31:0] READ2,
    input [31:0] EXT,
    output [31:0] IR_E,
    output [31:0] PC4_E,
    output [31:0] RS_E,
    output [31:0] RT_E,
    output [31:0] EXT_E,
    input clk,
     input reset,
    input clr
    );
reg [31:0] ir;
reg [31:0] pc4;
reg [31:0] rs;
reg [31:0] rt;
reg [31:0] ext;
initial begin
    ir<=0;
     pc4<=0;
     rs<=0;
     rt<=0;
     ext<=0;
end
always @(posedge clk)begin
    if(clr|reset) begin
         ir<=0;
         pc4<=0;
         rs<=0;
         rt<=0;
         ext<=0;
     end
     else begin
         ir<=IR_D;
          pc4<=PC4_D;
          rs<=READ1;
          rt<=READ2;
          ext<=EXT;
     end
end
assign IR_E=ir;
assign PC4_E=pc4;
assign RS_E=rs;
assign RT_E=rt;
assign EXT_E=ext;
endmodule
