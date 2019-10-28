`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 14:23:02
// Design Name: 
// Module Name: decoder_3_to_8
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


module decoder_3_to_8(
    input wire [2:0] X,
    output wire [7:0] Y
    );
    
assign  Y[0]   =   !X[2]   &   !X[1] &   !X[0];
assign  Y[1]   =   !X[2]   &   !X[1] &   X[0];
assign  Y[2]   =   !X[2]   &   X[1] &   !X[0];
assign  Y[3]   =   !X[2]   &   X[1] &   X[0];
assign  Y[4]   =   X[2]   &   !X[1] &   !X[0];
assign  Y[5]   =   X[2]   &   !X[1] &   X[0];
assign  Y[6]   =   X[2]   &   X[1] &   !X[0];
assign  Y[7]   =   X[2]   &   X[1] &   X[0];
    
endmodule
