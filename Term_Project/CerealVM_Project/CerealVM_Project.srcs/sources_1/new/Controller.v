module Controller(              //  사용자에게 어떤 신호를 받을건지, 제조를 해야하는지 등의 판단을 하기 위한 제어모듈
    input   wire        clk,    //  클럭 신호
    input   wire        nrst,   //  초기화 신호 
    input   wire        MAKE,   //  제조중을 알리는 신호
    input   wire[3:0]   Cereal, //  선택된 시리얼
    input   wire[3:0]   Milk,   //  선택된 우유
    input   wire        Random, //  랜덤 토핑 선택 여부
    input   wire[7:0]   MONEY,  //  MONEY : decimal
    input   wire        RETURN_STATE,   //  주문을 받지 않는 상태로 바꾸기 위한 시그널. (동전 반환을 하고 난 후 대기 상태로 가야하기 때문)
    
    output  reg         Screen_Signal,  //  Screen을 출력하게 하기 위한 비트이다. 제어에서 관리한다
    output  reg         OK,          // 제조중을 알리는 신호
    output  reg[8:0]    ORDER,       // 제조부에 전달할 총 메뉴
    output  wire[3:0]   OCL,         // Order_Cereal_Light  : Button LED
    output  wire[3:0]   OML,         // Order_Milk_Light    
    output  reg         ORL,         // Order_Random_Light   
    output  reg[7:0]    PAY          // Total PAY
    );
    //  상태 레지스터 /   S0 : 대기 상태 / S1 : 돈을 받는 순간 주문을 대기한다. 돈에 맞게 시리얼 주문을 받는다.
    //                  S2 : 시리얼 주문을 받은 뒤 우유 주문을 받는다.
    //                  S3 : 현재 제조 중인 상태이며 random 토핑을 할 수 있게 신호를 받아서 ORDER를 보낸다.
    reg [1:0]    STATE;
    parameter   S0=2'd0,    S1=2'd1,    S2=2'd2,    S3=2'd3;
    
    reg[4:0]   COST_Cereal; // 선택된 시리얼의 비용
    reg[4:0]   COST_Milk;   // 선택된 우유의 비용
    
    // 선택된 메뉴의 parameter
    // Cereal : Grae / Confu / Choco / No
    // Milk : Ice / Hot / No
    parameter   Cereal_No   = 4'b0001,   Cereal_Choco   = 4'b0010,     Cereal_Confu    = 4'b0100,  Cereal_Grae = 4'b1000;
    parameter   Milk_No     = 3'b001,   Milk_Ice        = 3'b010,     Milk_Hot        = 3'b100;
    // 시리얼,우유의 가격
    parameter   COST_Choco  =   5'd13,      COST_Confu  =   5'd13,  COST_Grae   =   5'd17;
    parameter   COST_Hot    =   5'd3,       COST_Ice    =   5'd3,   COST_Double   =   5'd5  ,   COST_Rand   =   5'd5;
    parameter   ON=1'd1,    OFF=1'd0;
    
    //  STATE를 결정하는 always문
    always @(posedge clk or negedge nrst) begin
        if(!nrst | RETURN_STATE) STATE     <=  S0;  // 초기화 비트를 받거나 동전 반환상태일 경우 초기화해야 함
        else    begin
            case(STATE)
                // 잔액이 있으면 S1
                S0  :   STATE   <=  (MONEY != 16'd0)    ?   S1  :   S0;
                // 시리얼 버튼을 클릭하면 S2
                S1  :   STATE   <=  (ORDER[8:5] != 4'd0)    ?   S2  :   S1;
                // 우유까지 주문이 완료되면 S3
                S2  :   STATE   <=  (ORDER[3:1] != 3'd0)    ?   S3  :   S2;
                // 제조가 완료되면 S0
                S3  :   STATE   <=  MAKE    ?   S3  :   S0;
                default :   STATE   <=  STATE;
            endcase
        end
    end
    
    //  ORDER를 설정하는 always문
    always @(posedge clk) begin
         case(STATE)
             S0 :   ORDER       <=  9'b0;
             // 잔액이 주문한 시리얼의 금액보다 클 때 ORDER 업데이트
             S1 :   ORDER[8:5]  <=  (ORDER[8:5] == 4'd0)    ?   (|( OCL & Cereal ) ? ((Cereal == Cereal_Grae)|(Cereal == Cereal_Choco)|(Cereal == Cereal_Confu)|(Cereal == Cereal_No) ? Cereal : 4'd0) : 4'd0)    :   ORDER[8:5];
             // 잔액이 주문한 시리얼+우유의 금액보다 클 때, ORDER 업데이트, 제조시작
             S2 :   begin
                if(ORDER[3:1]   ==  3'd0) begin
                    //  우유를 double로 할 것인지 아닌지에 대한 판단은 따로 한다.
                    ORDER[4]    <=  (ORDER[4] ^ Milk[3]);
                    //  따뜻한 우유 / 차가운 우유 / 선택안함 의 선택지를 받았는지를 검사한다.
                    ORDER[3:1]  <=  |(OML[2:0] & Milk[2:0]) ? ((Milk[2:0] == Milk_Hot)|(Milk[2:0] == Milk_Ice)|(Milk[2:0] == Milk_No) ? Milk[2:0] : 3'd0) : 3'd0;
                    end
                else    ORDER  <=  ORDER;
                end
             // 제조 시간 내로 랜덤 토핑을 선택
             S3 :   ORDER[0]    <=  (ORDER[0])  ?   ORDER[0]    :   ((MONEY >= COST_Rand)   ?   (ORDER[0]|Random)   :   1'b0);
             default :   ORDER   <=  ORDER;
         endcase
    end
    
    
    //  PAY를 설정하는 always문   -   어떤 비용을 내야하는지를 판단한다.
    always @(posedge clk) begin
        case(STATE)
            S0 : PAY    <=  8'd0;
            S3 : PAY    <=  ((MONEY >= COST_Rand)&(!ORDER[0]&Random)    ?   8'd5    :   8'd0) + COST_Milk;
            default : PAY   <=  COST_Cereal + COST_Milk;    //   시리얼과 우유의 값을 반환한다.
        endcase
    end
    
    //  OK비트를 설정하는 always문  -   동전 주입부가 반환하기 위한 count를 초기화 하기 위한 비트이다.
    always @(posedge clk) begin
        case(STATE)
            S0  :   OK  <=  OFF;
            S1  :   OK  <=  (((Cereal | Milk) != 4'd0) | MAKE) ? ON: OFF;
            S2  :   OK  <=  (((Cereal | Milk) != 4'd0) | MAKE) ? ON: OFF;
            S3  :   OK  <=  ON;
            default :   OK  <=  OK;
        endcase
    end
    
    //  Order_Light =   주문을 할 수 있는 메뉴들을 LED 로 표현하는 비트들 설정한다. 가격을 여기서 고려한다.
    assign OCL = (STATE == S0) ? 4'b0 : (STATE==S2 | STATE==S3) ?   ORDER[8:5] :    (MONEY >= COST_Grae)    ? 4'b1111 : (MONEY >= COST_Choco) ? 4'b0111 : 4'b0001;
    assign OML = (STATE == S0 | STATE == S1) ? 4'b0 : (STATE==S3) ? ORDER[4:1] :    (MONEY >= COST_Double)  ? (4'b1111^ORDER[5]) : (MONEY >= COST_Hot) ? (4'b0111^ORDER[5]) : (4'b0001^ORDER[5]);
    always @(posedge clk) begin
        case(STATE)
            S3 : ORL    <=  (ORDER[0])  ?   ORDER[0]  :   ((MONEY >= COST_Rand) ? ORL^1'b1 : OFF);
            default : ORL   <=  OFF;
        endcase
    end
    
    //  COST_Cereal를 설정하는 always문   -   OCL 빛을 이용해 주문할 수 있는 비트를 판단한다.
    always @(posedge clk) begin
        case(STATE)
            S0 : COST_Cereal    <=  5'd0;
            //  그래놀라 1700원, 나머지 1300원 이다.
            S1 : COST_Cereal    <= (ORDER[8:5] == Cereal_Grae) ? COST_Grae : ((ORDER[8:5] == Cereal_Choco)|(ORDER[8:5] == Cereal_Confu) ? COST_Choco : 5'd0);
            S2 : COST_Cereal    <=  5'd0;
            default :  COST_Cereal <= COST_Cereal;
        endcase
    end
    
    //  COST_Milk를 설정하는 always문 -   선택한 우유의 비용
    always @(posedge clk) begin
        case(STATE)
            S0  :   COST_Milk <=    5'd0;
            // double 이면 500원, hot/ice 300원, 없음은 0원
            S2  :   COST_Milk <=    (ORDER[3:1] == Milk_Hot)|(ORDER[3:1] == Milk_Ice) ? ((ORDER[4]) ? COST_Double : COST_Hot) : 5'd0;
            S3  :   COST_Milk <=    5'd0;
            default :  COST_Milk <= COST_Milk;
        endcase
    end

    // 돈을 투입시키면 젖소가 춤을 추는 화면을 출력하기 위한 비트를 설정합니다.
    always @(posedge clk) begin
        case(STATE)
            //  대기상태에서 만약 돈이 없는 상태가 아니라면 ON을 해줘야 하기 때문입니다.
            S0 : Screen_Signal     <=  (MONEY == 8'd0)  ?   OFF :   ON;
            S1 : Screen_Signal     <=  ON;
            S2 : Screen_Signal     <=  ON;
            S3 : Screen_Signal     <=  ON;
            default: Screen_Signal  <=  OFF;
        endcase
    end
    
endmodule