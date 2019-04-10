`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 02:26:42 PM
// Design Name: 
// Module Name: sine
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


module sine(
    input [5:0] s_in,
    output reg [3:0] s_out
    );
    
//        reg [4:0] sine[3:0];
//        assign s_out = sine[s_in];
        always @ (s_in)
            case (s_in)
                0: s_out = 4'h8;
                1: s_out = 4'h8;
                2: s_out = 4'h9;
                3: s_out = 4'ha;
                4: s_out = 4'hb;
                5: s_out = 4'hb;
                6: s_out = 4'hc;
                7: s_out = 4'hd;
                8: s_out = 4'hd;
                9: s_out = 4'he;
                10: s_out = 4'he;
                11: s_out = 4'hf;
                12: s_out = 4'hf;
                13: s_out = 4'hf;
                14: s_out = 4'hf;
                15: s_out = 4'hf;
                16: s_out = 4'hf;
                17: s_out = 4'hf;
                18: s_out = 4'hf;
                19: s_out = 4'hf;
                20: s_out = 4'hf;
                21: s_out = 4'hf;
                22: s_out = 4'he;
                23: s_out = 4'he;
                24: s_out = 4'hd;
                25: s_out = 4'hd;
                26: s_out = 4'hc;
                27: s_out = 4'hb;
                28: s_out = 4'hb;
                29: s_out = 4'ha;
                30: s_out = 4'h9;
                31: s_out = 4'h8;
                32: s_out = 4'h8;
                33: s_out = 4'h7;
                34: s_out = 4'h6;
                35: s_out = 4'h5;
                36: s_out = 4'h4;
                37: s_out = 4'h4;
                38: s_out = 4'h3;
                39: s_out = 4'h2;
                40: s_out = 4'h2;
                41: s_out = 4'h1;
                42: s_out = 4'h1;
                43: s_out = 4'h1;
                44: s_out = 4'h0;
                45: s_out = 4'h0;
                46: s_out = 4'h0;
                47: s_out = 4'h0;
                48: s_out = 4'h0;
                49: s_out = 4'h0;
                50: s_out = 4'h0;
                51: s_out = 4'h0;
                52: s_out = 4'h0;
                53: s_out = 4'h1;
                54: s_out = 4'h1;
                55: s_out = 4'h1;
                56: s_out = 4'h2;
                57: s_out = 4'h2;
                58: s_out = 4'h3;
                59: s_out = 4'h4;
                60: s_out = 4'h4;
                61: s_out = 4'h5;
                62: s_out = 4'h6;
                63: s_out = 4'h7;
        endcase
endmodule
