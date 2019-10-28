`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 14:34:46
// Design Name: 
// Module Name: encoder_8_to_3
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


module encoder_8_to_3(
    input wire [7:0] D,
    output wire [2:0] B,
    );
    
assign B[2] = D[4] | D[5] | D[6] | D[7];
assign B[1] = D[2] | D[3] | D[6] | D[7];
assign B[0] = D[1] | D[3] | D[5] | D[7];

endmodule
