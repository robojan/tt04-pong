`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2023 08:40:03 PM
// Design Name: 
// Module Name: pynq_top_wrapper
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


module pynq_top_wrapper(
    input sysclk,
    input [3:0] btn,
    input [1:0] sw,
    output [7:0] ja,
    output hblank,
    output vblank,
    output sound
    );
        
    wire clk_vga;
    wire pll_locked;    
    clk_pll pll(
        .clk_in1(sysclk),
        .resetn(1'b1),
        .clk_out1(clk_vga),
        .locked(pll_locked)
    );
    
    wire nSysRst;
    assign nSysRst = sw[1];
    
    pong pong(
        .clk(clk_vga),
        .nRst(nSysRst),
        .en(1'b1),
        .btn_p1_left_pin(btn[1]),
        .btn_p1_right_pin(btn[0]),
        .btn_p1_select_pin(sw[0]),
        .btn_p2_left_pin(btn[2]),
        .btn_p2_right_pin(btn[3]),
        .btn_p2_select_pin(sw[0]),
        .vga_r(ja[1:0]),
        .vga_g(ja[3:2]),
        .vga_b(ja[5:4]),
        .vga_hsync(ja[6]),
        .vga_vsync(ja[7]),
        .hblank(hblank),
        .vblank(vblank),
        .sound_out(sound)
    );
    
    
    
endmodule
