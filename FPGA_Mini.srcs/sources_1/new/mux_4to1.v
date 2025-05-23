`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 21:16:36
// Design Name: 
// Module Name: mux_4to1
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



module mux_4to1(
    input wire [15:0] input_0,
    input wire [15:0] input_1,
    input wire [15:0] input_2,
    input wire [15:0] input_3,
    input wire [1:0] select,
    output wire [15:0] output_data
);
    // Select between four inputs based on 2-bit select signal
    assign output_data = (select == 2'b00) ? input_0 :
                        (select == 2'b01) ? input_1 :
                        (select == 2'b10) ? input_2 : input_3;
endmodule