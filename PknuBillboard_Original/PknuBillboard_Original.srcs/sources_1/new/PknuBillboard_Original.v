module PknuBillboard_Original(
    input   wire    clk,
    input   wire    nrst,
    input   wire    enable,
    output  reg     [4:0] LedOut
    );
    parameter   S0  =   3'd0,   S1  =   3'd1,   S2  =   3'd2,   S3  =   3'd3, S4 =   3'd4,   S5  =   3'd5,   S6  =   3'd6;
    reg [2:0]   state;
    reg [2:0]   count;
    // FSM
    always @(posedge clk or negedge nrst) begin
        if(!nrst)   state   <=  S0;
        else    begin
            case(state)
                S0: state   <=  enable  ?   S1  :   S0;
                S1: state   <=  S2;
                S2: state   <=  S3;
                S3: state   <=  S4;
                S4: state   <=  S5;
                S5: state   <=  S6;
                S6: state   <=  (count  ==  3'd5)   ?   S0  :   S5;
                default:    state   <=  state;
            endcase
        end
    end
    // count
    always @(posedge clk) begin
        case(state)
            S0: count   <=  3'd0;
            S6: count   <=  count + 3'd1;
            default:    count   <=  count;
        endcase
    end
    // led_out control
    always @(posedge clk) begin
        case(state)
            S0: LedOut  <=  5'b00000;
            S1: LedOut  <=  5'b00001;
            S2: LedOut  <=  5'b00011;
            S3: LedOut  <=  5'b00111;
            S4: LedOut  <=  5'b01111;
            S5: LedOut  <=  5'b11111;
            S6: LedOut  <=  5'b00000;
            default:    LedOut  <=  LedOut;
        endcase
    end
endmodule
