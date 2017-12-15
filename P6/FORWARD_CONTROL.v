`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:41 11/22/2016 
// Design Name: 
// Module Name:    FORWARD_CONTROL 
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
module FORWARD_CONTROL(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
    output [1:0] FW_RSD,
    output [1:0] FW_RTD,
    output [2:0] FW_RSE,
    output [2:0] FW_RTE,
    output [1:0]FW_RTM
    );
`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define funct 5:0
//instruction define 
`define calr 6'b000000
`define funct_addu 6'b100001
`define funct_subu 6'b100011
`define ori 6'b001101
`define lui 6'b001111
`define j 6'b000010
`define lw 6'b100011
`define sw 6'b101011
`define beq 6'b000100
`define nop 32'h00000000
`define jal 6'b000011
`define funct_jr 6'b001000
`define funct_add 6'b100000
`define addi 6'b001000
`define addiu 6'b001001
`define bne 6'b000101
`define funct_sub 6'b100010
`define funct_srl 6'b000010
`define funct_sll 6'b000000
`define funct_or 6'b100101
`define funct_xor 6'b100110
`define funct_and 6'b100100
`define funct_sra 6'b000011
`define funct_sllv 6'b000100
`define funct_srlv 6'b000110
`define funct_srav 6'b000111
`define funct_nor 6'b100111
`define funct_slt 6'b101010
`define funct_sltu 6'b101011
`define andi 6'b001100
`define xori 6'b001110
`define slti 6'b001010
`define sltiu 6'b001011
`define lb 6'b100000
`define lbu 6'b100100
`define lh 6'b100001
`define lhu 6'b100101
`define sb 6'b101000
`define sh 6'b101001
`define blez 6'b000110
`define bgtz 6'b000111
`define bltz_bgez 6'b000001
`define funct_jalr 6'b001001
`define funct_mult 6'b011000
`define funct_multu 6'b011001
`define funct_div 6'b011010
`define funct_divu 6'b011011
`define funct_mfhi 6'b010000
`define funct_mflo 6'b010010
`define funct_mthi 6'b010001
`define funct_mtlo 6'b010011
////use register
wire rs_d;
wire rt_d;
wire rs_e;
wire rt_e;
wire rt_m;
//// assign work
assign rs_d=IR_D[`op]==`beq|
            IR_D[`op]==`bne|
				IR_D[`op]==`blez|
				IR_D[`op]==`bgtz|
				IR_D[`op]==`bltz_bgez|
				(IR_D[`op]==`calr&IR_D[`funct]==`funct_jr)|
				(IR_D[`op]==`calr&IR_D[`funct]==`funct_jalr);
assign rt_d=IR_D[`op]==`beq|IR_D[`op]==`bne;
assign rs_e=(IR_E[`op]==`calr&(IR_E[`funct]==`funct_add|
                               IR_E[`funct]==`funct_addu|
										 IR_E[`funct]==`funct_sub|
										 IR_E[`funct]==`funct_subu|
										 IR_E[`funct]==`funct_sllv|
										 IR_E[`funct]==`funct_srlv|
										 IR_E[`funct]==`funct_srav|
										 IR_E[`funct]==`funct_and|
										 IR_E[`funct]==`funct_or|
										 IR_E[`funct]==`funct_xor|
										 IR_E[`funct]==`funct_nor|
										 IR_E[`funct]==`funct_slt|
										 IR_E[`funct]==`funct_sltu|
										 IR_E[`funct]==`funct_mult|
										 IR_E[`funct]==`funct_multu|
										 IR_E[`funct]==`funct_div|
										 IR_E[`funct]==`funct_divu|
										 IR_E[`funct]==`funct_mthi|
										 IR_E[`funct]==`funct_mtlo))|IR_E[`op]==`addi|
										                            IR_E[`op]==`addiu|
																			 IR_E[`op]==`andi|
																			 IR_E[`op]==`ori|
																			 IR_E[`op]==`xori|
																			 IR_E[`op]==`slti|
																			 IR_E[`op]==`sltiu|
																			 IR_E[`op]==`lw|
																			 IR_E[`op]==`lb|
																			 IR_E[`op]==`lbu|
																			 IR_E[`op]==`lh|
																			 IR_E[`op]==`lhu|
																			 IR_E[`op]==`sw|
																			 IR_E[`op]==`sb|
																			 IR_E[`op]==`sh;
assign rt_e=(IR_E[`op]==`calr&(IR_E[`funct]==`funct_add|
                               IR_E[`funct]==`funct_addu|
										 IR_E[`funct]==`funct_sub|
										 IR_E[`funct]==`funct_subu|
										 IR_E[`funct]==`funct_sll|
										 IR_E[`funct]==`funct_srl|
										 IR_E[`funct]==`funct_sra|
										 IR_E[`funct]==`funct_sllv|
										 IR_E[`funct]==`funct_srlv|
										 IR_E[`funct]==`funct_srav|
										 IR_E[`funct]==`funct_and|
										 IR_E[`funct]==`funct_or|
										 IR_E[`funct]==`funct_xor|
										 IR_E[`funct]==`funct_nor|
										 IR_E[`funct]==`funct_slt|
										 IR_E[`funct]==`funct_sltu|
										 IR_E[`funct]==`funct_mult|
										 IR_E[`funct]==`funct_multu|
										 IR_E[`funct]==`funct_div|
										 IR_E[`funct]==`funct_divu))|IR_E[`op]==`sw|IR_E[`op]==`sb|IR_E[`op]==`sh;
assign rt_m=IR_M[`op]==`sw|IR_M[`op]==`sb|IR_M[`op]==`sh;
//// write 
wire jal_e;    // write 31 at e by pc8e
wire jalr_e;   // write rd at e by pc8e
wire jal_m;    // write 31 at m by pc8m
wire jalr_m;   // write rd at m by pc8m
wire w_rd_m;   // write rd at m by AO_M
wire w_rt_m;   // write rt at m by AO_M
wire jal_w;    // write 31 at w by pc8w
wire jalr_w;   // write rd at w by pc8w
wire w_rd_w;   // write rd at w by MUX_RF_WD
wire w_rt_w;   // write rt at w by MUX_RF_WD
//// assign work
assign jal_e=IR_E[`op]==`jal;
assign jalr_e=IR_E[`op]==`calr&IR_E[`funct]==`funct_jalr;
assign jal_m=IR_M[`op]==`jal;
assign jalr_m=IR_M[`op]==`calr&IR_M[`funct]==`funct_jalr;
assign w_rd_m=IR_M[`op]==`calr&(IR_M[`funct]==`funct_add|
                                IR_M[`funct]==`funct_addu|
										  IR_M[`funct]==`funct_sub|
										  IR_M[`funct]==`funct_subu|
										  IR_M[`funct]==`funct_sll|
										  IR_M[`funct]==`funct_srl|
										  IR_M[`funct]==`funct_sra|
										  IR_M[`funct]==`funct_sllv|
										  IR_M[`funct]==`funct_srlv|
										  IR_M[`funct]==`funct_srav|
										  IR_M[`funct]==`funct_and|
										  IR_M[`funct]==`funct_or|
										  IR_M[`funct]==`funct_xor|
										  IR_M[`funct]==`funct_nor|
										  IR_M[`funct]==`funct_slt|
										  IR_M[`funct]==`funct_sltu|
										  IR_M[`funct]==`funct_mfhi|
										  IR_M[`funct]==`funct_mflo);
assign w_rt_m=IR_M[`op]==`addi|
              IR_M[`op]==`addiu|
				  IR_M[`op]==`andi|
				  IR_M[`op]==`ori|
				  IR_M[`op]==`xori|
				  IR_M[`op]==`lui|
				  IR_M[`op]==`slti|
				  IR_M[`op]==`sltiu;
assign jal_w=IR_W[`op]==`jal;
assign jalr_w=IR_W[`op]==`calr&IR_W[`funct]==`funct_jalr;
assign w_rd_w=IR_W[`op]==`calr&(IR_W[`funct]==`funct_add|
                                IR_W[`funct]==`funct_addu|
										  IR_W[`funct]==`funct_sub|
										  IR_W[`funct]==`funct_subu|
										  IR_W[`funct]==`funct_sll|
										  IR_W[`funct]==`funct_srl|
										  IR_W[`funct]==`funct_sra|
										  IR_W[`funct]==`funct_sllv|
										  IR_W[`funct]==`funct_srlv|
										  IR_W[`funct]==`funct_srav|
										  IR_W[`funct]==`funct_and|
										  IR_W[`funct]==`funct_or|
										  IR_W[`funct]==`funct_xor|
										  IR_W[`funct]==`funct_nor|
										  IR_W[`funct]==`funct_slt|
										  IR_W[`funct]==`funct_sltu|
										  IR_W[`funct]==`funct_mfhi|
										  IR_W[`funct]==`funct_mflo);
assign w_rt_w=IR_W[`op]==`addi|
              IR_W[`op]==`addiu|
				  IR_W[`op]==`andi|
				  IR_W[`op]==`ori|
				  IR_W[`op]==`xori|
				  IR_W[`op]==`lui|
				  IR_W[`op]==`slti|
				  IR_W[`op]==`sltiu|
				  IR_W[`op]==`lw|
				  IR_W[`op]==`lb|
				  IR_W[`op]==`lh|
				  IR_W[`op]==`lbu|
				  IR_W[`op]==`lhu;
assign FW_RSD = rs_d&jal_e&IR_D[`rs]==31?1:
                rs_d&jalr_e&IR_D[`rs]==IR_E[`rd]?1:
					 rs_d&jal_m&IR_D[`rs]==31?2:
					 rs_d&jalr_m&IR_D[`rs]==IR_M[`rd]?2:
					 rs_d&w_rd_m&IR_D[`rs]==IR_M[`rd]?3:
					 rs_d&w_rt_m&IR_D[`rs]==IR_M[`rt]?3:0;
//////////0:read1; 1:PC8_E; 2:PC8_M; 3:AO_M
assign FW_RTD = rt_d&jal_e&IR_D[`rt]==31?1:
                rt_d&jalr_e&IR_D[`rt]==IR_E[`rd]?1:
					 rt_d&jal_m&IR_D[`rt]==31?2:
					 rt_d&jalr_m&IR_D[`rt]==IR_M[`rd]?2:
					 rt_d&w_rd_m&IR_D[`rt]==IR_M[`rd]?3:
					 rt_d&w_rt_m&IR_D[`rt]==IR_M[`rt]?3:0;
//////////0:read2; 1:PC8_E; 2:PC8_M; 3:AO_M					 
assign FW_RSE = rs_e&jal_m&IR_E[`rs]==31?1:
                rs_e&jalr_m&IR_E[`rs]==IR_M[`rd]?1:
					 rs_e&w_rd_m&IR_E[`rs]==IR_M[`rd]?2:
					 rs_e&w_rt_m&IR_E[`rs]==IR_M[`rt]?2:
					 rs_e&jal_w&IR_E[`rs]==31?3:
                rs_e&jalr_w&IR_E[`rs]==IR_W[`rd]?3:
					 rs_e&w_rd_w&IR_E[`rs]==IR_W[`rd]?4:
					 rs_e&w_rt_w&IR_E[`rs]==IR_W[`rt]?4:0;
//////////0:RS_E; 1:PC8_E; 2:AO_M; 3:PC8_W; 4:MUX_RF_WD					 
assign FW_RTE = rt_e&jal_m&IR_E[`rt]==31?1:
                rt_e&jalr_m&IR_E[`rt]==IR_M[`rd]?1:
					 rt_e&w_rd_m&IR_E[`rt]==IR_M[`rd]?2:
					 rt_e&w_rt_m&IR_E[`rt]==IR_M[`rt]?2:
					 rt_e&jal_w&IR_E[`rt]==31?3:
                rt_e&jalr_w&IR_E[`rt]==IR_W[`rd]?3:
					 rt_e&w_rd_w&IR_E[`rt]==IR_W[`rd]?4:
					 rt_e&w_rt_w&IR_E[`rt]==IR_W[`rt]?4:0;
//////////0:RT_E; 1:PC8_E; 2:AO_M; 3:PC8_W; 4:MUX_RF_WD					 
assign FW_RTM = rt_m&jal_w&IR_M[`rt]==31?1:
                rt_m&jalr_w&IR_M[`rt]==IR_W[`rd]?1:
					 rt_m&w_rd_w&IR_M[`rt]==IR_W[`rd]?2:
					 rt_m&w_rt_w&IR_M[`rt]==IR_W[`rt]?2:0;
//////////0:RT_M; 1:PC8_W; 2:MUX_RF_WD
endmodule
