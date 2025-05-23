`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 21:18:22
// Design Name: 
// Module Name: PE_Generic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PE_Generic(
    input wire clk,
    input wire rst,
    input wire [15:0] input_A, // 16-bit complex number [7:0] real, [15:8] imaginary
    input wire [15:0] input_B,
    input wire [15:0] input_C,
    input wire [15:0] input_D,
    input wire M1_sel,        // Control signals for multiplexers (simplified to 1-bit)
    input wire M2_sel,
    input wire M3_sel,
    input wire M4_sel,
    input wire M5_sel,
    input wire [1:0] M6_sel,  // 2-bit for 4-to-1 mux
    input wire [1:0] M7_sel,  // 2-bit for 4-to-1 mux
    output wire [15:0] output_result
);

    // Internal signals
    wire [15:0] negA, conjB, conjC, negD;
    wire [15:0] M1_out, M2_out, M3_out, M4_out, M5_out, M6_out, M7_out;
    wire [15:0] reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out;
    wire [15:0] mul1_out, mul2_out, add1_out, add2_out, add3_out;
    
    // Instantiate negation modules
    negation_module neg_A (
        .input_data(input_A),
        .output_data(negA)
    );
    
    negation_module neg_D (
        .input_data(input_D),
        .output_data(negD)
    );
    
    // Instantiate conjugation modules
    conjugation_module conj_B (
        .input_data(input_B),
        .output_data(conjB)
    );
    
    conjugation_module conj_C (
        .input_data(input_C),
        .output_data(conjC)
    );
    
    // Instantiate multiplexers
    mux_2to1 M1 (
        .input_0(input_A),
        .input_1(negA),
        .select(M1_sel),
        .output_data(M1_out)
    );
    
    mux_2to1 M2 (
        .input_0(input_B),
        .input_1(conjB),
        .select(M2_sel),
        .output_data(M2_out)
    );
    
    mux_2to1 M3 (
        .input_0(input_C),
        .input_1(conjC),
        .select(M3_sel),
        .output_data(M3_out)
    );
    
    mux_2to1 M4 (
        .input_0(input_D),
        .input_1(negD),
        .select(M4_sel),
        .output_data(M4_out)
    );
    
    mux_2to1 M5 (
        .input_0(reg3_out),
        .input_1(reg5_out),
        .select(M5_sel),
        .output_data(M5_out)
    );
    
    mux_4to1 M6 (
        .input_0(reg4_out),
        .input_1(mul2_out),
        .input_2(mul1_out),
        .input_3(16'h0000),
        .select(M6_sel),
        .output_data(M6_out)
    );
    
    mux_4to1 M7 (
        .input_0(reg6_out),
        .input_1(add3_out),
        .input_2(mul1_out),
        .input_3(16'h0000),
        .select(M7_sel),
        .output_data(M7_out)
    );
    
    // Instantiate registers
    register_module reg1 (
        .clk(clk),
        .rst(rst),
        .input_data(M1_out),
        .output_data(reg1_out)
    );
    
    register_module reg2 (
        .clk(clk),
        .rst(rst),
        .input_data(M2_out),
        .output_data(reg2_out)
    );
    
    register_module reg3 (
        .clk(clk),
        .rst(rst),
        .input_data(M3_out),
        .output_data(reg3_out)
    );
    
    register_module reg4 (
        .clk(clk),
        .rst(rst),
        .input_data(M4_out),
        .output_data(reg4_out)
    );
    
    register_module reg5 (
        .clk(clk),
        .rst(rst),
        .input_data(add1_out),
        .output_data(reg5_out)
    );
    
    register_module reg6 (
        .clk(clk),
        .rst(rst),
        .input_data(add2_out),
        .output_data(reg6_out)
    );
    
    register_module reg7 (
        .clk(clk),
        .rst(rst),
        .input_data(M7_out),
        .output_data(reg7_out)
    );
    
    // Instantiate complex multipliers
    complex_multiplier mul1 (
        .a(reg1_out),
        .b(reg2_out),
        .result(mul1_out)
    );
    
    complex_multiplier mul2 (
        .a(M5_out),
        .b(reg4_out),
        .result(mul2_out)
    );
    
    // Instantiate complex adders
    complex_adder add1 (
        .a(mul1_out),
        .b(reg5_out),
        .result(add1_out)
    );
    
    complex_adder add2 (
        .a(M6_out),
        .b(reg6_out),
        .result(add2_out)
    );
    
    complex_adder add3 (
        .a(reg6_out),
        .b(reg5_out),
        .result(add3_out)
    );
    
    // Output assignment
    assign output_result = reg7_out;

endmodule
