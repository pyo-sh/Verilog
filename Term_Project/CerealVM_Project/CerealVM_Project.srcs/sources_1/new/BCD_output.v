module BCD_output(
    input   wire[7:0]   MONEY,  // ��ȯ��ų 2����
    output  reg [15:0]  BCD     // ��ȯ�� BCD
    );
    reg [3:0]   down;           // MONEY[8]���� BCD�� ��ȯ�ذ��� ��������.
    reg [3:0]   up;             // ��ȯ �Ϸ��  ��Ʈ�� ���� 4��Ʈ
    integer i;
    
    always @(*) begin                                             
        up      = 4'b0;
        BCD     = 16'h0;                                          
        down    = MONEY[7:5];                                     // ��ȯ�� MONEY�� �ִ� 99(8'b01100011) �̱� ������
//                                                                   ���� 3��Ʈ�� 4'd5���� �׻� �۴�
//                                                                   ���� 3��Ʈ�� ���� ( ���� 3��Ʈ(3'b011) < 4'd5 ) 
        //up�� 4��Ʈ�� ä������ ����                              // ���� 4��Ʈ�� BCD�ڵ�� ġȯ�ϴ� �ݺ���
        for(i=4;i>0;i=i-1) begin                                  // if down >= 5 , then down += 3
            down    = (down<<1'b1)      +  MONEY[i];             
            down    = (down >= 4'd5)    ? down + 4'd3 : down;
            up      = (up<<1'b1)        + down[3];                // ��ȯ �Ϸ�� ��Ʈ�� up���� �Ѱ��ش�.
        end                                                       // �ݺ����� 4ȸ ����, up�� 4��Ʈ�� ��� ä������ �ݺ����� ����ȴ�.
        down = (down<<1'b1) + MONEY[0];                           // ���� 4��Ʈ �ϼ�
        
        BCD[15:12] = up;                                          // ��ȯ �Ϸ�� ���� 4��Ʈ
        BCD[11:8] = down;                                         // ��ȯ �Ϸ�� ���� 4��Ʈ
    end
    
endmodule