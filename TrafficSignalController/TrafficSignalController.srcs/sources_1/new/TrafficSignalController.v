`timescale 1ns / 1ps

module TrafficSignalController(
    input   wire    clk,
    input   wire    nrst,
    input   wire    enable,
    output  reg    [2:0]    traffic_light,
    output  reg    [1:0]    walk_light
    );
    parameter   S0 = 3'd0,  S1 = 3'd1,  S2 = 3'd2,
                 S3 = 3'd3,  S4 = 3'd4,  S5 = 3'd5;
    parameter  TL_GREEN = 3'b100,
                 TL_YELLOW = 3'b010,
                 TL_RED = 3'b001;
    parameter  WL_GREEN = 2'b10,
                 WL_OFF = 2'b00,
                 WL_RED = 2'b01;
    reg [2:0]  state;
    reg [4:0]  count;
    
    // FSM
    always @(posedge clk or negedge nrst) begin
        if(!nrst)   state <= S0;
        else    begin
            case(state)
                S0  :   state   <=  enable  ?   S1  :   S0;
                S1  :   state   <=  (count == 5'd30)    ?   S2  :   S1;
                S2  :   state   <=  S3;
                S3  :   state   <=  (count == 5'd10)    ?   S4  :   S3;
                S4  :   state   <=  S5;
                S5  :   state   <=  (count == 5'd20)    ?   S0  :   S4;
                default :   state   <=  state;
            endcase
        end
    end
    
    // count control
    always @(posedge clk) begin
        case(state)
            S0  :   count   <=  5'd1;
            S1  :   count   <=  (count == 5'd30)    ?   5'd1    :   count + 5'd1;
            S3  :   count   <=  count + 5'd1;
            S4  :   count   <=  count + 5'd1;
            S5  :   count   <=  count + 5'd1;
            default :   count  <=  count;
        endcase
    end
    
    // traffic_led control
    always @(posedge clk) begin
        case(state)
            S0  :   traffic_light   <=  TL_GREEN;
            S2  :   traffic_light   <=  TL_YELLOW;
            S3  :   traffic_light   <=  TL_RED;
            default :   traffic_light  <=  traffic_light;
        endcase
    end
    
    // walk_led control
    always @(posedge clk) begin
        case(state)
            S0  :   walk_light  <=  WL_RED;
            S3  :   walk_light  <=  WL_GREEN;
            S4  :   walk_light  <=  WL_OFF;
            S5  :   walk_light  <=  WL_GREEN;
            default :   walk_light  <=  walk_light;
        endcase
    end
    
endmodule
