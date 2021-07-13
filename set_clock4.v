module set_clock4 (output reg [3:0] s4h0 = 0, s4h1 = 0, s4m0 = 0, s4m1 = 0,
						input  switch,
						input reset,
						input push2, push3
						);	

always @(posedge reset, negedge push2) begin
	if (reset == 1) begin
			s4m0 <= 0;
			s4m1 <= 0;
	end
	else begin
		if ( (push2 == 0) ) begin
			if(switch == 1) begin
				if ((s4m0 < 4'd9)) begin
					s4m0 <= s4m0 + 1;
					s4m1 <= s4m1;
				end
				else begin
					s4m0 <= 0;
					if (s4m1 < 4'd5)
						s4m1 <= s4m1 + 1;
					else 
						s4m1 <= 0;
				end
			end
			else begin
				s4m0<= s4m0;
				s4m1<= s4m1;
			end
		end
		else begin
			s4m0 <= s4m0;
			s4m1 <= s4m1;
		end
	end
end

always@(posedge reset, negedge push3) begin
	if (reset == 1) begin
		s4h0 <= 0;
		s4h1 <= 0; 
	end
	else begin
		if(push3 == 0) begin
			if(switch == 1) begin
				if ( (s4h1 <= 4'd1) && ( s4h0 < 4'd9) )
					s4h0 <= s4h0 + 1;
				else if ( (s4h1 == 4'd2) && ( s4h0 < 4'd3) )
					s4h0 <= s4h0 + 1;
				else begin
					s4h0 <= 0;
					if (s4h1 < 4'd2)
						s4h1 <= s4h1 + 1;
					else 
						s4h1 <= 4'd0;
				end
			end
			else begin
				s4h0 <= s4h0;
				s4h1 <= s4h1;
			end
		end
		else begin
			s4h0 <= s4h0;
			s4h1 <= s4h1; 
		end 
		
	end
end 
		
endmodule
