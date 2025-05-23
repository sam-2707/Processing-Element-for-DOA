`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 21:17:06
// Design Name: 
// Module Name: register_module
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


module register_module(
    input wire clk,
    input wire rst,
    input wire [15:0] input_data,
    output reg [15:0] output_data
);
    // Register with synchronous reset
    always @(posedge clk) begin
        if (rst) begin
            output_data <= 16'h0000;
        end else begin
            output_data <= input_data;
        end
    end
endmodule
