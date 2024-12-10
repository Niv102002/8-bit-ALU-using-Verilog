module alu
( input [7:0] A,B,
input [2:0] ALU_Sel,
output [7:0] ALU_Out,
output CarryOut,
input clk
//input reset,
//output

);
reg[8:0] ALU_Result;
reg[8:0] temp;
reg[7:0] b_c;
reg[8:0] sub_r;
reg[2:0] count;
assign ALU_Out=ALU_Result[8:0];
assign CarryOut = temp[8];

always @(*) begin
case(ALU_Sel)
3'b000:
ALU_Result={1'b0,A}+{1'b0,B}; // Addition
3'b001:
ALU_Result={1'b0, A} - {1'b0,B}; // Subtraction
3'b010:
ALU_Result=A&B; // AND
3'b011:
ALU_Result=A|B; // OR
3'b100:
ALU_Result=A^B; // XOR
3'b101:
ALU_Result=A^~B; //XNOR
3'b110:
ALU_Result=~(A&B); //nand

14

3'b111:
ALU_Result=~(A|B); //nor
//default: ALU_Result=A+B;
endcase

//Addition Carry
if (ALU_Sel==3'b000 && ALU_Result[8] == 1)
temp[8] = 1'h1;
else
temp[8] = 1'h0;
//subtraction borrow
if (ALU_Sel==3'b001 && A>B)
begin
//b_c=~B+1;
//sub_r={1'b0,A}+{1'b0,b_c};
temp[8] = 1'h0;
end

else if (ALU_Sel == 3'b001 && A < B)

begin
b_c=~B+1;
sub_r={1'b0,A}+{1'b0,b_c};

temp[8] = 1'h1;
end

end
always @(posedge clk) begin
count<=ALU_Sel;

//count <= 0;

count <= count + 1;

end

endmodule