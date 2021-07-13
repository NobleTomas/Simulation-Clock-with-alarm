module set_clock3 (output reg [3:0] s3h0 = 0, s3h1 = 0, s3m0 = 0, s3m1 = 0,
						input  switch,
						input reset,
						input push2, push3
						);	

always @(posedge reset, negedge push2) begin
	if (reset == 1) begin
			s3m0 <= 0;
			s3m1 <= 0;
	end
	else begin
		if ( (push2 == 0) ) begin
			if(switch == 1) begin
				if ((s3m0 < 4'd9)) begin
					s3m0 <= s3m0 + 1;
					s3m1 <= s3m1;
				end
				else begin
					s3m0 <= 0;
					if (s3m1 < 4'd5)
						s3m1 <= s3m1 + 1;
					else 
						s3m1 <= 0;
				end
			end
			else begin
				s3m0<= s3m0;
				s3m1<= s3m1;
			end
		end
		else begin
	
			s3m0 <= s3m0;
			s3m1 <= s3m1;

		end
	end
end

always@(posedge reset, negedge push3) begin
	if (reset == 1) begin
		s3h0 <= 0;
		s3h1 <= 0; 
	end
	else begin
		if(push3 == 0) begin
			if(switch == 1) begin
				if ( (s3h1 <= 4'd1) && ( s3h0 < 4'd9) )
					s3h0 <= s3h0 + 1;
				else if ( (s3h1 == 4'd2) && ( s3h0 < 4'd3) )
					s3h0 <= s3h0 + 1;
				else begin
					s3h0 <= 0;
					if (s3h1 < 4'd2)
						s3h1 <= s3h1 + 1;
					else 
						s3h1 <= 4'd0;
				end
			end
			else begin
				s3h0 <= s3h0;
				s3h1 <= s3h1;
			end
		end 
		else begin
			s3h0 <= s3h0;
			s3h1 <= s3h1; 
		end 	
	end 
end 	
	
endmodule
