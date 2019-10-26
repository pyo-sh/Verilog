`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 16:20:15
// Design Name: 
// Module Name: ALU_8bits_Instance
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

module ALU_8bits_Instance(
    output wire [7:0] RESULT,
    input wire [1:0] OPERATION,
    input wire [7:0] OPERAND1,
    input wire [7:0] OPERAND2
);

wire [7:0] add_out, sub_out, mul_out, div_out;

Add_8bits inst1( .OUT(add_out), .IN1(OPERAND1), .IN2(OPERAND2) );
Sub_8bits inst2( .OUT(sub_out), .IN1(OPERAND1), .IN2(OPERAND2) );
Mul_8bits inst3( .OUT(mul_out), .IN1(OPERAND1), .IN2(OPERAND2) );
Div_8bits inst4( .OUT(div_out), .IN1(OPERAND1), .IN2(OPERAND2) );

Mux_4to1_8bits inst5 ( .IN1(add_out), .IN2(sub_out), .IN3(mul_out), .IN4(div_out), .SEL(OPERATION), .OUT(RESULT) );

endmodule