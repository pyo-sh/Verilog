module Input_Coin(
    input   wire        clk,
    input   wire        nrst,
    input   wire        OK,              // 제조 신호 (반환 카운트 초기화)
    input   wire[7:0]   PAY,             // 총 지불 금액
    input   wire[2:0]   COIN,            // 투입한 동전 => 밑의 inp_coin으로 환산
    input   wire        RETURN,          // 밖에서 누르는 반환 버튼
    output  reg [7:0]   MONEY,           // 잔액의 10진수 표현
    output  wire[15:0]  BCD,             // 출력될 잔액의 BCD표현
    output  reg         CRL,            //  Coin Return Light
    output  wire        RETURN_STATE    //  Controller의 STATE 초기화를 위함
    );
    
    reg [3:0]    count;                  // 10초 대기 반환 카운트
    reg [1:0]    STATE;
    parameter   S0=2'd0,    S1=2'd1,    S2=2'd2,    S3=2'd3;
    parameter   ON=1'd1,    OFF=1'd0;
    
    //  BCD 출력
    BCD_output inst1(
        .MONEY(MONEY),
        .BCD(BCD)
    );
    
    wire[3:0] inp_coin;               // 투입된 동전 의 실제값
    assign inp_coin = (COIN == 3'b100)  ?   4'd10   :   ((COIN == 3'b010)   ?   4'd5    :   ((COIN == 3'b001)   ?   4'd1    :   4'd0));
    
    //  FSM    
    always @(posedge clk or negedge nrst) begin
        if(!nrst) STATE     <=  S0;
        else    begin
            case(STATE)
                // 동전 주입 시 S1
                S0  :   STATE   <=  (COIN != 3'd0)  ?   S1  :   S0;
                // 9900원 초과 시 S2, 반환 시 S3
                S1  :   STATE   <=  (MONEY   +   inp_coin    >   99)    ?   S2  : ((count   ==  4'd9   ||  RETURN  ==  ON)  ?   S3  :   S1);
                // 1클럭 후  S1
                S2  :   STATE   <=  S1;
                // 반환 종료 시 S0
                S3  :   STATE   <=  ((MONEY) == 8'd0)    ?   S0  :   S3;
                default :   STATE   <=  STATE;
            endcase
        end
    end

    //  count
    always @(posedge clk) begin
        case(STATE)
            S0  :   count   <=  4'd0;
            
            /* 동전 투입 후 10초동안 반응이 없으면 반환됩니다.
            반응(제조, 동전 재투입) 시 카운트 초기화 */
            S1  :   count   <=  (((|COIN | OK) ?   4'b0000 :   4'b1111) & count) + 4'd1; 
            default :   count   <=  count;
        endcase
    end
    
    //  MONEY   돈을 8비트로 계산, 하위 두자릿수(00)는 빼고 계산
    always @(posedge clk or negedge nrst) begin
        if(!nrst) MONEY    <=  8'd0;
        else    begin
            case(STATE)
                //동전 투입
                S0  :   MONEY   <=  (MONEY   +   inp_coin);
                //동전 투입, 비용 계산, 예외 검사
                S1  :   MONEY   <=  (MONEY + inp_coin - PAY) - ((MONEY   +   inp_coin    >   99)    ?   (8'd10)  :   (8'd0));
                //동전 반환
                S3  :   MONEY   <=  (MONEY  >=  8'd10)  ?   (MONEY - 8'd10)  : ((MONEY >= 8'd5)   ?   (MONEY - 8'd5) : ((MONEY == 8'd0) ?   8'd0    :   (MONEY - 8'd1)));
                //언제든지 동전 투입과 비용 계산이 가능
                default :   MONEY   <=  (MONEY + inp_coin - PAY);
            endcase
        end
    end
    
    //  Coin_Retrun_Light 코인 반환 LED
    always @(posedge clk) begin
        case(STATE)
            //9900원 초과상태
            S2  : CRL   <=  ON;
            // 전액 반환상태
            S3  : CRL   <=  ON;
            default : CRL   <=  OFF;
        endcase
    end
    
    //  RETURN
    assign  RETURN_STATE    =   (STATE  ==  S3) ?   ON  :   OFF;
    
endmodule