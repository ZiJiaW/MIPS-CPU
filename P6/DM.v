`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:03 11/21/2016 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] MemAddr,
    input [31:0] MemData,
	 input [31:0] IR_M,
    input MemWrite,
	 input Clk,
	 input Reset,
    output [31:0] Data
    );
reg[31:0] mem[2047:0];
integer i;
// set
wire lb;
wire lbu;
wire lh;
wire lhu;
wire lw;
wire sb;
wire sh;
wire sw;
assign lb = IR_M[31:26]==6'b100000;
assign lbu = IR_M[31:26]==6'b100100;
assign lh = IR_M[31:26]==6'b100001;
assign lhu = IR_M[31:26]==6'b100101;
assign lw = IR_M[31:26]==6'b100011;
assign sb = IR_M[31:26]==6'b101000;
assign sh = IR_M[31:26]==6'b101001;
assign sw = IR_M[31:26]==6'b101011;
//
initial begin
	 for(i=0;i<2048;i=i+1)
		  mem[i]<=0;
end
always @(posedge Clk) begin
    if(Reset)begin
	     for(i=0;i<2048;i=i+1)
		      mem[i]<=0;
	 end
	 else if(MemWrite)begin
	     if(sw)begin
	         mem[MemAddr[12:2]]<=MemData;
		      $display("*%h <= %h",MemAddr,MemData);
		  end
		  else if(sh)begin
		      if(MemAddr[1])begin
				    mem[MemAddr[12:2]][31:16]<=MemData[15:0];
					 $display("*%h <= %h",MemAddr,MemData[15:0]);
				end
				else begin
				    mem[MemAddr[12:2]][15:0]<=MemData[15:0];
					 $display("*%h <= %h",MemAddr,MemData[15:0]);
				end
		  end
		  else if(sb)begin
		      if(MemAddr[1:0]==0)begin
				    mem[MemAddr[12:2]][7:0]<=MemData[7:0];
					 $display("*%h <= %h",MemAddr,MemData[7:0]);
				end
				else if(MemAddr[1:0]==1)begin
				    mem[MemAddr[12:2]][15:8]<=MemData[7:0];
					 $display("*%h <= %h",MemAddr,MemData[7:0]);				    
				end
				else if(MemAddr[1:0]==2)begin
				    mem[MemAddr[12:2]][23:16]<=MemData[7:0];
					 $display("*%h <= %h",MemAddr,MemData[7:0]);				    
				end
				else if(MemAddr[1:0]==3)begin
				    mem[MemAddr[12:2]][31:24]<=MemData[7:0];
					 $display("*%h <= %h",MemAddr,MemData[7:0]);				    
				end
		  end
	 end
end
wire [7:0]byte0;
wire [7:0]byte1;
wire [7:0]byte2;
wire [7:0]byte3;
assign byte0=mem[MemAddr[12:2]][7:0];
assign byte1=mem[MemAddr[12:2]][15:8];
assign byte2=mem[MemAddr[12:2]][23:16];
assign byte3=mem[MemAddr[12:2]][31:24];
assign Data= lb==1? (MemAddr[1:0]==0?(byte0[7]==1?{24'hffffff,byte0}:{24'h000000,byte0}):
                     MemAddr[1:0]==1?(byte1[7]==1?{24'hffffff,byte1}:{24'h000000,byte1}):
							MemAddr[1:0]==2?(byte2[7]==1?{24'hffffff,byte2}:{24'h000000,byte2}):
							MemAddr[1:0]==3?(byte3[7]==1?{24'hffffff,byte3}:{24'h000000,byte3}):0):
				 lbu==1?(MemAddr[1:0]==0?{24'h000000,byte0}:
                     MemAddr[1:0]==1?{24'h000000,byte1}:
							MemAddr[1:0]==2?{24'h000000,byte2}:
							MemAddr[1:0]==3?{24'h000000,byte3}:0):
				 lh==1?(MemAddr[1]==0?(byte1[7]==1?{16'hffff,byte1,byte0}:{16'h0000,byte1,byte0}):
				        (byte3[7]==1?{16'hffff,byte3,byte2}:{16'h0000,byte3,byte2})):
				 lhu==1?(MemAddr[1]==0?{16'h0000,byte1,byte0}:{16'h0000,byte3,byte2}):mem[MemAddr[12:2]];
endmodule