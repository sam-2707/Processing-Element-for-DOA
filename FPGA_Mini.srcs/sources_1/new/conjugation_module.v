`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: conjugation_module
// Description: Performs complex conjugation (negates imaginary part)
//////////////////////////////////////////////////////////////////////////////////
module conjugation_module(
    input wire [15:0] input_data,
    output wire [15:0] output_data
);
    wire [7:0] real_part, imag_part;
    wire [7:0] neg_imag;
    
    // Extract real and imaginary parts
    assign real_part = input_data[7:0];
    assign imag_part = input_data[15:8];
    
    // Calculate the negative of imaginary part (2's complement)
    assign neg_imag = ~imag_part + 1'b1;
    
    // Combine real part and negated imaginary part
    assign output_data = {neg_imag, real_part};
    
endmodule