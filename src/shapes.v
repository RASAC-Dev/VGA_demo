`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brian Hong
// 
// Create Date: 04/09/2019 07:50:34 PM
// Design Name: 
// Module Name: shapes
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


module shapes(
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    input wire [9:0] x,
    input wire [8:0] y,
    input wire clk
    );
    
    reg [11:0] sq_a;
    reg [11:0] sq_b;
    initial sq_a = 12'hf00;
    initial sq_b = 12'h0ff;
    
    reg [9:0] a_xi;
    reg [9:0] a_yi;
    reg [9:0] a_xj;
    reg [9:0] a_yj;
    initial a_xi = 100;
    initial a_yi = 200;
    initial a_xj = 200;
    initial a_yj = 300;
    
    reg x_dir, y_dir;
    initial x_dir = 0;
    initial y_dir = 0;
    
    wire [3:0] s_out;
    reg [7:0] count;
    sine wave(count >> 2, s_out);
    
    always @ (posedge clk) begin

        count <= count + 1;
        
        sq_a <= 12'hfff & {s_out,s_out,s_out};
        
        if ((x_dir && a_xj > 600) || (~x_dir && a_xi < 50)) begin
            x_dir <= ~x_dir;
        end
        
        if ((y_dir && a_yj > 400) || (~y_dir && a_yi < 50)) begin
            y_dir <= ~y_dir;
        end
        
        a_xi <= x_dir ? a_xi + 1 : a_xi - 1;
        a_xj <= x_dir ? a_xj + 1 : a_xj - 1;
        a_yi <= y_dir ? a_yi + 1 : a_yi - 1;
        a_yj <= y_dir ? a_yj + 1 : a_yj - 1;
        
    end
    
    assign r = ((x > a_xi) && (x < a_xj) && (y > a_yi) && (y < a_yj)) ? sq_a[11:8] : 0;
    assign g = (((x > a_xi) && (x < a_xj) && (y > a_yi) && (y < a_yj)) ? sq_a[7:4] : 0) | (((x > 150) && (x < 250) && (y > 250) && (y < 350)) ? sq_b[7:4] : 0);
    assign b = ((x > a_xi) && (x < a_xj) && (y > a_yi) && (y < a_yj)) ? sq_a[3:0] : 0;
    
endmodule
