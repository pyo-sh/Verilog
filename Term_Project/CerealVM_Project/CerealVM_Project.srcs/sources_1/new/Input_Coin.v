module Input_Coin(
    input   wire        clk,
    input   wire        nrst,
    input   wire        OK,              // ���� ��ȣ (��ȯ ī��Ʈ �ʱ�ȭ)
    input   wire[7:0]   PAY,             // �� ���� �ݾ�
    input   wire[2:0]   COIN,            // ������ ���� => ���� inp_coin���� ȯ��
    input   wire        RETURN,          // �ۿ��� ������ ��ȯ ��ư
    output  reg [7:0]   MONEY,           // �ܾ��� 10���� ǥ��
    output  wire[15:0]  BCD,             // ��µ� �ܾ��� BCDǥ��
    output  reg         CRL,            //  Coin Return Light
    output  wire        RETURN_STATE    //  Controller�� STATE �ʱ�ȭ�� ����
    );
    
    reg [3:0]    count;                  // 10�� ��� ��ȯ ī��Ʈ
    reg [1:0]    STATE;
    parameter   S0=2'd0,    S1=2'd1,    S2=2'd2,    S3=2'd3;
    parameter   ON=1'd1,    OFF=1'd0;
    
    //  BCD ���
    BCD_output inst1(
        .MONEY(MONEY),
        .BCD(BCD)
    );
    
    wire[3:0] inp_coin;               // ���Ե� ���� �� ������
    assign inp_coin = (COIN == 3'b100)  ?   4'd10   :   ((COIN == 3'b010)   ?   4'd5    :   ((COIN == 3'b001)   ?   4'd1    :   4'd0));
    
    //  FSM    
    always @(posedge clk or negedge nrst) begin
        if(!nrst) STATE     <=  S0;
        else    begin
            case(STATE)
                // ���� ���� �� S1
                S0  :   STATE   <=  (COIN != 3'd0)  ?   S1  :   S0;
                // 9900�� �ʰ� �� S2, ��ȯ �� S3
                S1  :   STATE   <=  (MONEY   +   inp_coin    >   99)    ?   S2  : ((count   ==  4'd9   ||  RETURN  ==  ON)  ?   S3  :   S1);
                // 1Ŭ�� ��  S1
                S2  :   STATE   <=  S1;
                // ��ȯ ���� �� S0
                S3  :   STATE   <=  ((MONEY) == 8'd0)    ?   S0  :   S3;
                default :   STATE   <=  STATE;
            endcase
        end
    end

    //  count
    always @(posedge clk) begin
        case(STATE)
            S0  :   count   <=  4'd0;
            
            /* ���� ���� �� 10�ʵ��� ������ ������ ��ȯ�˴ϴ�.
            ����(����, ���� ������) �� ī��Ʈ �ʱ�ȭ */
            S1  :   count   <=  (((|COIN | OK) ?   4'b0000 :   4'b1111) & count) + 4'd1; 
            default :   count   <=  count;
        endcase
    end
    
    //  MONEY   ���� 8��Ʈ�� ���, ���� ���ڸ���(00)�� ���� ���
    always @(posedge clk or negedge nrst) begin
        if(!nrst) MONEY    <=  8'd0;
        else    begin
            case(STATE)
                //���� ����
                S0  :   MONEY   <=  (MONEY   +   inp_coin);
                //���� ����, ��� ���, ���� �˻�
                S1  :   MONEY   <=  (MONEY + inp_coin - PAY) - ((MONEY   +   inp_coin    >   99)    ?   (8'd10)  :   (8'd0));
                //���� ��ȯ
                S3  :   MONEY   <=  (MONEY  >=  8'd10)  ?   (MONEY - 8'd10)  : ((MONEY >= 8'd5)   ?   (MONEY - 8'd5) : ((MONEY == 8'd0) ?   8'd0    :   (MONEY - 8'd1)));
                //�������� ���� ���԰� ��� ����� ����
                default :   MONEY   <=  (MONEY + inp_coin - PAY);
            endcase
        end
    end
    
    //  Coin_Retrun_Light ���� ��ȯ LED
    always @(posedge clk) begin
        case(STATE)
            //9900�� �ʰ�����
            S2  : CRL   <=  ON;
            // ���� ��ȯ����
            S3  : CRL   <=  ON;
            default : CRL   <=  OFF;
        endcase
    end
    
    //  RETURN
    assign  RETURN_STATE    =   (STATE  ==  S3) ?   ON  :   OFF;
    
endmodule