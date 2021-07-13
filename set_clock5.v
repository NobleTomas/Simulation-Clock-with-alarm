module set_clock5 (output reg [3:0] s5h0, s5h1, s5m0, s5m1,
						input switch,
						input reset,
						input push2, push3
						);	
// Set minute
always @(posedge reset, negedge push2) begin
	if (reset == 1) begin
			s5m0 <= 0;
			s5m1 <= 0;
	end
	else begin
		if ( (push2 == 0) ) begin
			if(switch == 1) begin
				if ((s5m0 < 4'd9)) begin
					s5m0 <= s5m0 + 1;
					s5m1 <= s5m1;
				end
				else begin
					s5m0 <= 0;
					if (s5m1 < 4'd5)
						s5m1 <= s5m1 + 1;
					else 
						s5m1 <= 0;
				end
			end
			else begin
				s5m0<= s5m0;
				s5m1<= s5m1;
			end
		end			
		else begin
	
			s5m0 <= s5m0;
			s5m1 <= s5m1;

		end
	end
end

// Set hour
always@(posedge reset, negedge push3) begin
	if (reset == 1) begin
		s5h0 <= 0;
		s5h1 <= 0; 
	end
	else begin
		if(push3 == 0) begin
			if(switch == 1) begin
				if ( (s5h1 <= 4'd1) && ( s5h0 < 4'd9) )
					s5h0 <= s5h0 + 1;
				else if ( (s5h1 == 4'd2) && ( s5h0 < 4'd3) )
					s5h0 <= s5h0 + 1;
				else begin
					s5h0 <= 0;
					if (s5h1 < 4'd2)
						s5h1 <= s5h1 + 1;
					else 
						s5h1 <= 4'd0;
				end
			end
			else begin
				s5h0 <= s5h0;
				s5h1 <= s5h1;
			end
		end 
		else begin
			s5h0 <= s5h0;
			s5h1 <= s5h1; 
		end
		
	end
end
	
endmodule
