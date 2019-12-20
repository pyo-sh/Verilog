module Music(               //  ��ȣ�� ������ ������ Ʈ�� ���
    input wire clk,         //  Ŭ�� ��ȣ
    input wire nrst,
    input wire ON,          //  ������ Ų�ٴ� ��ȣ
    output reg [8:0] music  //  �귯������ ���̷ο� ����
    );
    
    reg[5:0] count;         //  �޸��� �ε��� = ������ �뷮�� 9bit * 64
    //  ���� - S0 : �뷡�� �� ������ ���� / S1 : �뷡�� ������ ����
    reg STATE;
    parameter   S0 = 1'b0,  S1 = 1'b1;
    //  �뷡�� ������ �޸� ����
    reg[8:0]    mem [0:63];
    //  �� �Ķ������ �̸��� ������ ��Ÿ����. ���� 2��� ���ڴ� 2��Ÿ���� ��
    parameter   DA  = 9'b100100000;
    parameter   F   = 9'b010000000;
    parameter   G   = 9'b001000000;
    parameter   A   = 9'b000100000;
    parameter   C2  = 9'b000010000;
    parameter   D2  = 9'b000001000;
    parameter   E2  = 9'b000000100;
    parameter   F2  = 9'b000000010;
    parameter   A2  = 9'b000000001;
    parameter   OFF = 9'd0;
    
    //  �ʱ�ȭ ��ư�� ���� �� �޸� �ʱ�ȭ (�޸𸮿� �뷡 �ֱ�)
    always @(negedge nrst) begin
        mem[0] = A;    mem[1] = OFF;  mem[2] = A;    mem[3] = OFF;  mem[4] = G;    mem[5] = OFF;  mem[6] = F;    mem[7] = OFF;
        mem[8] = A;    mem[9] = OFF;  mem[10] = OFF; mem[11] = OFF; mem[12] = C2;  mem[13] = OFF; mem[14] = OFF; mem[15] = OFF;
        mem[16] = A;   mem[17] = OFF; mem[18] = A;   mem[19] = OFF; mem[20] = G;   mem[21] = OFF; mem[22] = F;   mem[23] = OFF;
        mem[24] = A;   mem[25] = OFF; mem[26] = OFF; mem[27] = OFF; mem[28] = G;   mem[29] = OFF; mem[30] = OFF; mem[31] = OFF;
        mem[32] = A;   mem[33] = OFF; mem[34] = A;   mem[35] = OFF; mem[36] = G;   mem[37] = OFF; mem[38] = F;   mem[39] = OFF;
        mem[40] = A;   mem[41] = OFF; mem[42] = A;   mem[43] = OFF; mem[44] = C2;  mem[45] = D2;  mem[46] = E2;  mem[47] = A2;
        mem[48] = E2;  mem[49] = F2;  mem[50] = E2;  mem[51] = F2;  mem[52] = E2;  mem[53] = F2;  mem[54] = F;   mem[55] = OFF;
        mem[56] = OFF; mem[57] = OFF; mem[58] = DA;  mem[59] = DA;  mem[60] = OFF; mem[61] = OFF; mem[62] = OFF; mem[63] = OFF;
    end
    
    //  STATE �����ϴ� always��  -   ON �̶�� ��ȣ�� S0 / S1 �� �����ȴ�.
    always @(posedge clk or negedge nrst) begin
        if(!nrst)   STATE   <=  S0;         //  �ʱ�ȭ ��ư ������ �� �����·�
        else begin
            case(STATE)
                S0 : STATE  <=  (ON == 1'b1)    ?   S1  :   S0;
                S1 : STATE  <=  (ON == 1'b1)    ?   S1  :   S0;
                default : STATE <=  STATE;
            endcase
        end
    end
    
    //  count �����ϴ� always��  -   posedge�� negedge�� ���� ��Ʈ�� �ɰ�� �� ���� ���� ǥ��
    always @(clk) begin
        case(STATE)
            S0 : count  <=  6'd0;
            S1 : count  <=  count + 6'd1;
            default : count <=  count;
        endcase
    end
    
    //  music �����ϴ� always��  -   posedge�� negedge�� ���� ��Ʈ�� �ɱ��� count�� ���� �۵��Ѵ�.
    always @(clk) begin
        if(!STATE)    music   <=  OFF;  //  STATE�� S0 �� �� music off �� �����.
        else begin 
            music   <=  mem[count];     //  S1 ������ �� �޸��� count �ε����� ������ ǥ���Ѵ�.
        end
    end

endmodule
