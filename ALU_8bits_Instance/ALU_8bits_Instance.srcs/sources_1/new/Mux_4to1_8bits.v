`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 16:28:17
// Design Name: 
// Module Name: Mux_4to1_8bits
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


module Mux_4to1_8bits(
    input wire [7:0] IN1,
    input wire [7:0] IN2,
    input wire [7:0] IN3,
    input wire [7:0] IN4,
    input wire [1:0] SEL,
    output reg [7:0] OUT
    );
    
    always @(*) begin
        case(SEL)
            2'd0:   OUT <= IN1;
            2'd1:   OUT <= IN2;
            2'd2:   OUT <= IN3;
            2'd3:   OUT <= IN4;
        endcase
    end
    
endmodule
