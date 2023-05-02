`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Hindt
// 
// Create Date: 10/22/2022 10:15:08 PM
// Design Name: 
// Module Name: debouncer
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
// D-flip-flop with clock enable signal for debouncing module 
module d_flip_flop(
    input i_clk,
    input i_slow_clk,
    input D,
    output reg Q=0
);
    always @ (negedge i_clk)
        begin
            if(i_slow_clk == 1) 
                Q <= D;
        end
endmodule

module debouncer(
    input i_clk,
    input i_sig,
    output o_sig
    );

    wire slow_clk;
    wire Q1, Q2, Q2_bar, Q0;

    clock_enable u1(.i_clk(i_clk), .o_slow_clk(slow_clk));

    d_flip_flop d0(i_clk, slow_clk, i_sig, Q0);
    d_flip_flop d1(i_clk, slow_clk, Q0, Q1);
    d_flip_flop d2(i_clk, slow_clk, Q1, Q2);

    assign Q2_bar = ~Q2;
    assign o_sig = Q1 & Q2_bar;
endmodule
