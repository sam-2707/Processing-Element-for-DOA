`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: complex_multiplier
// Description: Improved complex multiplier with proper sign handling and overflow protection
//////////////////////////////////////////////////////////////////////////////////
module complex_multiplier(
    input wire [15:0] a,
    input wire [15:0] b,
    output wire [15:0] result
);
    // For 16-bit complex numbers with 8-bit real and 8-bit imaginary parts
    wire signed [7:0] a_real, a_imag, b_real, b_imag;
    wire signed [15:0] mul_real_real, mul_imag_imag, mul_real_imag, mul_imag_real;
    wire signed [15:0] real_part, imag_part;
    wire signed [7:0] real_part_truncated, imag_part_truncated;
    
    // Extract real and imaginary parts with explicit signed handling
    assign a_real = a[7:0];
    assign a_imag = a[15:8];
    assign b_real = b[7:0];
    assign b_imag = b[15:8];
    
    // Complex multiplication: (a_real + j*a_imag) * (b_real + j*b_imag)
    // = (a_real*b_real - a_imag*b_imag) + j*(a_real*b_imag + a_imag*b_real)
    assign mul_real_real = a_real * b_real;
    assign mul_imag_imag = a_imag * b_imag;
    assign mul_real_imag = a_real * b_imag;
    assign mul_imag_real = a_imag * b_real;
    
    assign real_part = mul_real_real - mul_imag_imag;
    assign imag_part = mul_real_imag + mul_imag_real;
    
    // Saturate results to prevent overflow
    assign real_part_truncated = (real_part > 127) ? 8'd127 :
                                 (real_part < -128) ? -8'd128 :
                                 real_part[7:0];
                                 
    assign imag_part_truncated = (imag_part > 127) ? 8'd127 :
                                (imag_part < -128) ? -8'd128 :
                                imag_part[7:0];
    
    // Combine the results
    assign result = {imag_part_truncated, real_part_truncated};
endmodule