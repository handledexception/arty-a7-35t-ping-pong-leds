`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Hindt
// 
// Create Date: 10/22/2022 08:22:27 PM
// Design Name:
// Module Name: clock_enable
// Project Name:
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Creates a clock enable signal to drive other logic.
// It is recommended by both Xilinx and Altera to use clock enable,
// which can help save FPGA clock resources and improve FPGA timing characteristics and timing analysis of the design. 
//////////////////////////////////////////////////////////////////////////////////
module clock_enable #(
    parameter slow_clk_freq=200)(
    input i_clk,
    output o_slow_clk);
    
    localparam slow_freq = (100000000 / slow_clk_freq) - 1;
    reg [26:0]counter = 0;
    always @(posedge i_clk)
        begin
            counter <= (counter >= slow_freq-1) ? 0 : counter+1;
        end
    assign o_slow_clk = (counter == slow_freq-1) ? 1'b1 : 1'b0;
endmodule
