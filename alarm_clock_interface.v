module alarm_clock_interface (SW, KEY, CLOCK_50, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
										LEDG, GPIO);
	input [17:0] SW;
	input [3:2] KEY;
	output [7:0] LEDG;
	input CLOCK_50;
	output [6:0] HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	output [1:0]GPIO;
	
alarm_clock alarm(   .clk50(CLOCK_50),
							.set_clock(SW[17]),
							.push2(KEY[2]),
							.push3(KEY[3]),
							.ls0(HEX2),
							.ls1(HEX3),
							.lm0(HEX4),
							.lm1(HEX5),
							.lh0(HEX6),
							.lh1(HEX7),
							.ledg(LEDG[7:0]),
							.switch(SW[5:0]),
							);


assign GPIO[1]=GPIO[0];
endmodule 