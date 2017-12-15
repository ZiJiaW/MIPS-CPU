`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:35:34 11/22/2016 
// Design Name: 
// Module Name:    STAII_CONTROL 
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
module STAII_CONTROL(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
     input start,
     input busy,
    output STALL
    );
`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define funct 5:0
//instruction define 
`define calr 6'b000000
`define addu 6'b100001
`define subu 6'b100011
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
////////////////////////////
wire stall_beq;
wire stall_calr;
wire stall_cali;
wire stall_lw;
wire stall_sw;
wire stall_jr;
wire stall_mult;
wire beq_d;  // use rs/rt  & tuse=0
wire calr_d; // use rs/rt & tuse = 1  
wire cali_d; // use rs & tuse = 1
wire lw_d;   // use rs & tuse = 1
wire sw_d;   // use rs t=1/ rt t=2
wire jr_d;   // use rs tuse = 0   jr/jalr
wire mult_d; // use mult_div or hi or lo
assign beq_d = IR_D[`op]==`beq|IR_D[`op]==`bne|IR_D[`op]==`blez|IR_D[`op]==`bgtz|IR_D[`op]==`bltz_bgez;//branch
assign calr_d = (IR_D[`op]==6'b000000)&((IR_D[`funct]==`addu)|//addu
                                        (IR_D[`funct]==`subu)|//subu
                                                     (IR_D[`funct]==`funct_sll)|//sll
                                                     (IR_D[`funct]==`funct_add)|//add
                                                     (IR_D[`funct]==`funct_sub)|//sub
                                                     (IR_D[`funct]==`funct_srl)|//srl
                                                     (IR_D[`funct]==`funct_or)|//or
                                                     (IR_D[`funct]==`funct_xor)|//xor
                                                     (IR_D[`funct]==`funct_and)|//and
                                                     (IR_D[`funct]==`funct_sra)|
                                                     (IR_D[`funct]==`funct_sllv)|
                                                     (IR_D[`funct]==`funct_srlv)|
                                                     (IR_D[`funct]==`funct_srav)|
                                                     (IR_D[`funct]==`funct_nor)|
                                                     (IR_D[`funct]==`funct_slt)|
                                                     (IR_D[`funct]==`funct_sltu)|
                                                     (IR_D[`funct]==`funct_mult)|
                                                     (IR_D[`funct]==`funct_multu)|
                                                     (IR_D[`funct]==`funct_divu)|
                                                     (IR_D[`funct]==`funct_div));
assign cali_d = IR_D[`op]==`ori|//ori
                IR_D[`op]==`lui|//lui
                     IR_D[`op]==`addi|//addi
                     IR_D[`op]==`addiu|
                     IR_D[`op]==`andi|
                     IR_D[`op]==`xori|
                     IR_D[`op]==`slti|
                     IR_D[`op]==`sltiu|
                     (IR_D[`op]==`calr&IR_D[`funct]==`funct_mthi)|
                     (IR_D[`op]==`calr&IR_D[`funct]==`funct_mtlo);
assign lw_d = IR_D[`op]==`lw|
              IR_D[`op]==`lb|
                  IR_D[`op]==`lbu|
                  IR_D[`op]==`lh|
                  IR_D[`op]==`lhu;
assign sw_d = IR_D[`op]==`sw|
              IR_D[`op]==`sb|
                  IR_D[`op]==`sh;
assign jr_d = (IR_D[`op]==`calr&IR_D[`funct]==`funct_jr)|
              (IR_D[`op]==`calr&IR_D[`funct]==`funct_jalr);
assign mult_d = (IR_D[`op]==6'b000000)&((IR_D[`funct]==`funct_mult)|
                                                     (IR_D[`funct]==`funct_multu)|
                                                     (IR_D[`funct]==`funct_divu)|
                                                     (IR_D[`funct]==`funct_div)|
                                                     (IR_D[`funct]==`funct_mfhi)|
                                                     (IR_D[`funct]==`funct_mflo)|
                                                     (IR_D[`funct]==`funct_mthi)|
                                                     (IR_D[`funct]==`funct_mtlo));
wire calr_e;// write rd and t new = 1
wire cali_e;// write rt and t new = 1
wire lw_e;  // write rt and t new = 2
assign calr_e = IR_E[31:0]!=`nop&(IR_E[`op]==`calr)&((IR_E[`funct]==`addu)|//addu
                                                     (IR_E[`funct]==`subu)|//subu
                                                                  (IR_E[`funct]==`funct_sll)|//sll
                                                                  (IR_E[`funct]==`funct_add)|//add
                                                                  (IR_E[`funct]==`funct_sub)|//sub
                                                                  (IR_E[`funct]==`funct_srl)|//srl
                                                                  (IR_E[`funct]==`funct_or)|//or
                                                                  (IR_E[`funct]==`funct_xor)|//xor
                                                                  (IR_E[`funct]==`funct_and)|
                                                                     (IR_E[`funct]==`funct_sra)|
                                                                  (IR_E[`funct]==`funct_sllv)|
                                                                  (IR_E[`funct]==`funct_srlv)|
                                                                  (IR_E[`funct]==`funct_srav)|
                                                                  (IR_E[`funct]==`funct_nor)|
                                                                  (IR_E[`funct]==`funct_slt)|
                                                                  (IR_E[`funct]==`funct_sltu)|
                                                                      (IR_E[`funct]==`funct_mfhi)|
                                                                      (IR_E[`funct]==`funct_mflo));
assign cali_e = IR_E[`op]==`ori|
                IR_E[`op]==`lui|
                     IR_E[`op]==`addi|
                     IR_E[`op]==`addiu|
                     IR_E[`op]==`andi|
                     IR_E[`op]==`xori|
                     IR_E[`op]==`slti|
                     IR_E[`op]==`sltiu;
assign lw_e = IR_E[`op]==`lw|
              IR_E[`op]==`lb|
                  IR_E[`op]==`lbu|
                  IR_E[`op]==`lh|
                  IR_E[`op]==`lhu;
wire lw_m;
assign lw_m = IR_M[`op]==`lw|
              IR_M[`op]==`lb|
                  IR_M[`op]==`lbu|
                  IR_M[`op]==`lh|
                  IR_M[`op]==`lhu;

assign stall_beq = beq_d&((calr_e&(IR_E[`rd]==IR_D[`rs]|IR_E[`rd]==IR_D[`rt]))|
                          (cali_e&(IR_D[`rs]==IR_E[`rt]|IR_D[`rt]==IR_E[`rt]))|
                                  (lw_e&(IR_D[`rs]==IR_E[`rt]|IR_D[`rt]==IR_E[`rt]))|
                                  (lw_m&(IR_D[`rs]==IR_M[`rt]|IR_D[`rt]==IR_M[`rt])));
assign stall_calr = calr_d&(lw_e&(IR_D[`rs]==IR_E[`rt]|IR_D[`rt]==IR_E[`rt]));
assign stall_cali = cali_d&lw_e&(IR_D[`rs]==IR_E[`rt]);
assign stall_lw = lw_d&lw_e&(IR_D[`rs]==IR_E[`rt]);
assign stall_sw = sw_d&lw_e&(IR_D[`rs]==IR_E[`rt]);
assign stall_jr = jr_d&((calr_e&(IR_E[`rd]==IR_D[`rs]))|
                        (cali_e&(IR_D[`rs]==IR_E[`rt]))|
                               (lw_e&(IR_D[`rs]==IR_E[`rt]))|
                                (lw_m&(IR_D[`rs]==IR_M[`rt])));
assign stall_mult = mult_d&(start|busy);
assign STALL = stall_beq|stall_calr|stall_cali|stall_lw|stall_sw|stall_jr|stall_mult;
endmodule
