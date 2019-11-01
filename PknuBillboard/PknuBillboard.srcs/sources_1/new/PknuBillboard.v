module PknuBillboard(
    input   wire    clk,
    input   wire    nrst,
    input   wire    enable,
    output  reg     [4:0] LedOut
);
    parameter   S0  =   1'b0;
    parameter   S1  =   1'b1;
    
    reg state;
    reg [3:0]   count;
    // FSM
    always @(posedge clk or negedge nrst) begin
        if(!nrst)   state   <=  S0;
        else    begin
            case(state)
                S0: state   <=  enable  ?   S1  :   S0;
                S1: state   <=  (count == 4'd15) ?   S0  :   S1;
                default :   state   <=  state;
            endcase
        end
    end
    // count
    always @(posedge clk) begin
        case(state)
            S0: count   <=  4'd0;
            S1: count   <=  count   +   4'd1;
            default:    count   <=  count;
        endcase
    end
    // led_control
    always @(posedge clk) begin
        case(state)
            S0: LedOut  <=  5'b00000;
            S1: LedOut  <=  (count >= 5)    ?   ~LedOut :   LedOut + (1 << count);
            default:    LedOut  <=  LedOut;
        endcase
    end
endmodule
