`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 15:53:44
// Design Name: 
// Module Name: Mux_2to1_8bits
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


module Mux_2to1_8bits(
    output reg [7:0] OUT,
    input wire [7:0] IN1,
    input wire [7:0] IN2,
    input wire SEL
);

always @(*) begin
    case(SEL)
        1:          OUT <= IN2;
        default:    OUT <= IN1;
    endcase
end

endmodule
