module BCD_output(
    input   wire[7:0]   MONEY,  // 변환시킬 2진수
    output  reg [15:0]  BCD     // 변환된 BCD
    );
    reg [3:0]   down;           // MONEY[8]부터 BCD로 변환해가며 내려간다.
    reg [3:0]   up;             // 변환 완료된  비트의 상위 4비트
    integer i;
    
    always @(*) begin                                             
        up      = 4'b0;
        BCD     = 16'h0;                                          
        down    = MONEY[7:5];                                     // 변환될 MONEY는 최대 99(8'b01100011) 이기 때문에
//                                                                   상위 3비트는 4'd5보다 항상 작다
//                                                                   상위 3비트를 대입 ( 상위 3비트(3'b011) < 4'd5 ) 
        //up에 4비트가 채워지면 종료                              // 상위 4비트를 BCD코드로 치환하는 반복문
        for(i=4;i>0;i=i-1) begin                                  // if down >= 5 , then down += 3
            down    = (down<<1'b1)      +  MONEY[i];             
            down    = (down >= 4'd5)    ? down + 4'd3 : down;
            up      = (up<<1'b1)        + down[3];                // 변환 완료된 비트를 up으로 넘겨준다.
        end                                                       // 반복문이 4회 돌면, up에 4비트가 모두 채워지고 반복문이 종료된다.
        down = (down<<1'b1) + MONEY[0];                           // 하위 4비트 완성
        
        BCD[15:12] = up;                                          // 변환 완료된 상위 4비트
        BCD[11:8] = down;                                         // 변환 완료된 하위 4비트
    end
    
endmodule