`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench: PE_Generic_tb (improved with clear verification)
//////////////////////////////////////////////////////////////////////////////////
module PE_Generic_tb;
    parameter CLK_PERIOD = 10; // 10ns clock period
    // Inputs
    reg clk;
    reg rst;
    reg [15:0] input_A, input_B, input_C, input_D;
    reg M1_sel, M2_sel, M3_sel, M4_sel, M5_sel;
    reg [1:0] M6_sel, M7_sel;
    // Output
    wire [15:0] output_result;
    
    // For debugging
    wire [7:0] real_part, imag_part;
    assign real_part = output_result[7:0];
    assign imag_part = output_result[15:8];
    
    // Instantiate the Unit Under Test (UUT)
    PE_Generic uut (
        .clk(clk),
        .rst(rst),
        .input_A(input_A),
        .input_B(input_B),
        .input_C(input_C),
        .input_D(input_D),
        .M1_sel(M1_sel),
        .M2_sel(M2_sel),
        .M3_sel(M3_sel),
        .M4_sel(M4_sel),
        .M5_sel(M5_sel),
        .M6_sel(M6_sel),
        .M7_sel(M7_sel),
        .output_result(output_result)
    );
    
    // Clock Generation
    always begin
        clk = 0;
        #(CLK_PERIOD/2);
        clk = 1;
        #(CLK_PERIOD/2);
    end
    
    initial begin
        // Initialize Inputs
        rst = 1;
        input_A = 0;
        input_B = 0;
        input_C = 0;
        input_D = 0;
        M1_sel = 0;
        M2_sel = 0;
        M3_sel = 0;
        M4_sel = 0;
        M5_sel = 0;
        M6_sel = 2'b00;
        M7_sel = 2'b00;
        #20;
        rst = 0;
        
        // Test Case
        input_A = 16'h0301;
        input_B = 16'h0301;
        input_C = 16'h0000; // real=1, imag=2 (with [7:0]=real, [15:8]=imag)
        input_D = 16'h0000; // real=1, imag=2
        M1_sel=0;
        M2_sel=1;
        M3_sel = 1; // conj(C)
        M4_sel = 0; // D as is
        M5_sel = 1; // use reg3_out = conj(C)
        M6_sel = 2'b01; // force 0 into add3 input
        M7_sel = 2'b00; // output reg6 = add3_out
        
        #10; // Wait one cycle
        
        #90; // Wait for pipeline
        $display("Output = %d + j%d (hex: %h)", real_part, $signed(imag_part), output_result);
        
       
        
        #50;
        $finish;
    end
endmodule