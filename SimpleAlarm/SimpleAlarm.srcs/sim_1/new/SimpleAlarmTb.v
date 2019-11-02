`timescale 1ns / 1ps

module SimpleAlarmTb;
    reg    clk;
    reg    nrst;
    reg    enable;
    reg    [7:0] TIME_8B;
    wire    alarm;
    // SimpleAlarm ��ȯ!
    SimpleAlarm inst1(
        .clk(clk),
        .nrst(nrst),
        .enable(enable),
        .TIME(TIME_8B),
        .Alarm(alarm)
    );
    
    // clock �ֱ�� 40ns
    always  #20 begin
        clk =   ~clk;
    end
    
    initial begin
        // �ʱⰪ �����ֱ�
        clk =   1'b0;
        enable  =   1'b0;
        TIME_8B =   8'd0;
        nrst    =   1'b1;
        // �ʱ�ȭ �ѹ� �ؼ� S0 state�� �ٲ�
        #40 nrst    =   1'b0;
        #40 nrst    =   1'b1;
        // �ð��� �Է��Ѵ�
        TIME_8B =   8'd10;
        // �Էµ� �ð��� ���� �����ϵ��� S1 state�� �ٲ�
        #40 enable  =   1'b1;
        #40 enable  =   1'b0;
    end
    
endmodule
