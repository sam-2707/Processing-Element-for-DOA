`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 21:17:30
// Design Name: 
// Module Name: complex_adder
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


module complex_adder(
    input wire [15:0] a,
    input wire [15:0] b,
    output wire [15:0] result
);
    // For 16-bit complex numbers with 8-bit real and 8-bit imaginary parts
    // Add real parts and imaginary parts separately
    wire [7:0] real_sum, imag_sum;
    
    assign real_sum = a[7:0] + b[7:0];
    assign imag_sum = a[15:8] + b[15:8];
    
    // Combine the results
    assign result = {imag_sum, real_sum};
endmodule