`timescale 1ns / 1ps
module VendingMTb;  //  �ùķ��̼��� ���� ����Դϴ�.
    //  input
    reg clk;            //  Ŭ�� ��ȣ
    reg nrst;           //  �ʱ�ȭ ��ȣ
    // ������ �����ߴ���
    reg[3:0]    Cereal; //  ���õ� �ø���
    reg[3:0]    Milk;   //  ���õ� ����
    reg         Random; //  ���� ���� ���� ����
    //  ���ο� ���� input
    reg[2:0]    COIN;   //  ���� �־�����
    reg         RETURN; //  ��ȯ��ư
    //  output
    wire[15:0]  BCD;    //  MONEY : BCD
    //  Button LED
    wire[3:0]   OCL;    //  Order_Cereal_Light
    wire[3:0]   OML;    //  Order_Milk_Light
    wire        ORL;    //  Order_Random_Light
    //  ���� �����Ǵ��� �˸��� ���� output
    wire        paper_make;
    wire[2:0]   cereal_make;
    wire[1:0]   milk_make;
    wire[3:0]   random_make;
    //  ����Ÿ�
    wire[8:0]   music;
    wire[31:0]  screen1;
    wire[31:0]  screen2;
    wire[31:0]  screen3;
    //  ž ����� �̿��ؼ� �ùķ��̼��� �մϴ�.
    VendingM inst(
        .clk(clk),
        .nrst(nrst),
        .Cereal(Cereal),
        .Milk(Milk),
        .Random(Random),
        .COIN(COIN),
        .RETURN(RETURN),
        .BCD(BCD),
        .OCL(OCL),
        .OML(OML),
        .ORL(ORL),
        .paper_make(paper_make),
        .cereal_make(cereal_make),
        .milk_make(milk_make),
        .random_make(random_make),
        .music(music),
        .screen1(screen1),
        .screen2(screen2),
        .screen3(screen3)
    );
    //  count   -   ���� Ŭ���� �� ��° Ŭ�������� �˰� �; ��Ÿ���� ���ҽ��ϴ�.
    reg [7:0]count;
    always  #40 begin
        count   =   count+8'd1;
    end 
    //  clock �ֱ⸦ �����ϴ� always���Դϴ�.
    always  #20 begin
        clk =   ~clk;
    end
    // testbench
    initial begin
        count   =   8'd0;
        clk     =   1'b0;
        nrst    =   1'b1;
        
        COIN    =   3'd0;
        RETURN  =   1'b0;
        
        Cereal  =   4'd0;
        Milk    =   4'd0;
        Random  =   1'b0;
        //  �ʱ�ȭ �մϴ�.
        #40 nrst    =   1'b0;
        #40 nrst    =   1'b1;
        
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        //  ù ��° �׽�Ʈ    �׷���� / ������ ���� 50% / ����
        #120    Cereal = 4'b1000;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b0100;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        //  �� ��° �׽�Ʈ    ��Ǫ����Ʈ / ������ ���� 50% / ����
        #600    Cereal = 4'b0100;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b0010;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        //  ���� �����ؼ� �� �־�����ϴ�
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        #40 COIN = 3'b100;
        #40 COIN = 3'd0;
        //  �� ��° �׽�Ʈ    ý������ / ������ ���� 100% / ����
        #200    Cereal = 4'b0100;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b1000;
        #40     Milk = 4'd0;
        #120    Milk = 4'b0100;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        // �� ��° �׽�Ʈ     ���þ��� / ���þ��� �����ٰ� ������ ���� 100% / ����
        #600    Cereal = 4'b0001;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b0001;
        #40     Milk = 4'd0;
        #120    Milk = 4'b1000;
        #40     Milk = 4'd0;
        #120    Milk = 4'b0010;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
    end

endmodule
