`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Paul Hindt
// 
// Create Date: 04/26/2023 01:44:28 PM
// Design Name: 
// Module Name: toggler
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

module toggler(
    input i_clk,
    input i_sig,
    output o_sig
    );
    
    wire db_sig_inp;
    reg r_sig_inv = 1'b0;
    reg r_db_sig_inp = 1'b0;
 
    debouncer db(
        .i_clk(i_clk),
        .i_sig(i_sig),
        .o_sig(db_sig_inp)
    );

    always @(posedge i_clk)
        begin
            r_db_sig_inp <= db_sig_inp; // create a register
            if (db_sig_inp == 1'b0 && r_db_sig_inp == 1'b1) // falling edge
                begin
                    r_sig_inv <= ~r_sig_inv;
                end
        end
    
    assign o_sig = r_sig_inv;
endmodule

