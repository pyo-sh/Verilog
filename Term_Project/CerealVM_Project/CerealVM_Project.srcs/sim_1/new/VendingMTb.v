`timescale 1ns / 1ps
module VendingMTb;  //  시뮬레이션을 위한 모듈입니다.
    //  input
    reg clk;            //  클럭 신호
    reg nrst;           //  초기화 신호
    // 무엇을 선택했는지
    reg[3:0]    Cereal; //  선택된 시리얼
    reg[3:0]    Milk;   //  선택된 우유
    reg         Random; //  랜덤 토핑 선택 여부
    //  코인에 대한 input
    reg[2:0]    COIN;   //  몇백원 넣었는지
    reg         RETURN; //  반환버튼
    //  output
    wire[15:0]  BCD;    //  MONEY : BCD
    //  Button LED
    wire[3:0]   OCL;    //  Order_Cereal_Light
    wire[3:0]   OML;    //  Order_Milk_Light
    wire        ORL;    //  Order_Random_Light
    //  뭐가 제조되는지 알리기 위한 output
    wire        paper_make;
    wire[2:0]   cereal_make;
    wire[1:0]   milk_make;
    wire[3:0]   random_make;
    //  유흥거리
    wire[8:0]   music;
    wire[31:0]  screen1;
    wire[31:0]  screen2;
    wire[31:0]  screen3;
    //  탑 모듈을 이용해서 시뮬레이션을 합니다.
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
    //  count   -   현재 클럭이 몇 번째 클럭인지를 알고 싶어서 나타내어 보았습니다.
    reg [7:0]count;
    always  #40 begin
        count   =   count+8'd1;
    end 
    //  clock 주기를 설정하는 always문입니다.
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
        //  초기화 합니다.
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
        //  첫 번째 테스트    그래놀라 / 따뜻한 우유 50% / 랜덤
        #120    Cereal = 4'b1000;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b0100;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        //  두 번째 테스트    콘푸러스트 / 차가운 우유 50% / 랜덤
        #600    Cereal = 4'b0100;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b0010;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        //  돈이 부족해서 더 넣어버립니다
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
        //  세 번째 테스트    첵스초코 / 따뜻한 우유 100% / 랜덤
        #200    Cereal = 4'b0100;
        #40     Cereal = 4'd0;
        #120    Milk = 4'b1000;
        #40     Milk = 4'd0;
        #120    Milk = 4'b0100;
        #40     Milk = 4'd0;
        #80     Random  =   1'b1;
        #40     Random  =   1'b0;
        // 네 번째 테스트     선택안함 / 선택안함 눌렀다가 차가운 우유 100% / 랜덤
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
