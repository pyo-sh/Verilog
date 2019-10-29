`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/17 15:25:14
// Design Name: 
// Module Name: D_FlipFlop
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


module D_FlipFlop(
    input wire D,
    input wire CP,
    output reg Q,
    output wire Qi,
    input wire NRST
    );
    
assign  Qi = !Q;

always @(posedge CP or negedge NRST) begin
    case(NRST)
        1'b0:   Q <= 0;
        1'b1:   Q <= D;
    endcase
end

endmodule
