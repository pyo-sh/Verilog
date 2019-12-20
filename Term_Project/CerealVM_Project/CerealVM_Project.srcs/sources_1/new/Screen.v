module Screen(                      //  ��ȣ�� ������ ��ũ���� �׸��� ����ϴ� ���
    input   wire    clk,            //  Ŭ�� ��ȣ�̴�.
    input   wire    nrst,           //  �ʱ�ȭ ��ȣ�̴�.
    input   wire    ON,             //  ��ũ���� �Ѿ��ϴ��� �����ϴ��� �˷��ִ� ��ȣ�̴�.
    //  ����ϴ� screen - 3���� ���� : �����̴� ����� �����ֱ� ���԰� ������ ������ �����̴�.
    output  reg[31:0]   screen1,    //  ���� ���� �ø��� �ִ� �׸��� ǥ���� ��ũ���̴�.
    output  reg[31:0]   screen2,    //  ���� ������ �ΰ��ִ� �׸��� ǥ���� ��ũ���̴�.
    output  reg[31:0]   screen3     //  ���� �Ʒ��� ������ �ִ� �׸��� ǥ���� ��ũ���̴�.
    );
    //  ���� �������� -   S0 : screen�� ����� ���� / S1 : screen1�� screen2 ����
    //                  S2 : screen 1, screen 2, screen 3�� ��Ȳ�� ���� ����ϴ� Ư���� ����
    //                  S3 : screen 2�� screen3 ����
    reg[1:0] STATE;
    parameter   S0 = 2'd0,  S1 = 2'd1,  S2 = 2'd2,  S3 = 2'd3;
    //  ���� ���°� ó�� ��µ� �������� �˱� ���� ��������. - ó���� �׸��� �� ������ �ϱ� ����
    reg         is_first;
    //  ������ ��Ÿ���� �������� - ��� �׸��� ����ؾ� �ϴ��� �˾Ƴ��� ���� ��������
    reg[2:0]    order;
    reg[4:0]    count;              // screen2�� index�� ��Ÿ���� count �̴�.
    reg[4:0]    count2;             // screen1�� index�� ��Ÿ���� count2 �̴�.
    //  screen1, screen2, screen3�� ��� ������ ����ִ� �޸��̴�.
    reg[31:0]   mem1[0:31];
    reg[31:0]   mem2[0:31];
    reg[31:0]   mem3[0:31];
    //  screen�� ��µǰ� �����ʴ� ���¸� ��Ÿ����.
    parameter OFF = 32'd0;
    //  screen1�� ���
    parameter First_4   = 32'b00000000000011000000000000000000;
    parameter First_5   = 32'b00000000000011100000000000000000;
    parameter First_6   = 32'b01100000000011110000000000000000;
    parameter First_7   = 32'b01110000000011111000000000000000;
    parameter First_8   = 32'b01110000000001110100000111110000;
    parameter First_9   = 32'b01110000000001111011111100001000;
    parameter First_10  = 32'b01111111111111111001111110000101;
    parameter First_11  = 32'b11111111111100111100111111000011;
    parameter First_12  = 32'b11111111111100011110111111001111;
    parameter First_13  = 32'b00111100111000011111001100001111;
    parameter First_14  = 32'b01111111110001011111000000001111;
    parameter First_15  = 32'b01101111100000010110000000000100;
    parameter First_16  = 32'b01100011000000011100110000000100;
    parameter First_17  = 32'b01100000000000010101111000011100;
    parameter First_18  = 32'b01100000000001011001111000110011;
    parameter First_19  = 32'b00100011000000010011111000111111;
    parameter First_20  = 32'b11100000000000010011111000111101;
    parameter First_21  = 32'b11110000000000110001100001111111;
    parameter First_22  = 32'b01111111111111000100000001111101;
    parameter First_23  = 32'b01110000000001001111111011111000;
    parameter First_24  = 32'b01110000000001011100000111110000;
    parameter First_25  = 32'b01110000000010111000000000000000;
    parameter First_26  = 32'b01100000000011110000000000000000;
    parameter First_27  = 32'b00000000000011100000000000000000;
    parameter First_28  = 32'b00000000000011000000000000000000;
    // screen2�� ���
    parameter Second_3  = 32'b00000000000000000001100000000000;
    parameter Second_4  = 32'b00000000000000000011100000000000;
    parameter Second_5  = 32'b00000000000000000111100000000000;
    parameter Second_6  = 32'b01100000000000000111100000000000;
    parameter Second_7  = 32'b01110000000000001111000000000000;
    parameter Second_8  = 32'b01110000000000011101000111110000;
    parameter Second_9  = 32'b01110000000000111011111100001000;
    parameter Second_10 = 32'b01111111111111111001111110000101;
    parameter Second_11 = 32'b11111111111100111100111111000011;
    parameter Second_12 = 32'b11111111111100011110111111001111;
    parameter Second_13 = 32'b00111100111000011111001100001111;
    parameter Second_14 = 32'b01111111110001011111000000001111;
    parameter Second_15 = 32'b01101111100000010110000000000100;
    parameter Second_16 = 32'b01100011000000011100110000000100;
    parameter Second_17 = 32'b01100000000000010101111000011100;
    parameter Second_18 = 32'b01100000000001011001111000110011;
    parameter Second_19 = 32'b00100011000000010011111000111111;
    parameter Second_20 = 32'b11100000000000010011111000111101;
    parameter Second_21 = 32'b11110000000000110001100001111111;
    parameter Second_22 = 32'b01111111111111100100000001111101;
    parameter Second_23 = 32'b01110000000000100111111011111000;
    parameter Second_24 = 32'b01110000000000010111000111110000;
    parameter Second_25 = 32'b01110000000000001011000000000000;
    parameter Second_26 = 32'b01100000000000000101100000000000;
    parameter Second_27 = 32'b00000000000000000101100000000000;
    parameter Second_28 = 32'b00000000000000000011100000000000;
    parameter Second_29 = 32'b00000000000000000001100000000000;
    // screen3�� ���
    parameter Third_6 = 32'b00001100000000000000000000000000;
    parameter Third_7 = 32'b00001110000000000000000000000000;
    parameter Third_8 = 32'b00001110000000000001111001111000;
    parameter Third_9 = 32'b00001110000000000011001111001000;
    parameter Third_10 = 32'b00001111111111111110000011100101;
    parameter Third_11 = 32'b00011111111111100111100001110011;
    parameter Third_12 = 32'b00011111111111100011111101111111;
    parameter Third_13 = 32'b00000111100111000011111011101111;
    parameter Third_14 = 32'b00001111111110001011111000001111;
    parameter Third_15 = 32'b00001101111100000010110000000100;
    parameter Third_16 = 32'b00001100011000000011100000000100;
    parameter Third_17 = 32'b00001100000000000010100110001100;
    parameter Third_18 = 32'b00001100000000001011001111001111;
    parameter Third_19 = 32'b00000100011000000010001111001111;
    parameter Third_20 = 32'b00011100000000000010011101001101;
    parameter Third_21 = 32'b00011110000000000111100001111111;
    parameter Third_22 = 32'b00001111111111111110000011111101;
    parameter Third_23 = 32'b00001110000000000011001110111000;
    parameter Third_24 = 32'b00001110000000000001111001111000;
    parameter Third_25 = 32'b00001110000000000000000000000000;
    parameter Third_26 = 32'b00001100000000000000000000000000;
    
    //  �ʱ�ȭ ��ȣ�� ������ screen�� ����ؾ��ϴ� ������ �޸𸮿� �����ϴ� always��
    always @(negedge nrst) begin
        mem1[0] = OFF;       mem2[0] = OFF;         mem3[0] = OFF;
        mem1[1] = OFF;       mem2[1] = OFF;         mem3[1] = OFF;
        mem1[2] = OFF;       mem2[2] = Second_3;    mem3[2] = OFF;
        mem1[3] = First_4;   mem2[3] = Second_4;    mem3[3] = OFF;
        mem1[4] = First_5;   mem2[4] = Second_5;    mem3[4] = OFF;
        mem1[5] = First_6;   mem2[5] = Second_6;    mem3[5] = Third_6;
        mem1[6] = First_7;   mem2[6] = Second_7;    mem3[6] = Third_7;
        mem1[7] = First_8;   mem2[7] = Second_8;    mem3[7] = Third_8;
        mem1[8] = First_9;   mem2[8] = Second_9;    mem3[8] = Third_9;
        mem1[9] = First_10;  mem2[9] = Second_10;   mem3[9] = Third_10;
        mem1[10] = First_11; mem2[10] = Second_11;  mem3[10] = Third_11;
        mem1[11] = First_12; mem2[11] = Second_12;  mem3[11] = Third_12;
        mem1[12] = First_13; mem2[12] = Second_13;  mem3[12] = Third_13;
        mem1[13] = First_14; mem2[13] = Second_14;  mem3[13] = Third_14;
        mem1[14] = First_15; mem2[14] = Second_15;  mem3[14] = Third_15;
        mem1[15] = First_16; mem2[15] = Second_16;  mem3[15] = Third_16;
        mem1[16] = First_17; mem2[16] = Second_17;  mem3[16] = Third_17;
        mem1[17] = First_18; mem2[17] = Second_18;  mem3[17] = Third_18;
        mem1[18] = First_19; mem2[18] = Second_19;  mem3[18] = Third_19;
        mem1[19] = First_20; mem2[19] = Second_20;  mem3[19] = Third_20;
        mem1[20] = First_21; mem2[20] = Second_21;  mem3[20] = Third_21;
        mem1[21] = First_22; mem2[21] = Second_22;  mem3[21] = Third_22;
        mem1[22] = First_23; mem2[22] = Second_23;  mem3[22] = Third_23;
        mem1[23] = First_24; mem2[23] = Second_24;  mem3[23] = Third_24;
        mem1[24] = First_25; mem2[24] = Second_25;  mem3[24] = Third_25;
        mem1[25] = First_26; mem2[25] = Second_26;  mem3[25] = Third_26;
        mem1[26] = First_27; mem2[26] = Second_27;  mem3[26] = OFF;
        mem1[27] = First_28; mem2[27] = Second_28;  mem3[27] = OFF;
        mem1[28] = OFF;      mem2[28] = Second_29;  mem3[28] = OFF;
        mem1[29] = OFF;      mem2[29] = OFF;        mem3[29] = OFF;
        mem1[30] = OFF;      mem2[30] = OFF;        mem3[30] = OFF;
        mem1[31] = OFF;      mem2[31] = OFF;        mem3[31] = OFF;
    end

    //  STATE �����ϴ� ����   -   ON�� ��ȣ�� ������ STATE�� ��ȯ�ǰ� count�� ������ order(����)�� ���ؼ� �ٲ��.
    always @(clk or nrst) begin
        if(!nrst)   STATE   <=  S0;
        else begin
            if(ON)  begin
                case(STATE)
                    //  ��ȣ�� ���� ���� �׳� S1���� ��������
                    S0 : STATE  <=  S1;
                    S1 : STATE  <=  (count == 5'd14)   ?   S2  :   S1;
                    S2 : STATE  <=  (count2 == 5'd14)   ?   ((order < 3'd3)  ?   S1  :   S3)    :   S2;
                    S3 : STATE  <=  (count == 5'd14)   ?   S2  :   S3;
                    default : STATE <=  STATE;
                endcase
            end
            else    STATE   <=  S0;
        end
    end
    
    //  order�� �����ϴ� ����  -   (order�� �׸� ��� ������ ��Ÿ����) �� 8���� ������ �ִ�.
    always @(clk) begin
        case(STATE)
            S0 : order  <=  3'd0;
            S2 : order  <=  (count2 == 5'd13)   ?   order + 3'd1    :   order;
            default :   order   <=  (count == 5'd13)    ?   order + 3'd1    :   order;
        endcase
    end
    
    //  is_first�� �����ϴ� always���� -   ó�� �����ߴ����� ���� üũ���ִ� always���̴�.
    always @(clk) begin
        case(STATE)
            S0 : is_first   <=  1'd1;
            S1 : is_first   <=  (is_first)  ?   ((count2 ==  5'd13) ?   1'd0    :   1'd1) :   1'd0;
            default : is_first    <=  1'd0;
        endcase
    end
    
    //  ù ��° screen1�� �� ��° screen3�� count ���� (�ΰ��� ��ũ�� �´´�.)
    always @(clk) begin
        case(STATE)
            S0 : count <=  5'd0;
            default : count <=  count + 5'd1;
        endcase
    end
    
    //  �� ��° screen count2 ����
    always @(clk) begin
        case(STATE)
            S0 : count2 <=  5'd16;
            default : count2 <=  count2 + 5'd1;
        endcase
    end
    
    //  ù ��° screen1 ����
    always @(clk) begin
        case(STATE)
            S0 : screen1    <=  OFF;
            S1 : screen1    <=  mem1[count];
            S2 : screen1    <=  (order < 3'd4)  ?   mem1[count] :   OFF;
            S3 : screen1    <=  OFF;
            default : screen1   <=  screen1;
        endcase
    end
  
    //  �� ��° screen2 ����
    always @(clk) begin
        case(STATE)
            S0 : screen2    <=  OFF;
            S1 : screen2    <=  (is_first)  ?   OFF :   mem2[count2];
            S2 : screen2    <=  mem2[count2];
            S3 : screen2    <=  mem2[count2];
            default : screen2   <=  screen2;
        endcase
    end
    
    //  �� ��° screen3 ����
    always @(clk) begin
        case(STATE)
            S0 : screen3    <=  OFF;
            S1 : screen3    <=  OFF;
            S2 : screen3    <=  (order < 3'd4)  ?   OFF :   mem3[count];
            S3 : screen3    <=  mem3[count];
            default : screen3   <=  screen3;
        endcase
    end
    
endmodule
