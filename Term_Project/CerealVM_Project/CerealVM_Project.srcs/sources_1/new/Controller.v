module Controller(              //  ����ڿ��� � ��ȣ�� ��������, ������ �ؾ��ϴ��� ���� �Ǵ��� �ϱ� ���� ������
    input   wire        clk,    //  Ŭ�� ��ȣ
    input   wire        nrst,   //  �ʱ�ȭ ��ȣ 
    input   wire        MAKE,   //  �������� �˸��� ��ȣ
    input   wire[3:0]   Cereal, //  ���õ� �ø���
    input   wire[3:0]   Milk,   //  ���õ� ����
    input   wire        Random, //  ���� ���� ���� ����
    input   wire[7:0]   MONEY,  //  MONEY : decimal
    input   wire        RETURN_STATE,   //  �ֹ��� ���� �ʴ� ���·� �ٲٱ� ���� �ñ׳�. (���� ��ȯ�� �ϰ� �� �� ��� ���·� �����ϱ� ����)
    
    output  reg         Screen_Signal,  //  Screen�� ����ϰ� �ϱ� ���� ��Ʈ�̴�. ����� �����Ѵ�
    output  reg         OK,          // �������� �˸��� ��ȣ
    output  reg[8:0]    ORDER,       // �����ο� ������ �� �޴�
    output  wire[3:0]   OCL,         // Order_Cereal_Light  : Button LED
    output  wire[3:0]   OML,         // Order_Milk_Light    
    output  reg         ORL,         // Order_Random_Light   
    output  reg[7:0]    PAY          // Total PAY
    );
    //  ���� �������� /   S0 : ��� ���� / S1 : ���� �޴� ���� �ֹ��� ����Ѵ�. ���� �°� �ø��� �ֹ��� �޴´�.
    //                  S2 : �ø��� �ֹ��� ���� �� ���� �ֹ��� �޴´�.
    //                  S3 : ���� ���� ���� �����̸� random ������ �� �� �ְ� ��ȣ�� �޾Ƽ� ORDER�� ������.
    reg [1:0]    STATE;
    parameter   S0=2'd0,    S1=2'd1,    S2=2'd2,    S3=2'd3;
    
    reg[4:0]   COST_Cereal; // ���õ� �ø����� ���
    reg[4:0]   COST_Milk;   // ���õ� ������ ���
    
    // ���õ� �޴��� parameter
    // Cereal : Grae / Confu / Choco / No
    // Milk : Ice / Hot / No
    parameter   Cereal_No   = 4'b0001,   Cereal_Choco   = 4'b0010,     Cereal_Confu    = 4'b0100,  Cereal_Grae = 4'b1000;
    parameter   Milk_No     = 3'b001,   Milk_Ice        = 3'b010,     Milk_Hot        = 3'b100;
    // �ø���,������ ����
    parameter   COST_Choco  =   5'd13,      COST_Confu  =   5'd13,  COST_Grae   =   5'd17;
    parameter   COST_Hot    =   5'd3,       COST_Ice    =   5'd3,   COST_Double   =   5'd5  ,   COST_Rand   =   5'd5;
    parameter   ON=1'd1,    OFF=1'd0;
    
    //  STATE�� �����ϴ� always��
    always @(posedge clk or negedge nrst) begin
        if(!nrst | RETURN_STATE) STATE     <=  S0;  // �ʱ�ȭ ��Ʈ�� �ްų� ���� ��ȯ������ ��� �ʱ�ȭ�ؾ� ��
        else    begin
            case(STATE)
                // �ܾ��� ������ S1
                S0  :   STATE   <=  (MONEY != 16'd0)    ?   S1  :   S0;
                // �ø��� ��ư�� Ŭ���ϸ� S2
                S1  :   STATE   <=  (ORDER[8:5] != 4'd0)    ?   S2  :   S1;
                // �������� �ֹ��� �Ϸ�Ǹ� S3
                S2  :   STATE   <=  (ORDER[3:1] != 3'd0)    ?   S3  :   S2;
                // ������ �Ϸ�Ǹ� S0
                S3  :   STATE   <=  MAKE    ?   S3  :   S0;
                default :   STATE   <=  STATE;
            endcase
        end
    end
    
    //  ORDER�� �����ϴ� always��
    always @(posedge clk) begin
         case(STATE)
             S0 :   ORDER       <=  9'b0;
             // �ܾ��� �ֹ��� �ø����� �ݾ׺��� Ŭ �� ORDER ������Ʈ
             S1 :   ORDER[8:5]  <=  (ORDER[8:5] == 4'd0)    ?   (|( OCL & Cereal ) ? ((Cereal == Cereal_Grae)|(Cereal == Cereal_Choco)|(Cereal == Cereal_Confu)|(Cereal == Cereal_No) ? Cereal : 4'd0) : 4'd0)    :   ORDER[8:5];
             // �ܾ��� �ֹ��� �ø���+������ �ݾ׺��� Ŭ ��, ORDER ������Ʈ, ��������
             S2 :   begin
                if(ORDER[3:1]   ==  3'd0) begin
                    //  ������ double�� �� ������ �ƴ����� ���� �Ǵ��� ���� �Ѵ�.
                    ORDER[4]    <=  (ORDER[4] ^ Milk[3]);
                    //  ������ ���� / ������ ���� / ���þ��� �� �������� �޾Ҵ����� �˻��Ѵ�.
                    ORDER[3:1]  <=  |(OML[2:0] & Milk[2:0]) ? ((Milk[2:0] == Milk_Hot)|(Milk[2:0] == Milk_Ice)|(Milk[2:0] == Milk_No) ? Milk[2:0] : 3'd0) : 3'd0;
                    end
                else    ORDER  <=  ORDER;
                end
             // ���� �ð� ���� ���� ������ ����
             S3 :   ORDER[0]    <=  (ORDER[0])  ?   ORDER[0]    :   ((MONEY >= COST_Rand)   ?   (ORDER[0]|Random)   :   1'b0);
             default :   ORDER   <=  ORDER;
         endcase
    end
    
    
    //  PAY�� �����ϴ� always��   -   � ����� �����ϴ����� �Ǵ��Ѵ�.
    always @(posedge clk) begin
        case(STATE)
            S0 : PAY    <=  8'd0;
            S3 : PAY    <=  ((MONEY >= COST_Rand)&(!ORDER[0]&Random)    ?   8'd5    :   8'd0) + COST_Milk;
            default : PAY   <=  COST_Cereal + COST_Milk;    //   �ø���� ������ ���� ��ȯ�Ѵ�.
        endcase
    end
    
    //  OK��Ʈ�� �����ϴ� always��  -   ���� ���Ժΰ� ��ȯ�ϱ� ���� count�� �ʱ�ȭ �ϱ� ���� ��Ʈ�̴�.
    always @(posedge clk) begin
        case(STATE)
            S0  :   OK  <=  OFF;
            S1  :   OK  <=  (((Cereal | Milk) != 4'd0) | MAKE) ? ON: OFF;
            S2  :   OK  <=  (((Cereal | Milk) != 4'd0) | MAKE) ? ON: OFF;
            S3  :   OK  <=  ON;
            default :   OK  <=  OK;
        endcase
    end
    
    //  Order_Light =   �ֹ��� �� �� �ִ� �޴����� LED �� ǥ���ϴ� ��Ʈ�� �����Ѵ�. ������ ���⼭ ����Ѵ�.
    assign OCL = (STATE == S0) ? 4'b0 : (STATE==S2 | STATE==S3) ?   ORDER[8:5] :    (MONEY >= COST_Grae)    ? 4'b1111 : (MONEY >= COST_Choco) ? 4'b0111 : 4'b0001;
    assign OML = (STATE == S0 | STATE == S1) ? 4'b0 : (STATE==S3) ? ORDER[4:1] :    (MONEY >= COST_Double)  ? (4'b1111^ORDER[5]) : (MONEY >= COST_Hot) ? (4'b0111^ORDER[5]) : (4'b0001^ORDER[5]);
    always @(posedge clk) begin
        case(STATE)
            S3 : ORL    <=  (ORDER[0])  ?   ORDER[0]  :   ((MONEY >= COST_Rand) ? ORL^1'b1 : OFF);
            default : ORL   <=  OFF;
        endcase
    end
    
    //  COST_Cereal�� �����ϴ� always��   -   OCL ���� �̿��� �ֹ��� �� �ִ� ��Ʈ�� �Ǵ��Ѵ�.
    always @(posedge clk) begin
        case(STATE)
            S0 : COST_Cereal    <=  5'd0;
            //  �׷���� 1700��, ������ 1300�� �̴�.
            S1 : COST_Cereal    <= (ORDER[8:5] == Cereal_Grae) ? COST_Grae : ((ORDER[8:5] == Cereal_Choco)|(ORDER[8:5] == Cereal_Confu) ? COST_Choco : 5'd0);
            S2 : COST_Cereal    <=  5'd0;
            default :  COST_Cereal <= COST_Cereal;
        endcase
    end
    
    //  COST_Milk�� �����ϴ� always�� -   ������ ������ ���
    always @(posedge clk) begin
        case(STATE)
            S0  :   COST_Milk <=    5'd0;
            // double �̸� 500��, hot/ice 300��, ������ 0��
            S2  :   COST_Milk <=    (ORDER[3:1] == Milk_Hot)|(ORDER[3:1] == Milk_Ice) ? ((ORDER[4]) ? COST_Double : COST_Hot) : 5'd0;
            S3  :   COST_Milk <=    5'd0;
            default :  COST_Milk <= COST_Milk;
        endcase
    end

    // ���� ���Խ�Ű�� ���Ұ� ���� �ߴ� ȭ���� ����ϱ� ���� ��Ʈ�� �����մϴ�.
    always @(posedge clk) begin
        case(STATE)
            //  �����¿��� ���� ���� ���� ���°� �ƴ϶�� ON�� ����� �ϱ� �����Դϴ�.
            S0 : Screen_Signal     <=  (MONEY == 8'd0)  ?   OFF :   ON;
            S1 : Screen_Signal     <=  ON;
            S2 : Screen_Signal     <=  ON;
            S3 : Screen_Signal     <=  ON;
            default: Screen_Signal  <=  OFF;
        endcase
    end
    
endmodule