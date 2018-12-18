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

module vga(
    input clk,
    output reg hsync,
    output reg vsync,
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b,
    output locked
    );
    
    // This should be passed in
    // Load screen memory
    reg[7:0] screen_mem [4095:0];
    initial $readmemh("screen_data.mem", screen_mem);
    
    // Load font data to mem
    reg[7:0] font_lut [4095:0];
    initial $readmemb("font_data.mem", font_lut);
    
    localparam ST_READ = 0;
    localparam ST_FONTLOOKUP = 1;
    localparam ST_FONTMUX = 2;
    localparam ST_OUT = 3;
                
    reg[1:0] state = ST_READ;
    
    reg [9:0] px = 0;
    reg [9:0] py = 0;

    reg[7:0] char;
    reg[7:0] fontrow;
    reg pending_pix;
    
    wire[11:0] addr;
    wire[11:0] fontaddr;
                
    // discard 4 bits of py (16 rows per char) and 3 bits of px (8 cols per char)
    assign addr = {py[8:4], px[9:3]};
    assign fontaddr = {char, py[3:0]};
            
    always @ (posedge clk) begin
        case(state)
            ST_READ: begin
                if(px < 640 && py < 480) begin
                    char <= screen_mem[addr];
                end
                state <= ST_FONTLOOKUP;
            end
            ST_FONTLOOKUP: begin
                fontrow <= font_lut[fontaddr];
                state <= ST_FONTMUX; 
            end
            ST_FONTMUX: begin
                pending_pix <= fontrow[px[2:0]];
                state <= ST_OUT; 
            end
            ST_OUT: begin
                hsync <= ~(px >= (640 + 16) && px < (640 + 16 + 96));
                vsync <= ~(py >= (480 + 10) && py < (480 + 10 + 2));
                if(px < 640 && py < 480 && pending_pix) begin
                    r <= 4'hf;
                    g <= 4'hf;
                    b <= 4'hf;
                end
                else begin
                    r <= 0;
                    g <= 0;
                    b <= 0;
                end
                if(px >= (640+16+96+48-1)) begin
                    px <= 0;
                    if(py >= (480+10+2+33-1)) begin
                        py <= 0;
                    end
                    else begin
                        py <= py + 1;
                    end
                end 
                else begin
                    px <= px + 1;
                end
            state <= ST_READ;
        end
        default:
            state <= ST_READ;
        endcase
    end
endmodule

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
