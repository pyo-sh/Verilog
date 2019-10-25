`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 14:35:10
// Design Name: 
// Module Name: Comparator_3bits
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


module Comparator_3bits(
    input wire [2:0] IN,
    output reg OUT,
    reg [1:0]   TEMP
);
    
always @(*) begin
    TEMP[0] = IN[0] && IN[1] && IN[2];
    TEMP[1] = IN[0] || IN[1] || IN[2];
    OUT = TEMP[0] || !TEMP[1];
end
    
endmodule
