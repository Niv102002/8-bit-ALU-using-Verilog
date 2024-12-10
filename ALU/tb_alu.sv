`timescale 1ns/1ps
module alu_tb();
reg[7:0] A,B;
reg[2:0] ALU_Sel;
reg clk;
wire[7:0] ALU_Out;
wire CarryOut;
alu test_unit(A,B,ALU_Sel,ALU_Out,CarryOut,clk);
initial begin
A=8'H80;
B=8'H90;
ALU_Sel=3'b000;
clk=1'b1;
repeat (8) begin

for (ALU_Sel = 3'b000; ALU_Sel <= 3'b111; ALU_Sel = ALU_Sel + 1) begin
#10;
end
end
#10;
$finish;
end

always #5 clk = ~clk;

endmodule