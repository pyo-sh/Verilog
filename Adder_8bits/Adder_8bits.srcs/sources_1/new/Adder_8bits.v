module Adder_8bits(
    output  reg [7:0]   OUT,
    input   wire    [7:0]   IN1,
    input   wire    [7:0]   IN2,
    input   wire    [7:0]   IN3
);

always @(*) begin
    OUT <=  IN1 +   IN2 +   IN3;
end

endmodule

