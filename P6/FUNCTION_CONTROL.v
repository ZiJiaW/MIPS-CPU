`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:51 11/21/2016 
// Design Name: 
// Module Name:    FUNCTION_CONTROL 
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
module FUNCTION_CONTROL(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
    input [31:0] IR_W,
    output JOP,
    output [5:0]branch,
    output [1:0] ExtSrc,
    output reg[3:0] ALUOp,
    output ALU_BSel,
     output [1:0]AO_Sel,
    output MemWrite,
    output [1:0]RF_A3Sel,
    output [1:0]RF_WDSel,
    output RegWrite,
     output start_mult,
     output we_hi,
     output we_lo,
     output [1:0] md_op
    );
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
assign JOP = IR_D[31:26]==`j|
             IR_D[31:26]==`jal|
                 (IR_D[31:26]==`calr&IR_D[5:0]==`funct_jr)|
                 (IR_D[31:26]==`calr&IR_D[5:0]==`funct_jalr);// j jal jr jalr
assign branch[0] = IR_D[31:26]== `beq;//  beq
assign branch[1] = IR_D[31:26]== `bne;//  bne
assign branch[2] = IR_D[31:26]== `blez;
assign branch[3] = IR_D[31:26]== `bgtz;
assign branch[4] = IR_D[31:26]== (`bltz_bgez)&(IR_D[16]==0);//bltz
assign branch[5] = IR_D[31:26]== (`bltz_bgez)&(IR_D[16]==1);//bgez
assign ExtSrc = IR_D[31:26]==`ori?2'b01:
                IR_D[31:26]==`xori?2'b01:
                     IR_D[31:26]==`andi?2'b01:// zero ext
                IR_D[31:26]==`lui?2'b10:2'b00; // lui and signed ext
always @(*)begin
    case(IR_E[31:26])
         `calr: ALUOp = IR_E[5:0]==`addu?4'b0000:
                              IR_E[5:0]==`funct_add?4'b0000:
                              IR_E[5:0]==`subu?4'b0001:
                              IR_E[5:0]==`funct_sub?4'b0001:
                              IR_E[5:0]==`funct_or?4'b0010:
                              IR_E[5:0]==`funct_and?4'b0011:
                              IR_E[5:0]==`funct_xor?4'b0100:
                              IR_E[5:0]==`funct_sll?4'b0101:
                              IR_E[5:0]==`funct_srl?4'b0110:
                              IR_E[5:0]==`funct_nor?4'b1011:
                              IR_E[5:0]==`funct_slt?4'b1100:
                              IR_E[5:0]==`funct_sltu?4'b1101:
                              IR_E[5:0]==`funct_sra?4'b0111:
                              IR_E[5:0]==`funct_sllv?4'b1000:
                              IR_E[5:0]==`funct_srlv?4'b1001:
                              IR_E[5:0]==`funct_srav?4'b1010:0;
          `ori: ALUOp = 4'b0010;
          `addi:ALUOp = 4'b0000;
          `addiu:ALUOp = 4'b0000;
          `lui:ALUOp = 4'b0000;
          `andi:ALUOp = 4'b0011;
          `xori:ALUOp = 4'b0100;
          `slti:ALUOp = 4'b1100;
          `sltiu:ALUOp = 4'b1101;
          default: ALUOp = 0;
     endcase
end
assign ALU_BSel = IR_E[31:26]==`ori?1:
                  IR_E[31:26]==`lui?1:
                        IR_E[31:26]==`lw?1:
                        IR_E[31:26]==`sw?1:
                        IR_E[31:26]==`addi?1:
                        IR_E[31:26]==`addiu?1:
                        IR_E[31:26]==`andi?1:
                        IR_E[31:26]==`xori?1:
                        IR_E[31:26]==`slti?1:
                        IR_E[31:26]==`sltiu?1:
                        IR_E[31:26]==`lb?1:
                        IR_E[31:26]==`lbu?1:
                        IR_E[31:26]==`lh?1:
                        IR_E[31:26]==`lhu?1:
                        IR_E[31:26]==`sb?1:
                        IR_E[31:26]==`sh?1:0;       // cali or st or ld
assign we_hi = IR_E[31:26]==`calr&IR_E[5:0]==`funct_mthi;
assign we_lo = IR_E[31:26]==`calr&IR_E[5:0]==`funct_mtlo;
assign start_mult = (IR_E[31:26]==`calr&IR_E[5:0]==`funct_mult)|
                    (IR_E[31:26]==`calr&IR_E[5:0]==`funct_div)|
                          (IR_E[31:26]==`calr&IR_E[5:0]==`funct_multu)|
                          (IR_E[31:26]==`calr&IR_E[5:0]==`funct_divu);
assign AO_Sel= IR_E[31:26]==`calr&IR_E[5:0]==`funct_mfhi?1:
               IR_E[31:26]==`calr&IR_E[5:0]==`funct_mflo?2:0; //  aluout select
assign md_op = IR_E[31:26]==`calr&IR_E[5:0]==`funct_multu?0:
               IR_E[31:26]==`calr&IR_E[5:0]==`funct_mult?1:
                    IR_E[31:26]==`calr&IR_E[5:0]==`funct_divu?2:
                    IR_E[31:26]==`calr&IR_E[5:0]==`funct_div?3:0;
assign MemWrite = IR_M[31:26]==`sw|IR_M[31:26]==`sh|IR_M[31:26]==`sb;   //store
assign RF_A3Sel = IR_W[31:26]==`ori?2'b01:
                  IR_W[31:26]==`lui?2'b01:
                        IR_W[31:26]==`lw?2'b01:
                        IR_W[31:26]==`addi?2'b01:
                        IR_W[31:26]==`addiu?2'b01:
                        IR_W[31:26]==`andi?2'b01:
                        IR_W[31:26]==`xori?2'b01:
                        IR_W[31:26]==`slti?2'b01:
                        IR_W[31:26]==`sltiu?2'b01:
                        IR_W[31:26]==`lb?2'b01:
                        IR_W[31:26]==`lbu?2'b01:
                        IR_W[31:26]==`lh?2'b01:
                        IR_W[31:26]==`lhu?2'b01:
                        IR_W[31:26]==`jal?2'b10:2'b00;   // RT 01   31 10  RD 00
assign RegWrite = IR_W[31:26]==`j?0:
                  IR_W[31:26]==`sw?0:
                        IR_W[31:26]==`beq?0:
                        IR_W[31:26]==`bne?0:
                        IR_W[31:0]==`nop?0:
                        IR_W[31:26]==`sb?0:
                        IR_W[31:26]==`sh?0:
                        IR_W[31:26]==`blez?0:
                        IR_W[31:26]==`bgtz?0:
                        IR_W[31:26]==`bltz_bgez?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_jr)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_mult)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_multu)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_div)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_divu)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_mthi)?0:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_mtlo)?0:1;
                        
assign RF_WDSel = IR_W[31:26]==`lw?1:
                  IR_W[31:26]==`lb?1:
                        IR_W[31:26]==`lh?1:
                        IR_W[31:26]==`lbu?1:
                        IR_W[31:26]==`lhu?1:
                  IR_W[31:26]==`jal?2:
                        (IR_W[31:26]==`calr&IR_W[5:0]==`funct_jalr)?2:0;//1: dm // 2 pc8 // 0 aluout
endmodule
