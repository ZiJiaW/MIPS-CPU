`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:42 11/22/2016 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
// F level 
wire [31:0] pc;
wire [31:0] npc;
wire EN;
wire [31:0] n_npc;
wire [31:0] Instr;
wire PCSel;
PC _pc(clk,reset,EN,n_npc,pc);
MUX_2_32 MUX_PC(pc+4,npc,PCSel,n_npc);
IM im(pc[31:0],Instr);
// F/D register
wire [31:0] IR_D;
wire [31:0] PC4_D;
IF_ID D(clk,reset,EN,Instr,pc+4,IR_D,PC4_D);
// D level
wire [31:0] READ1;
wire [31:0] READ2;
wire RegWrite;
wire [31:0] WD;
wire [4:0] A3;
GRF grf(clk,reset,IR_D[25:21],IR_D[20:16],A3,RegWrite,WD,READ1,READ2);
wire [1:0] ExtSrc;
wire [31:0] immediate;
EXT ext(IR_D[15:0],ExtSrc,immediate);
wire [1:0] FW_RSD;
wire [31:0] cmp1;
wire [31:0] ncmp1;
assign ncmp1 = IR_D[25:21]==0?0:cmp1;// if rs = 0
wire [31:0] AO_M;
wire [31:0] PC4_E;
wire [31:0] PC4_M;
wire [31:0] PC4_W;
MUX_4_32 MFRSD(READ1,PC4_E+4,PC4_M+4,AO_M,FW_RSD,cmp1);
wire [1:0] FW_RTD;
wire [31:0] cmp2;
wire [31:0] ncmp2;
assign ncmp2 = IR_D[20:16]==0?0:cmp2;// if rt = 0
MUX_4_32 MFRTD(READ2,PC4_E+4,PC4_M+4,AO_M,FW_RTD,cmp2);
wire equal;
wire greater;
wire greater_or_equal;
CMP cmp(ncmp1,ncmp2,equal,greater,greater_or_equal);
//branch and jump set
NPC _NPC(PC4_D,IR_D,immediate,ncmp1,npc);
wire Jop;
wire [5:0] branch;
assign PCSel = Jop|(branch[0]&equal)|(branch[1]&~equal)|           // j jal jalr jr
                   (branch[2]&~greater)|(branch[3]&greater)|       // blez bgtz
                         (branch[4]&~greater_or_equal)|(branch[5]&greater_or_equal);//bltz bgez
// D/E register
wire [31:0] IR_E;
wire [31:0] RS_E;
wire [31:0] RT_E;
wire [31:0] EXT_E;
wire clr;
ID_EX E(IR_D,PC4_D,READ1,READ2,immediate,IR_E,PC4_E,RS_E,RT_E,EXT_E,clk,reset,clr);
// E level
wire [2:0] FW_RSE;
wire [2:0] FW_RTE;
wire [31:0] ALU_IN1;
wire [31:0] ALU_IN2;
MUX_5_32 MFRSE(RS_E,PC4_M+4,AO_M,PC4_W+4,WD,FW_RSE,ALU_IN1);
MUX_5_32 MFRTE(RT_E,PC4_M+4,AO_M,PC4_W+4,WD,FW_RTE,ALU_IN2);
// to fix 0 register
wire [31:0] nALU_IN1;
wire [31:0] nALU_IN2;
assign nALU_IN1 = IR_E[25:21]==0?0:ALU_IN1;// if rs = 0
assign nALU_IN2 = IR_E[20:16]==0?0:ALU_IN2;// if rt = 0
//SET ALU
wire ALU_BSel;
wire [31:0] REAL_ALU_IN2;
MUX_2_32 MUX_ALU_B(nALU_IN2,EXT_E,ALU_BSel,REAL_ALU_IN2);
wire [3:0] ALUOp;
wire [31:0] ALUout;
ALU alu(nALU_IN1,REAL_ALU_IN2,IR_E[10:6],ALUOp,ALUout);
//SET MULT_DIV
wire WE_HI;
wire WE_LO;
wire [1:0] md_op;
wire start;
wire busy;
wire [31:0] D_HI;
wire [31:0] D_LO;
MULT_DIV md_mod(nALU_IN1,nALU_IN2,clk,reset,WE_HI,WE_LO,md_op,start,busy,D_HI,D_LO);
wire [31:0] AO_E;
wire [1:0] AO_Sel;
assign AO_E = AO_Sel==1?D_HI:
              AO_Sel==2?D_LO:ALUout;
// E/M register
wire [31:0] IR_M;
wire [31:0] RT_M;
E_M M(clk,reset,IR_E,PC4_E,AO_E,nALU_IN2,IR_M,PC4_M,AO_M,RT_M);
// M level
wire [1:0] FW_RTM;
wire [31:0] MemData;
MUX_3_32 MFRTM(RT_M,PC4_W+4,WD,FW_RTM,MemData);
wire [31:0] real_MemData;
assign real_MemData = IR_M[20:16]==0?0:MemData;// if rt = 0
wire MemWrite;
wire [31:0] Data;
DM dm(AO_M,real_MemData,IR_M,MemWrite,clk,reset,Data);
// M/W register
wire [31:0] IR_W;
wire [31:0] AO_W;
wire [31:0] DR_W;
M_W W(clk,reset,IR_M,PC4_M,AO_M,Data,IR_W,PC4_W,AO_W,DR_W);
// W level
wire [1:0] RF_A3Sel;
MUX_3_5 MUX_RF_A3(IR_W[15:11],IR_W[20:16],31,RF_A3Sel,A3);
wire [1:0] RF_WDSel;
MUX_3_32 MUX_RF_WD(AO_W,DR_W,PC4_W+4,RF_WDSel,WD);
// CONTROL
FUNCTION_CONTROL func_ctrl(IR_D,IR_E,IR_M,IR_W,Jop,branch,ExtSrc,ALUOp,ALU_BSel,AO_Sel,MemWrite,RF_A3Sel,RF_WDSel,RegWrite,start,WE_HI,WE_LO,md_op);
wire STALL;
STAII_CONTROL stall_ctrl(IR_D,IR_E,IR_M,start,busy,STALL);
assign EN = !STALL;
assign clr = STALL;
FORWARD_CONTROL fw_ctrl(IR_D,IR_E,IR_M,IR_W,FW_RSD,FW_RTD,FW_RSE,FW_RTE,FW_RTM);
endmodule
