module SimpleAlarm(
    input   wire    clk,
    input   wire    nrst,
    input   wire    enable,
    input   wire    [7:0] TIME,
    output  reg     Alarm
);
    parameter S0 = 1'b0;
    parameter S1 = 1'b1;
    
    reg [7:0]   count;
    reg state;
    // state value
    always @(posedge clk or negedge nrst) begin
        if(!nrst)      state    <=   S0;
        else    begin
            case(state)
                S0: if(enable)  state   <=   S1;
                S1: if(count == TIME)   state   <=   S0;
            endcase
        end
    end
    // count value
    always @(posedge clk) begin
        case(state)
            S0: count   <=  8'd0; 
            S1: count   <=  count + 8'd1;
        endcase
    end
    // alarm value
    always @(posedge clk) begin
        case(state)
            S0: Alarm <= 1'b0;
            S1: if(count == TIME) Alarm <= 1'b1;
        endcase
    end
endmodule
