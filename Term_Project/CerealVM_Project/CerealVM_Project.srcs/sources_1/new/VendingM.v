module VendingM(                // 탑 모듈! 다 이어버립니다
    input   wire    clk,        //  클럭 신호
    input   wire    nrst,       //  초기화 신호
    //  제조부에 전달해야 하는 신호
    input   wire[3:0]   Cereal, //  선택된 시리얼
    input   wire[3:0]   Milk,   //  선택된 우유
    input   wire        Random, // 랜덤 토핑 선택 여부
    //  동전주입부에 전달해야 하는 신호
    input   wire[2:0]   COIN,
    input   wire        RETURN,
    // 현재 값을 나타내는 출력문
    output  wire[15:0]  BCD,    //  MONEY : BCD
    //  Button LED  -    현재 주문할 수 있는 제품의 LED
    output  wire[3:0]   OCL,    //  Order_Cereal_Light
    output  wire[3:0]   OML,    //  Order_Milk_Light
    output  wire        ORL,    //  Order_Random_Light
    output  wire        CRL,    //  Coin_Return_Light
    //  뭐가 제조되는지 알려주는 output
    output  wire        paper_make,
    output  wire[2:0]   cereal_make,
    output  wire[1:0]   milk_make,
    output  wire[3:0]   random_make,
    //  유흥거리 비트
    output  wire[8:0]    music,
    output  wire[31:0]   screen1,
    output  wire[31:0]   screen2,
    output  wire[31:0]   screen3
    );
    //  Chef 에서 나온 bit
    wire        MAKE;           // 제조중을 알리는 신호
    //  Input_Coin 에서 나온 bit
    wire[7:0]   MONEY;           // 현재 가지고 있는 돈
    wire        RETURN_STATE;   //  제어 모듈 초기화 신호
    //  Controller 에서 나온 bit
    wire        OK;      //  제조중임을 controller 가 받았을 때 Input_Coin 에게 넘겨주는 비트
    wire[8:0]   ORDER;   //  완료된 메뉴를 Chef 에 전달
    wire[7:0]   PAY;          // Total PAY
    wire        Screen_Signal;  //  스크린 on/off
    //  제어 모듈을 소환
    Controller cont(
        .clk(clk),
        .nrst(nrst),
        .MAKE(MAKE),        // 제조중을 알리는 신호
        .Cereal(Cereal),    // 선택된 시리얼
        .Milk(Milk),        // 선택된 우유
        .Random(Random),    // 랜덤 토핑 선택 여부
        .MONEY(MONEY),      // MONEY : decimal 
        .RETURN_STATE(RETURN_STATE),
        .Screen_Signal(Screen_Signal),
        .OK(OK),            // 제조중을 알리는 신호
        .ORDER(ORDER),      // 제조부에 전달할 총 메뉴
        .OCL(OCL),          // Order_Cereal_Light
        .OML(OML),          // Order_Milk_Light    
        .ORL(ORL),          // Order_Random_Light   
        .PAY(PAY)           // Total PAY
        );
    //  동전 주입부를 손환
    Input_Coin inpC(
        .clk(clk),
        .nrst(nrst),
        .OK(OK),            // 제조 신호 (반환 카운트 초기화)
        .PAY(PAY),          // 총 지불 금액
        .COIN(COIN),        // 투입한 동전
        .RETURN(RETURN),    // 반환 버튼
        .MONEY(MONEY),      // 잔액의 10진수 표현
        .BCD(BCD),          // 출력될 잔액의 BCD표현
        .CRL(CRL),
        .RETURN_STATE(RETURN_STATE)       // 반환을 한 후 Controller의 STATE 초기화
        );
    //  제조 모듈을 소환
    Chef chef(
        .clk(clk),
        .nrst(nrst),
        .ORDER(ORDER),
        .MAKE(MAKE),
        .cereal(cereal_make),
        .milk(milk_make),
        .random(random_make),
        .paper(paper_make)
        );
    //  음악 재생 모듈을 소환
    Music song(
        .clk(clk),
        .nrst(nrst),
        .ON(MAKE),
        .music(music)
        );
    //  화면 출력 모듈을 소환
    Screen sc(
        .clk(clk),
        .nrst(nrst),
        .ON(Screen_Signal),
        .screen1(screen1),
        .screen2(screen2),
        .screen3(screen3)
        );
    
endmodule