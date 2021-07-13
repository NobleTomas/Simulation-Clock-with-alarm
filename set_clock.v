module set_clock (output reg [3:0] s0h0 = 0, s0h1 = 0, s0m0 = 0 , s0m1 = 0,
						input  switch,
						input reset,
						input push2, push3
						);	
// Set minute
always @(posedge reset, negedge push2) begin
	if (reset == 1) begin
			s0m0 <= 0;
			s0m1 <= 0;
	end
	else begin
		if ( (push2 == 0) ) begin
			if(switch == 1) begin
				if ((s0m0 < 4'd9)) begin
					s0m0 <= s0m0 + 1;
					s0m1 <= s0m1;
				end
				else begin
					s0m0 <= 0;
					if (s0m1 < 4'd5)
						s0m1 <= s0m1 + 1;
					else 
						s0m1 <= 0;
				end
			end
			else begin
				s0m0<= s0m0;
				s0m1<= s0m1;
			end
		end
		else begin
	
			s0m0 <= s0m0;
			s0m1 <= s0m1;

		end
	end
end
	
// Set hour
always@(posedge reset, negedge push3) begin
	if (reset == 1) begin
		s0h0 <= 0;
		s0h1 <= 0; 
	end
	else begin
		if(push3 == 0) begin
			if(switch == 1) begin
				if ( (s0h1 <= 4'd1) && ( s0h0 < 4'd9) )
					s0h0 <= s0h0 + 1;
				else if ( (s0h1 == 4'd2) && ( s0h0 < 4'd3) )
					s0h0 <= s0h0 + 1;
				else begin
					s0h0 <= 0;
					if (s0h1 < 4'd2)
						s0h1 <= s0h1 + 1;
					else 
					s0h1 <= 4'd0;
				end
			end
			else begin
				s0h0 <= s0h0;
				s0h1 <= s0h1;
			end
		end
		else begin
			s0h0 <= s0h0;
			s0h1 <= s0h1; 
		end 
	end 
end 
		
endmodule
