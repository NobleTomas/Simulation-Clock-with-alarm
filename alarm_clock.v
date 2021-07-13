module alarm_clock (
							output [6:0] lh0, lh1, lm0, lm1, ls0, ls1,
							output reg [7:0] ledg,
							input clk50, set_clock, push2, push3,
							input [5:0] switch
						 );
						 
// Internal wires and regs						 
wire clk1;
reg [3:0] h0 = 0, h1 = 0, m0 = 0, m1 = 0, s0 = 0, s1 = 0;
reg [3:0] th0 = 0, th1 = 0, tm0 = 0, tm1 = 0;
wire [3:0] s0h0, s0h1, s0m0, s0m1;
wire [3:0] s1h0, s1h1, s1m0, s1m1;
wire [3:0] s2h0, s2h1, s2m0, s2m1;
wire [3:0] s3h0, s3h1, s3m0, s3m1;
wire [3:0] s4h0, s4h1, s4m0, s4m1;
wire [3:0] s5h0, s5h1, s5m0, s5m1;
wire [3:0] fs0, fs1, fm0, fm1, fh0, fh1;

// Clock generator
clock_50_to_01 clockgenerator ( .clk_i(clk50), .clk_o(clk1) );

// Set-clock modules
set_clock  c1(.s0h0(s0h0), .s0h1(s0h1), .s0m0(s0m0), .s0m1(s0m1), .switch(switch[0]), .push2(push2), .push3(push3), .reset(switch[5]));
set_clock1 c2(.s1h0(s1h0), .s1h1(s1h1), .s1m0(s1m0), .s1m1(s1m1), .switch(switch[1]), .push2(push2), .push3(push3), .reset(switch[5]));
set_clock2 c3(.s2h0(s2h0), .s2h1(s2h1), .s2m0(s2m0), .s2m1(s2m1), .switch(switch[2]), .push2(push2), .push3(push3), .reset(switch[5]));
set_clock3 c4(.s3h0(s3h0), .s3h1(s3h1), .s3m0(s3m0), .s3m1(s3m1), .switch(switch[3]), .push2(push2), .push3(push3), .reset(switch[5]));
set_clock4 c5(.s4h0(s4h0), .s4h1(s4h1), .s4m0(s4m0), .s4m1(s4m1), .switch(switch[4]), .push2(push2), .push3(push3), .reset(switch[5]));
set_clock5 c6(.s5h0(s5h0), .s5h1(s5h1), .s5m0(s5m0), .s5m1(s5m1), .switch(set_clock), .push2(push2), .push3(push3), .reset(switch[5]));

// Counter for main clock
always @(posedge clk1) 
begin
	if (set_clock == 1) begin
		s0 <= s0;
		s1 <= s1;
		m0 <= s5m0;
		m1 <= s5m1;
		h0 <= s5h0;
		h1 <= s5h1;
	end
	else begin
		if (s0 < 4'd9)
			s0 <= s0 + 1;
		else begin
			s0 <= 4'd0;
			if (s1 < 4'd5)
				s1 <= s1 + 1;
			else begin
				s1 <= 4'd0;
				if (m0 < 4'd9)
					m0 <= m0 + 1;
				else begin
					m0 <= 4'd0;
					if (m1 < 4'd5)
						m1 <= m1 + 1;
					else begin
						m1 <= 4'd0;
						if ( (h1 <= 4'd1) && ( h0 < 4'd9) )
							h0 <= h0 + 1;
						else if ( (h1 == 2) && ( h0 < 4'd3) )
							h0 <= h0 + 1;
						else begin
							h0 <= 0;
							if (h1 < 4'd2)
								h1 <= h1 + 1;
							else 
								h1 <= 4'd0;
						end
					end
				end
			end
		end
	end
	
	// Comparision between alarm time and real time
	if(((m0 == s0m0) && (m1 == s0m1) && (h0 == s0h0) && (h1 == s0h1))||
		((m0 == s1m0) && (m1 == s1m1) && (h0 == s1h0) && (h1 == s1h1))||
		((m0 == s2m0) && (m1 == s2m1) && (h0 == s2h0) && (h1 == s2h1))||
		((m0 == s3m0) && (m1 == s3m1) && (h0 == s3h0) && (h1 == s3h1))||
		((m0 == s4m0) && (m1 == s4m1) && (h0 == s4h0) && (h1 == s4h1)))
		begin
			ledg <= 8'b11111111;
		end
	else begin
		ledg <= 0;
	end
	
	
end


// Select units to be displayed (switch-depending)
assign fs0 = (switch[0] || switch[1] || switch[2] || switch[3] || switch[4] || set_clock ) ? 4'b0000 : s0 ;
assign fs1 = (switch[0] || switch[1] || switch[2] || switch[3] || switch[4] || set_clock ) ? 4'b0000 : s1 ;
assign fm0 = (switch[0]) ? s0m0 : ( 
				 (switch[1]) ? s1m0 : (
				 (switch[2]) ? s2m0 : (
				 (switch[3]) ? s3m0 : (
				 (switch[4]) ? s4m0 : (
				 m0
))))); 
assign fm1 = (switch[0]) ? s0m1 : ( 
				 (switch[1]) ? s1m1 : (
				 (switch[2]) ? s2m1 : (
				 (switch[3]) ? s3m1 : (
				 (switch[4]) ? s4m1 : (
				 m1
)))));
assign fh0 = (switch[0]) ? s0h0 : ( 
				 (switch[1]) ? s1h0 : (
				 (switch[2]) ? s2h0 : (
				 (switch[3]) ? s3h0 : (
				 (switch[4]) ? s4h0 : (
				 h0
)))));
assign fh1 = (switch[0]) ? s0h1 : ( 
				 (switch[1]) ? s1h1 : (
				 (switch[2]) ? s2h1 : (
				 (switch[3]) ? s3h1 : (
				 (switch[4]) ? s4h1 : (
				 h1
)))));

// led7seg_decoder 
led7_decoder led0( .led7seg(ls0), .enable(1'b1), .BCD(fs0) );
led7_decoder led1( .led7seg(ls1), .enable(1'b1), .BCD(fs1) );
led7_decoder led2( .led7seg(lm0), .enable(1'b1), .BCD(fm0) );
led7_decoder led3( .led7seg(lm1), .enable(1'b1), .BCD(fm1) );
led7_decoder led4( .led7seg(lh0), .enable(1'b1), .BCD(fh0) );
led7_decoder led5( .led7seg(lh1), .enable(1'b1), .BCD(fh1) );




endmodule 