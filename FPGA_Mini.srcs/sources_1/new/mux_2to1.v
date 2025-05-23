`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 21:16:03
// Design Name: 
// Module Name: mux_2to1
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


module mux_2to1(
    input wire [15:0] input_0,
    input wire [15:0] input_1,
    input wire select,
    output wire [15:0] output_data
);
    // Select between two inputs based on select signal
    assign output_data = select ? input_1 : input_0;
endmodule
