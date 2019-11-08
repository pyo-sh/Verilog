`timescale 1ns / 1ps

module TrafficSignalController_WE(
    input   wire    clk,
    input   wire    nrst,
    input   wire    enable,
    output  reg [2:0]   traffic_light,
    output  reg [1:0]   walk_light
    );
    parameter   S0 = 3'd0,  S1 = 3'd1,  S2 = 3'd2,  S3 = 3'd3;
    parameter  TL_GREEN = 3'b100,
                 TL_YELLOW = 3'b010,
                 TL_RED = 3'b001;
    parameter  WL_GREEN = 2'b10,
                 WL_OFF = 2'b00,
                 WL_RED = 2'b01;
    reg [1:0]  state;
    reg [4:0]  count;
    
    // FSM
    always @(posedge clk or negedge nrst) begin
        if(!nrst)   state   <=    S0;
        else    begin
            case(state)
                S0  :   state   <=  enable  ?   S1  :   S0;
                S1  :   state   <=  (count == 5'd30)    ?   S2  :   S1;
                S2  :   state   <=  (count == 5'd10)    ?   S3  :   S2;
                S3  :   state   <=  (count == 5'd20)    ?   S0  :   S3;
                default :   state   <=  state;
            endcase
        end
    end
    
    // count control
    always @(posedge clk) begin
        case(state)
            S0  :   count   <=  5'd0;
            S1  :   count   <=  (count == 5'd30)    ?   5'd1   :    count + 5'd1;
            S2  :   count   <=  count + 5'd1;
            S3  :   count   <=  count + 5'd1;
            default :   count   <=  count;
        endcase
    end
    
    // traffic_light_led control
    always @(posedge clk) begin
        case(state)
            S0  :   traffic_light   <=  TL_GREEN;
            S1  :   traffic_light   <=  (count == 5'd30)   ?   TL_YELLOW   :   TL_GREEN;
            S2  :   traffic_light   <=  TL_RED;
            default :   traffic_light  <=  traffic_light;
        endcase
    end
    
    // walk_led control
    always @(posedge clk) begin
        case(state)
            S0  :   walk_light  <=  WL_RED;
            S2  :   walk_light  <=  WL_GREEN;
            S3  :   walk_light  <=  walk_light  ^   2'b10;
            default :   walk_light  <=  walk_light;
        endcase
    end
    
endmodule
