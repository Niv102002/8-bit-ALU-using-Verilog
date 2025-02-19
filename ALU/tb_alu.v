`timescale 1ns / 1ps

module tb_alu;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg clk;
    reg reset;

    // Outputs
    wire [7:0] ALU_Out;
    wire CarryOut;

    // Instantiate the ALU module
    alu uut (
        .A(A),
        .B(B),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut),
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        A = 8'b00000000;
        B = 8'b00000000;
        reset = 1;

        // Apply reset
        #10;
        reset = 0;

        // Test case 1: Addition (ALU_Sel = 000)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 000 (Addition): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 2: Subtraction (ALU_Sel = 001)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 001 (Subtraction): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 3: AND (ALU_Sel = 010)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 010 (AND): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 4: OR (ALU_Sel = 011)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 011 (OR): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 5: XOR (ALU_Sel = 100)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 100 (XOR): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 6: XNOR (ALU_Sel = 101)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 101 (XNOR): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 7: NAND (ALU_Sel = 110)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 110 (NAND): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test case 8: NOR (ALU_Sel = 111)
        A = 8'b00001111; // 15
        B = 8'b00000011; // 3
        #10; // Wait for one clock cycle
        $display("ALU_Sel = 111 (NOR): A = %b, B = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Out, CarryOut);

        // Test reset functionality
        reset = 1;
        #10;
        reset = 0;
        $display("Reset Test: ALU_Sel = %b (should be 000)", uut.ALU_Sel);

        // End simulation
        $stop;
    end

endmodule