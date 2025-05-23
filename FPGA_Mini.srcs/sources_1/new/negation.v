`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: negation_module
// Description: Negates both real and imaginary parts of a complex number
//////////////////////////////////////////////////////////////////////////////////
module negation_module(
    input wire [15:0] input_data,
    output wire [15:0] output_data
);
    wire [7:0] real_part, imag_part;
    wire [7:0] neg_real, neg_imag;
    
    // Extract real and imaginary parts
    assign real_part = input_data[7:0];
    assign imag_part = input_data[15:8];
    
    // Calculate the negative values (2's complement)
    assign neg_real = ~real_part + 1'b1;
    assign neg_imag = ~imag_part + 1'b1;
    
    // Combine negated parts
    assign output_data = {neg_imag, neg_real};
    
endmodule