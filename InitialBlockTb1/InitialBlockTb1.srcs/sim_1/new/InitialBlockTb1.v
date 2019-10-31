`timescale 1ns / 1ps

module InitialBlockTb1;
	reg clk_20ns;
	reg clk_40ns;
	initial begin
		#0	clk_20ns = 1'b0;
		#0	clk_40ns = 1'b0;
	end
	always #20 begin
	   clk_40ns = ~clk_40ns;
	end
	always begin
		#10	clk_20ns = ~clk_20ns;
	end
endmodule
