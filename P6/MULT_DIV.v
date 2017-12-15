`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:10 12/07/2016 
// Design Name: 
// Module Name:    MULT_DIV 
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
module MULT_DIV(
    input [31:0] D1,
    input [31:0] D2,
    input CLK,
    input RESET,
    input WE_HI,
    input WE_LO,
    input [1:0]OP,
    input START,
    output BUSY,
    output [31:0] D_HI,
    output [31:0] D_LO
    );
reg [3:0] counter;
reg _busy;
reg [31:0] hi;
reg [31:0] lo;
reg [1:0]_op;
reg [31:0] d1;
reg [31:0] d2;
initial begin
    counter<=0;
	 hi<=0;
	 lo<=0;
	 _op<=0;
	 _busy<=0;
	 d1<=0;
	 d2<=0;
end
always @(posedge CLK)begin
    if(RESET)begin
	     counter<=0;
	     hi<=0;
	     lo<=0;
		  _op<=0;
	     _busy<=0;
		  d1<=0;
		  d2<=0;
	 end
	 else if(START)begin
	     _busy <= 1;
		  _op<= OP;
		  d1<=D1;
		  d2<=D2;
	 end
	 else if(WE_HI)begin
	     hi<=D1;
	 end
	 else if(WE_LO)begin
	     lo<=D1;
	 end
	 if(_busy)begin
	     counter<=counter+1;
	 end
	 if(counter==4&&(_op==0|_op==1))begin
	     _busy<=0;
		  counter<=0;
		  if(_op==0)
		      {hi,lo}<=d1*d2;
		  else if(_op==1)
		      {hi,lo}<=$signed(d1)*$signed(d2);
	 end
	 if(counter==9&&(_op==2|_op==3))begin
	 	  _busy<=0;
		  counter<=0;
		  if(_op==2&&d2!=0)begin
		      lo<=d1/d2;
				hi<=d1%d2;
		  end
		  else if(_op==3&&d2!=0)begin
		      lo<=$signed(d1)/$signed(d2);
				hi<=$signed(d1)%$signed(d2);
		  end
	 end
end
assign BUSY = _busy;
assign D_HI = hi;
assign D_LO = lo;
endmodule
