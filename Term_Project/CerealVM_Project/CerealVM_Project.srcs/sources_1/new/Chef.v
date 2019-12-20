module Chef(                        //  시리얼 제조부
    input   wire    clk,            //  클럭 신호
    input   wire    nrst,           //  초기화 신호
    input   wire    [8:0] ORDER,    //  제어모듈에서 받은 주문 비트
    output  wire    MAKE,           //  현재 제조중임을 알려주는 비트
    //  현재 어떤 것이 만들어 지고 있는지에 대한 비트이다.
    output reg     [2:0]   cereal,  //  시리얼 어떤게 나오는지
    output reg     [1:0]   milk,    //  우유 어떤게 나오는지
    output reg     [3:0]   random,  //  랜덤 어떤게 나오는지
    output reg     paper            //  종이가 나오고 있는지
    );
    //  얼마동안 내용물을 내보내야하는지 알아야하는 count
    reg [3:0]   count;
    //  상태 레지스터 -   S0 : 대기상태 / S1 : 종이 출력 / S2 : 시리얼과 우유를 조합 / S3 : 랜덤 토핑을 뱉는 시간
    reg [1:0]   STATE;
    parameter   S0  =   2'd0,   S1  =   2'd1,   S2  =   2'd2,   S3  =   2'd3;
    //  출력에 사용하는 비트들을 parameter로 간략하게 표현.
    parameter   OUT_OFF =   3'b000,   OUT_1   =   3'b001,   OUT_2   =   3'b010, OUT_3   =   3'b100;
    parameter   MK_OFF  =   2'b00,  MK_HOT  =   2'b10,  MK_ICE  =   2'b01;
    //  켜진 것과 꺼진 것에 대한 parameter
    parameter   ON  =   1'b1,   OFF =   1'b0;
    
    // 제조중 임을 사용자에게 나타내는 Light  -   output으로 두지 않은 이유는 무엇이 나오는지 output을 두었기에
    //  제조부에서 Light를 내보내야 한다면 아래의 와이어를 output으로 두면 되기 때문에 만들어 놨습니다.
//    wire PL;
//    wire CL;
//    wire ML;
//    wire RL;
//    assign  PL  =   paper;
//    assign  CL  =   |cereal;
//    assign  ML  =   |milk;
//    assign  RL  =   |random;
    
    //  STATE를 설정하는 always문 -   주문이 들어오면 S1 -> S2 를 실행하며 제조 후 random버튼을 눌렀다면 S3로 간다.
    always @(posedge clk or negedge nrst) begin
        if(nrst == 0)   STATE   <=  S0;
        else begin
            case(STATE)
                S0 : STATE   <=  (ORDER[3:1] == 3'd0)   ?   S0  :   S1;
                S1 : STATE   <=  S2;
                S2 : STATE   <=  (count  ==  4'd9)   ?   S3  :   S2;
                S3 : STATE   <=  (count  ==  4'd14)  ?   S0  :   S3;
                default : STATE  <=  STATE;
            endcase
        end
    end
    
    //  count를 설정하는 always문
    always @(posedge clk) begin
        case(STATE)
            S0 : count  <=  4'd0;
            S1 : count  <=  4'd0;
            //  ORDER[0] 비트는 random 토핑을 하겠다는 신호를 받았다는 신호이다.
            //  누르지 않았다면 count가 13으로 되어 바로 S0로 넘어가게 될 것이다.
            S2 : count  <=  (count  ==  4'd9)   ?   count + (4'd4 & !ORDER[0] << 2)  :   count + 1;
            S3 : count  <=  count + 1;
            default : count <=  count;
        endcase
    end
    
    //  MAKE를 설정하는 wire 신호  -   다른 모듈에 현재 제조중임을 알려주는 MAKE 비트이다.
    assign  MAKE    =   (STATE == 0)|(count == 4'd13)    ?   OFF :   ON;
    
    //  paper를 설정하는 always문 -   S1 일 경우에 종이를 뱉어낸다.
    always @(posedge clk) begin
        case(STATE)
            S1 : paper  <=  ON;
            default : paper <=  OFF;
        endcase
    end

    //  cereal를 설정하는 always문    -   어떤 종류를 출력해야하는지를 결정. S2에서 작동된다.
    always @(posedge clk) begin
        if(STATE == S2) begin
            case(ORDER[8:5])
                4'b1000 : cereal  <=  OUT_3;          // 그래놀라
                4'b0100 : cereal  <=  OUT_2;          // 첵스초코
                4'b0010 : cereal  <=  OUT_1;          // 콘푸로스트
                4'b0001 : cereal  <=  OUT_OFF;        // 선택없음
                4'b0000 : cereal    <=  OUT_OFF;
                default : cereal    <=  cereal;
            endcase
        end
        else    cereal  <=  OUT_OFF;
    end
    
    //  milk를 설정하는 always문  -   어떤 종류를 출력해야하는지를 결정. S2에서 작동된다.
    always @(posedge clk) begin
        if(STATE == S2) begin           // ORDER[1] = 1 은 우유를 선택함 
            case(ORDER[4:1] & 4'b0111)
                //  우유를 100% 골랐다면 ORDER[4]비트가 1일 것이다. 그러면 10cycle동안, 아니라면 5cycle동안 출력된다.
                4'b0100 : milk  <=  ORDER[4]    ?   MK_HOT  :   ((count < 4'd5) ?   MK_HOT  :   MK_OFF);    //  뜨거운 우유
                4'b0010 : milk  <=  ORDER[4]    ?   MK_ICE  :   ((count < 4'd5) ?   MK_ICE  :   MK_OFF);    //   차가운 우유
                4'b0001 : milk  <=  MK_OFF;
                4'b0000 : milk  <=  MK_OFF;
                default : milk  <=  milk;
            endcase
        end
        else    milk  <=  MK_OFF;
    end
    
    //  random를 설정하는 always문    -   어떤 토핑을 보낼것인지에 대한 랜덤 함수를 지정해주는 문이다.
    always @(posedge clk) begin
        if(STATE == S3)     begin
            if(count == 4'd14)  random  <=  4'd0;   //  랜덤 토핑을 선택하지 않았거나 랜덤토핑을 다 뱉어냈을 때.
            else begin
                if(count == 4'd9) begin             //  랜덤 토핑을 선택했을 때를 나타낸다.
                    random[1:0]  =   ($random);     //  순차적으로 실행하여서 random[1:0]에 어떤 신호가 들어가는지에 대한 비트
                    case(random[1:0])
                        2'd3 :  random  =   4'b1000;    //  첫 번째 토핑
                        2'd2 :  random  =   4'b0100;    //  두 번째 토핑
                        2'd1 :  random  =   4'b0010;    //  세 번째 토핑
                        2'd0 :  random  =   4'b0001;    //  네 번째 토핑
                        default : random    =   random; //  예외 처리
                    endcase
                end
                else    random  <=  random; //  한 번 설정한 토핑을 계속 내보내기위한 설정
            end
        end
        else    random  <=  OUT_OFF;        //  예외처리를 위한 random 비트 OFF 처리
    end
    
endmodule
