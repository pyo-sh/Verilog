module Chef(                        //  �ø��� ������
    input   wire    clk,            //  Ŭ�� ��ȣ
    input   wire    nrst,           //  �ʱ�ȭ ��ȣ
    input   wire    [8:0] ORDER,    //  �����⿡�� ���� �ֹ� ��Ʈ
    output  wire    MAKE,           //  ���� ���������� �˷��ִ� ��Ʈ
    //  ���� � ���� ����� ���� �ִ����� ���� ��Ʈ�̴�.
    output reg     [2:0]   cereal,  //  �ø��� ��� ��������
    output reg     [1:0]   milk,    //  ���� ��� ��������
    output reg     [3:0]   random,  //  ���� ��� ��������
    output reg     paper            //  ���̰� ������ �ִ���
    );
    //  �󸶵��� ���빰�� ���������ϴ��� �˾ƾ��ϴ� count
    reg [3:0]   count;
    //  ���� �������� -   S0 : ������ / S1 : ���� ��� / S2 : �ø���� ������ ���� / S3 : ���� ������ ��� �ð�
    reg [1:0]   STATE;
    parameter   S0  =   2'd0,   S1  =   2'd1,   S2  =   2'd2,   S3  =   2'd3;
    //  ��¿� ����ϴ� ��Ʈ���� parameter�� �����ϰ� ǥ��.
    parameter   OUT_OFF =   3'b000,   OUT_1   =   3'b001,   OUT_2   =   3'b010, OUT_3   =   3'b100;
    parameter   MK_OFF  =   2'b00,  MK_HOT  =   2'b10,  MK_ICE  =   2'b01;
    //  ���� �Ͱ� ���� �Ϳ� ���� parameter
    parameter   ON  =   1'b1,   OFF =   1'b0;
    
    // ������ ���� ����ڿ��� ��Ÿ���� Light  -   output���� ���� ���� ������ ������ �������� output�� �ξ��⿡
    //  �����ο��� Light�� �������� �Ѵٸ� �Ʒ��� ���̾ output���� �θ� �Ǳ� ������ ����� �����ϴ�.
//    wire PL;
//    wire CL;
//    wire ML;
//    wire RL;
//    assign  PL  =   paper;
//    assign  CL  =   |cereal;
//    assign  ML  =   |milk;
//    assign  RL  =   |random;
    
    //  STATE�� �����ϴ� always�� -   �ֹ��� ������ S1 -> S2 �� �����ϸ� ���� �� random��ư�� �����ٸ� S3�� ����.
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
    
    //  count�� �����ϴ� always��
    always @(posedge clk) begin
        case(STATE)
            S0 : count  <=  4'd0;
            S1 : count  <=  4'd0;
            //  ORDER[0] ��Ʈ�� random ������ �ϰڴٴ� ��ȣ�� �޾Ҵٴ� ��ȣ�̴�.
            //  ������ �ʾҴٸ� count�� 13���� �Ǿ� �ٷ� S0�� �Ѿ�� �� ���̴�.
            S2 : count  <=  (count  ==  4'd9)   ?   count + (4'd4 & !ORDER[0] << 2)  :   count + 1;
            S3 : count  <=  count + 1;
            default : count <=  count;
        endcase
    end
    
    //  MAKE�� �����ϴ� wire ��ȣ  -   �ٸ� ��⿡ ���� ���������� �˷��ִ� MAKE ��Ʈ�̴�.
    assign  MAKE    =   (STATE == 0)|(count == 4'd13)    ?   OFF :   ON;
    
    //  paper�� �����ϴ� always�� -   S1 �� ��쿡 ���̸� ����.
    always @(posedge clk) begin
        case(STATE)
            S1 : paper  <=  ON;
            default : paper <=  OFF;
        endcase
    end

    //  cereal�� �����ϴ� always��    -   � ������ ����ؾ��ϴ����� ����. S2���� �۵��ȴ�.
    always @(posedge clk) begin
        if(STATE == S2) begin
            case(ORDER[8:5])
                4'b1000 : cereal  <=  OUT_3;          // �׷����
                4'b0100 : cereal  <=  OUT_2;          // ý������
                4'b0010 : cereal  <=  OUT_1;          // ��Ǫ�ν�Ʈ
                4'b0001 : cereal  <=  OUT_OFF;        // ���þ���
                4'b0000 : cereal    <=  OUT_OFF;
                default : cereal    <=  cereal;
            endcase
        end
        else    cereal  <=  OUT_OFF;
    end
    
    //  milk�� �����ϴ� always��  -   � ������ ����ؾ��ϴ����� ����. S2���� �۵��ȴ�.
    always @(posedge clk) begin
        if(STATE == S2) begin           // ORDER[1] = 1 �� ������ ������ 
            case(ORDER[4:1] & 4'b0111)
                //  ������ 100% ����ٸ� ORDER[4]��Ʈ�� 1�� ���̴�. �׷��� 10cycle����, �ƴ϶�� 5cycle���� ��µȴ�.
                4'b0100 : milk  <=  ORDER[4]    ?   MK_HOT  :   ((count < 4'd5) ?   MK_HOT  :   MK_OFF);    //  �߰ſ� ����
                4'b0010 : milk  <=  ORDER[4]    ?   MK_ICE  :   ((count < 4'd5) ?   MK_ICE  :   MK_OFF);    //   ������ ����
                4'b0001 : milk  <=  MK_OFF;
                4'b0000 : milk  <=  MK_OFF;
                default : milk  <=  milk;
            endcase
        end
        else    milk  <=  MK_OFF;
    end
    
    //  random�� �����ϴ� always��    -   � ������ ������������ ���� ���� �Լ��� �������ִ� ���̴�.
    always @(posedge clk) begin
        if(STATE == S3)     begin
            if(count == 4'd14)  random  <=  4'd0;   //  ���� ������ �������� �ʾҰų� ���������� �� ������ ��.
            else begin
                if(count == 4'd9) begin             //  ���� ������ �������� ���� ��Ÿ����.
                    random[1:0]  =   ($random);     //  ���������� �����Ͽ��� random[1:0]�� � ��ȣ�� �������� ���� ��Ʈ
                    case(random[1:0])
                        2'd3 :  random  =   4'b1000;    //  ù ��° ����
                        2'd2 :  random  =   4'b0100;    //  �� ��° ����
                        2'd1 :  random  =   4'b0010;    //  �� ��° ����
                        2'd0 :  random  =   4'b0001;    //  �� ��° ����
                        default : random    =   random; //  ���� ó��
                    endcase
                end
                else    random  <=  random; //  �� �� ������ ������ ��� ������������ ����
            end
        end
        else    random  <=  OUT_OFF;        //  ����ó���� ���� random ��Ʈ OFF ó��
    end
    
endmodule
