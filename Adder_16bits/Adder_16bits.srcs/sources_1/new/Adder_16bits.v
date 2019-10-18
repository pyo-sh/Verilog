`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/26 14:31:52
// Design Name: 
// Module Name: Adder_16bits
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


module Adder_16bits(
    input   wire [15:0] IN1,
    input   wire [15:0] IN2,
    output  wire [15:0] OUT
    );

assign OUT = IN1 + IN2;

endmodule
