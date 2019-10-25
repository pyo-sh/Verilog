`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 15:37:07
// Design Name: 
// Module Name: Comparator_8bits
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


module Comparator_8bits(
    output reg [1:0] OUT,
    input wire [7:0] IN1,
    input wire [7:0] IN2
);

always @(*) begin
    if(IN1 > IN2)       OUT <= 3'd1;
    else if(IN1==IN2)   OUT <= 3'd0;
    else                OUT <= 3'd2;
end    

endmodule
