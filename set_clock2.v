module set_clock2 (output reg [3:0] s2h0 = 0, s2h1 = 0, s2m0 = 0, s2m1 = 0,
						input switch,
						input reset,
						input push2, push3
						);	

always @(posedge reset, negedge push2) begin
	if (reset == 1) begin
			s2m0 <= 0;
			s2m1 <= 0;
	end
	else begin
		if ( (push2 == 0) ) begin
			if(switch == 1) begin
				if ((s2m0 < 4'd9)) begin
					s2m0 <= s2m0 + 1;
					s2m1 <= s2m1;
				end
				else begin
					s2m0 <= 0;
					if (s2m1 < 4'd5)
						s2m1 <= s2m1 + 1;
					else 
						s2m1 <= 0;
				end
			end
			else begin
				s2m0<= s2m0;
				s2m1<= s2m1;
			end
		end
		else begin
	
			s2m0 <= s2m0;
			s2m1 <= s2m1;

		end
	end
end

always@(posedge reset, negedge push3) begin
	if (reset == 1) begin
		s2h0 <= 0;
		s2h1 <= 0; 
	end
	else begin
		if(push3 == 0) begin
			if(switch == 1) begin
				if ( (s2h1 <= 4'd1) && ( s2h0 < 4'd9) )
					s2h0 <= s2h0 + 1;
				else if ( (s2h1 == 4'd2) && ( s2h0 < 4'd3) )
					s2h0 <= s2h0 + 1;
				else begin
					s2h0 <= 0;
					if (s2h1 < 4'd2)
						s2h1 <= s2h1 + 1;
					else 
						s2h1 <= 4'd0;
				end
			end
			else begin
				s2h0 <= s2h0;
				s2h1 <= s2h1;
			end
		end 
		else begin
			s2h0 <= s2h0;
			s2h1 <= s2h1; 
		end 
	end 
end 
		
endmodule
