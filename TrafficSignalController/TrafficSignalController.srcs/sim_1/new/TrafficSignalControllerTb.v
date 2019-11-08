`timescale 1ns / 1ps

module TrafficSignalControllerTb;
    // input
    reg    clk;
    reg    nrst;
    reg    enable;
    // output
    wire    [2:0]    traffic_light;
    wire    [1:0]    walk_light;
    
    TrafficSignalController inst1(
        .clk(clk),
        .nrst(nrst),
        .enable(enable),
        .traffic_light(traffic_light),
        .walk_light(walk_light)
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
