module VendingM(                // ž ���! �� �̾�����ϴ�
    input   wire    clk,        //  Ŭ�� ��ȣ
    input   wire    nrst,       //  �ʱ�ȭ ��ȣ
    //  �����ο� �����ؾ� �ϴ� ��ȣ
    input   wire[3:0]   Cereal, //  ���õ� �ø���
    input   wire[3:0]   Milk,   //  ���õ� ����
    input   wire        Random, // ���� ���� ���� ����
    //  �������Ժο� �����ؾ� �ϴ� ��ȣ
    input   wire[2:0]   COIN,
    input   wire        RETURN,
    // ���� ���� ��Ÿ���� ��¹�
    output  wire[15:0]  BCD,    //  MONEY : BCD
    //  Button LED  -    ���� �ֹ��� �� �ִ� ��ǰ�� LED
    output  wire[3:0]   OCL,    //  Order_Cereal_Light
    output  wire[3:0]   OML,    //  Order_Milk_Light
    output  wire        ORL,    //  Order_Random_Light
    output  wire        CRL,    //  Coin_Return_Light
    //  ���� �����Ǵ��� �˷��ִ� output
    output  wire        paper_make,
    output  wire[2:0]   cereal_make,
    output  wire[1:0]   milk_make,
    output  wire[3:0]   random_make,
    //  ����Ÿ� ��Ʈ
    output  wire[8:0]    music,
    output  wire[31:0]   screen1,
    output  wire[31:0]   screen2,
    output  wire[31:0]   screen3
    );
    //  Chef ���� ���� bit
    wire        MAKE;           // �������� �˸��� ��ȣ
    //  Input_Coin ���� ���� bit
    wire[7:0]   MONEY;           // ���� ������ �ִ� ��
    wire        RETURN_STATE;   //  ���� ��� �ʱ�ȭ ��ȣ
    //  Controller ���� ���� bit
    wire        OK;      //  ���������� controller �� �޾��� �� Input_Coin ���� �Ѱ��ִ� ��Ʈ
    wire[8:0]   ORDER;   //  �Ϸ�� �޴��� Chef �� ����
    wire[7:0]   PAY;          // Total PAY
    wire        Screen_Signal;  //  ��ũ�� on/off
    //  ���� ����� ��ȯ
    Controller cont(
        .clk(clk),
        .nrst(nrst),
        .MAKE(MAKE),        // �������� �˸��� ��ȣ
        .Cereal(Cereal),    // ���õ� �ø���
        .Milk(Milk),        // ���õ� ����
        .Random(Random),    // ���� ���� ���� ����
        .MONEY(MONEY),      // MONEY : decimal 
        .RETURN_STATE(RETURN_STATE),
        .Screen_Signal(Screen_Signal),
        .OK(OK),            // �������� �˸��� ��ȣ
        .ORDER(ORDER),      // �����ο� ������ �� �޴�
        .OCL(OCL),          // Order_Cereal_Light
        .OML(OML),          // Order_Milk_Light    
        .ORL(ORL),          // Order_Random_Light   
        .PAY(PAY)           // Total PAY
        );
    //  ���� ���Ժθ� ��ȯ
    Input_Coin inpC(
        .clk(clk),
        .nrst(nrst),
        .OK(OK),            // ���� ��ȣ (��ȯ ī��Ʈ �ʱ�ȭ)
        .PAY(PAY),          // �� ���� �ݾ�
        .COIN(COIN),        // ������ ����
        .RETURN(RETURN),    // ��ȯ ��ư
        .MONEY(MONEY),      // �ܾ��� 10���� ǥ��
        .BCD(BCD),          // ��µ� �ܾ��� BCDǥ��
        .CRL(CRL),
        .RETURN_STATE(RETURN_STATE)       // ��ȯ�� �� �� Controller�� STATE �ʱ�ȭ
        );
    //  ���� ����� ��ȯ
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
    //  ���� ��� ����� ��ȯ
    Music song(
        .clk(clk),
        .nrst(nrst),
        .ON(MAKE),
        .music(music)
        );
    //  ȭ�� ��� ����� ��ȯ
    Screen sc(
        .clk(clk),
        .nrst(nrst),
        .ON(Screen_Signal),
        .screen1(screen1),
        .screen2(screen2),
        .screen3(screen3)
        );
    
endmodule