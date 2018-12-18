`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jasmine Tang, Andrey Akhmetov, Brian Hong
// 
// Create Date: 12/17/2018 11:43:58 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Demo for driving a VGA display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module VGA_demo(
    input clk,
    output vga_hsync,
    output vga_vsync,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output vga_locked
    );
    
    // Load screen memory
    //reg[7:0] screen_mem [4095:0];
    //initial $readmemh("screen_data.mem", screen_mem);
    
    wire vga_clk;
    vga_pll our_pll(
        .clk_in1(clk),
        .clk_out1(vga_clk),
        .reset(0),
        .locked(locked)
    );
    
    vga my_vga(
        .clk(vga_clk),
        .hsync(vga_hsync),
        .vsync(vga_vsync),
        .r(vga_r),
        .g(vga_g),
        .b(vga_b),
        .locked(vga_locked)
    );
endmodule
