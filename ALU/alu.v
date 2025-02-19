module alu (
    input [7:0] A, B,          // 8-bit inputs
    output reg [7:0] ALU_Out,  // 8-bit output
    output reg CarryOut,       // Carry out flag
    input clk,                 // Clock input
    input reset                // Reset input
);

    reg [2:0] ALU_Sel;         // 3-bit operation select
    reg [8:0] ALU_Result;      // 9-bit result to handle carry

    always @(*) begin
        case (ALU_Sel)
            3'b000: ALU_Result = {1'b0, A} + {1'b0, B}; // Addition
            3'b001: ALU_Result = {1'b0, A} - {1'b0, B}; // Subtraction
            3'b010: ALU_Result = {1'b0, A & B};         // AND
            3'b011: ALU_Result = {1'b0, A | B};         // OR
            3'b100: ALU_Result = {1'b0, A ^ B};         // XOR
            3'b101: ALU_Result = {1'b0, ~(A ^ B)};      // XNOR
            3'b110: ALU_Result = {1'b0, ~(A & B)};      // NAND
            3'b111: ALU_Result = {1'b0, ~(A | B)};      // NOR
            default: ALU_Result = {1'b0, A};            // Default case
        endcase

        // Handle carry out for addition and subtraction
        if (ALU_Sel == 3'b000) begin
            CarryOut = ALU_Result[8]; // Carry out for addition
        end else if (ALU_Sel == 3'b001) begin
            CarryOut = (A < B) ? 1'b1 : 1'b0; // Borrow for subtraction
        end else begin
            CarryOut = 1'b0; // No carry for logical operations
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALU_Sel <= 3'b000; // Reset ALU_Sel to 000
        end else begin
            // Increment ALU_Sel from 000 to 111 and reset to 000 after 111
            if (ALU_Sel == 3'b111) begin
                ALU_Sel <= 3'b000; // Reset to 000 after 111
            end else begin
                ALU_Sel <= ALU_Sel + 1; // Increment ALU_Sel
            end
        end

        // Update ALU_Out with the result
        ALU_Out <= ALU_Result[7:0];
    end

endmodule