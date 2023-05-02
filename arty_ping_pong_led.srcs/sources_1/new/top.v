`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Hindt
// 
// Create Date: 04/26/2023 12:15:51 AM
// Design Name:
// Module Name: top
// Project Name: Ping-Pong LEDS
// Target Devices: Digilent Arty A7-35T
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

module top(
    input clk,
    input [3:0] btn,
    input [3:0] sw,
    output [3:0] led
    );

    wire rst, add, sub, mul, div;
    wire [4:0] op_sel;
    assign op_sel = { rst, add, sub, mul, div };    
    debouncer db_btn_add(.i_clk(clk), .i_sig(btn[3]), .o_sig(add));
    debouncer db_btn_sub(.i_clk(clk), .i_sig(btn[2]), .o_sig(sub));
    debouncer db_btn_mul(.i_clk(clk), .i_sig(btn[1]), .o_sig(mul));
    debouncer db_btn_div(.i_clk(clk), .i_sig(btn[0]), .o_sig(div));
    toggler tog_rst(.i_clk(clk), .i_sig(btn[1] && btn[0]), .o_sig(rst));

    ping_ponger #(.freq(7)) pp_leds(.i_clk(clk), .o_led(led));
endmodule
