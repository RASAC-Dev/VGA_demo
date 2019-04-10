`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jasmine Tang, Andrey Akhmetov, Brian Hong
// 
// Create Date: 12/18/2018 01:07:35 AM
// Design Name: 
// Module Name: vga
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

module vga(
    input clk,
    output reg hsync,
    output reg vsync,
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b,
    output wire [9:0] x,
    output wire [9:0] y,
    output locked
    );
    
    // 640x480 timing
    localparam HS_DATA = 640;
    localparam HS_BLANK = 16;
    localparam HS_PULSE = 96;
    localparam HS_SECBLNK = 48;
    localparam VS_DATA = 480;
    localparam VS_BLANK = 10;
    localparam VS_PULSE = 20;
    localparam VS_SECBLNK = 33;
    
    reg [9:0] px;
    reg [9:0] py;
    assign x = px;
    assign y = py;
    
    wire [3:0] i_r;
    wire [3:0] i_g;
    wire [3:0] i_b;
    shapes screen(i_r, i_g, i_b, x, y, vsync);
    
    always @ (posedge clk) begin
        hsync <= ~(px >= (HS_DATA + HS_BLANK) && px < (HS_DATA + HS_BLANK + HS_PULSE));
        vsync <= ~(py >= (VS_DATA + VS_BLANK) && py < (VS_DATA + VS_BLANK + VS_PULSE));
        if(px < HS_DATA && py < VS_DATA) begin
            r <= i_r;
            g <= i_g;
            b <= i_b;
        end
        else begin
            r <= 0;
            g <= 0;
            b <= 0;
        end
        
        if(px >= (HS_DATA + HS_BLANK + HS_PULSE + HS_SECBLNK-1)) begin
            px <= 0;
            if(py >= (VS_DATA + VS_BLANK + VS_PULSE + HS_SECBLNK-1)) begin
                py <= 0;
            end
            else begin
                py <= py + 1;
            end
        end
        else begin
            px <= px + 1;
        end
    end
endmodule