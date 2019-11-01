`timescale 1ns / 1ps

module PknuBillboardTb;
    //input
    reg clk;
    reg nrst;
    reg enable;
    wire    [4:0]   LedOut;
    // PknuBillboard instance
    PknuBillboard inst1(
        .clk(clk),
        .nrst(nrst),
        .enable(enable),
        .LedOut(LedOut)
    );
    // clock generation
    always  #20 begin
        clk =   ~clk;
    end
    // testbench
    initial begin
        clk     =   1'b0;
        enable  =   1'b0;
        nrst    =   1'b1;
        
        #40 nrst    =   1'b0;
        #40 nrst    =   1'b1;
        
        #40 enable  =   1'b1;
        #40 enable  =   1'b0;
    end
endmodule
