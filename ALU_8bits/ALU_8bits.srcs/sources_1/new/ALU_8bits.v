`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/10 15:01:38
// Design Name: 
// Module Name: ALU_8bits
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


module ALU_8bits(
    output reg [7:0] RESULT,
    input wire [2:0] OPERATION,
    input wire [7:0] OPERAND1,
    input wire [7:0] OPERAND2
);
    
always @(*) begin
    case(OPERATION)
        3'd0:   begin
            RESULT <= OPERAND1 & OPERAND2;      // AND
        end
        3'd1:   RESULT <= OPERAND1 | OPERAND2;  // OR
        3'd2:   RESULT <= OPERAND1 ^ OPERAND2;  // XOR
        3'd3:   RESULT <= ~OPERAND1;            // NOT
        3'd4:   RESULT <= OPERAND1 << OPERAND2; // LSH
        3'd5:   RESULT <= OPERAND1 >> OPERAND2; // RSH
        default:    RESULT <= 8'B0;
    endcase
end    
    
endmodule
