`timescale 1ns / 1ps

module SimpleAlarmTb;
    reg    clk;
    reg    nrst;
    reg    enable;
    reg    [7:0] TIME_8B;
    wire    alarm;
    // SimpleAlarm 소환!
    SimpleAlarm inst1(
        .clk(clk),
        .nrst(nrst),
        .enable(enable),
        .TIME(TIME_8B),
        .Alarm(alarm)
    );
    
    // clock 주기는 40ns
    always  #20 begin
        clk =   ~clk;
    end
    
    initial begin
        // 초기값 정해주기
        clk =   1'b0;
        enable  =   1'b0;
        TIME_8B =   8'd0;
        nrst    =   1'b1;
        // 초기화 한번 해서 S0 state로 바꿈
        #40 nrst    =   1'b0;
        #40 nrst    =   1'b1;
        // 시간을 입력한다
        TIME_8B =   8'd10;
        // 입력된 시간에 대해 진행하도록 S1 state로 바꿈
        #40 enable  =   1'b1;
        #40 enable  =   1'b0;
    end
    
endmodule
