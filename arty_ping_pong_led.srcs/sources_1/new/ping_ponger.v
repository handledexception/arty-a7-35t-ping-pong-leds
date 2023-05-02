`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 10:15:43 PM
// Design Name: 
// Module Name: ping_ponger
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

module ping_ponger #(
    parameter freq=5)(
    input i_clk,
    output [3:0] o_led
    );

    reg[3:0] led_states;
    integer leds_cnt = 0;
    reg leds_dir = 1'b0;
    initial begin
        leds_cnt = 0;
        leds_dir = 0;
        led_states = 4'b0000;
    end

    wire leds_clk;
    clock_enable #(freq) leds_clk_en(.i_clk(i_clk), .o_slow_clk(leds_clk));

    always @(posedge leds_clk)
        begin
            if (leds_cnt >= 3) begin
                leds_cnt = 0;
                leds_dir = ~leds_dir;
            end 
            if (leds_cnt == 0) begin
                if (leds_dir == 1'b0)
                    led_states = 4'b0001;
                else if (leds_dir == 1'b1) begin
                    led_states = 4'b1000;
                end
            end else if (leds_cnt == 1) begin
                if (leds_dir == 1'b0)
                    led_states = 4'b0010;
                else if (leds_dir == 1'b1) begin
                    led_states = 4'b0100;
                end
            end else if (leds_cnt == 2) begin
                if (leds_dir == 1'b0)
                    led_states = 4'b0100;
                else if (leds_dir == 1'b1) begin
                    led_states = 4'b0010;
                end
            end else if (leds_cnt == 3) begin
                if (leds_dir == 1'b0)
                    led_states = 4'b1000;
                else if (leds_dir == 1'b1) begin
                    led_states = 4'b0001;
                end
            end
            leds_cnt = leds_cnt + 1;
        end
    assign o_led = led_states[3:0];
endmodule
