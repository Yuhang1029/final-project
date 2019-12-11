module mux_choose (ADDR, clk, j, key_p, key_in, score);

input clk;
input[18:0] ADDR;
reg [9:0] x_now,  y_now, x_p, y_p, x_n, y_n;
input key_p;
input [7:0] key_in;
reg[1:0] j;
reg clk_out;
output[1:0] j;
integer index, k, kk, random;

reg [7:0] score, score_shi, score_ge;
wire [7:0] result_score;
output [7:0] score;

reg freeze;
reg [2:0] c;
reg [1:0] r;
wire[1:0] rr;
reg [15:0] x, y, x1, y1, x2, y2, x3, y3, x4, y4;
wire [15:0] yr;
reg [15:0] back[15:0];
reg [4:0] number[14:0];
reg[30:0] counter;

skeleton_pro s1(clk, 0, score, result_score, y, yr, r, rr);

integer t;

initial
begin
	
	for(t = 0; t < 16; t = t + 1)
	begin
		back[t] = 16'b0;
	end
		
	for(t = 0; t < 15; t = t + 1)
	begin
		number[t] = 5'b0;
	end

	c = 3'b000;
	x = 16'b0;
	y = 16'b0;
	r = 2'b00;
	counter = 12000000;
	score = 0;
	random = 17;
	freeze = 0;
end


always @ (posedge clk_out)
begin
	

	if(score >= 10)
	begin
		number[1][1] = 1;
	end
	
	if (score >= 20)
	begin
		number[1][3] = 1;
	end
	


	if (score % 10 == 0)
	begin
	
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
		number[6][1] = 1;	
		number[7][1] = 1;
		number[8][1] = 1;
		number[9][1] = 1;
		number[10][1] = 1;
		number[6][2] = 1;
		number[10][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 1)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;
		number[6][2] = 1;	
		number[7][2] = 1;
		number[8][2] = 1;
		number[9][2] = 1;
		number[10][1] = 1;
		number[10][2] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 2)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[6][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][1] = 1;
		number[8][2] = 1;
		number[8][3] = 1;
		number[9][1] = 1;
		number[10][1] = 1;
		number[10][2] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 3)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[6][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][1] = 1;
		number[8][2] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][1] = 1;
		number[10][2] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 4)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[7][1] = 1;
		number[8][1] = 1;
		number[8][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 5)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[6][2] = 1;
		number[6][3] = 1;
		number[7][1] = 1;
		number[8][1] = 1;
		number[8][2] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][1] = 1;
		number[10][2] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 6)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[7][1] = 1;
		number[8][1] = 1;
		number[9][1] = 1;
		number[10][1] = 1;
		number[6][2] = 1;
		number[8][2] = 1;
		number[10][2] = 1;
		number[6][3] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 7)
	begin
	
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
		
		number[6][1] = 1;	
		number[6][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][2] = 1;
		number[9][2] = 1;
		number[10][2] = 1;
	end
	
	else if (score % 10 == 8)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[7][1] = 1;
		number[8][1] = 1;
		number[9][1] = 1;
		number[10][1] = 1;
		number[6][2] = 1;
		number[8][2] = 1;
		number[10][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][3] = 1;
	end
	
	else if (score % 10 == 9)
	begin
		for(t = 5; t < 12; t = t + 1)
		begin
			number[t] = 5'b0;
		end
	
		number[6][1] = 1;	
		number[7][1] = 1;
		number[8][1] = 1;
		number[10][1] = 1;
		number[6][2] = 1;
		number[8][2] = 1;
		number[10][2] = 1;
		number[6][3] = 1;
		number[7][3] = 1;
		number[8][3] = 1;
		number[9][3] = 1;
		number[10][3] = 1;
	end
	
	
end

always @ (posedge clk)
begin
	if(index < counter)
	begin
		index = index + 1;
	end
	
	else
	begin
		index = 0;
		clk_out = ~clk_out;
	end;
end



always @ (*)
begin
	if(c == 3'b000)
	begin
		x4 = x;
		y4 = y;
		
		x1 = x + 30;
		y1 = y;
		
		x2 = x;
		y2 = y + 30;
		
		x3 = x + 30;
		y3 = y + 30;
	end
	
	if(c == 3'b001)
	begin
		if((r == 2'b00) || (r == 2'b10))
		begin
			x4 = x;
			y4 = y;
		
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 60;
			y2 = y;
		
			x3 = x + 90;
			y3 = y;
		end
		
		if((r == 2'b01) || (r == 2'b11))
		begin
			x4 = x;
			y4 = y;
		
			x1 = x;
			y1 = y + 30;
		
			x2 = x;
			y2 = y + 60;
		
			x3 = x;
			y3 = y + 90;
		end
	end
	
	if(c == 3'b010)
	begin
		if((r == 2'b00) || (r == 2'b10))
		begin
			x4 = x;
			y4 = y;
		
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x + 60;
			y3 = y + 30;
		end
		
		if((r == 2'b01) || (r == 2'b11))
		begin
			x4 = x + 30;
			y4 = y;
		
			x1 = x;
			y1 = y + 30;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x;
			y3 = y + 60;
		end
	end
	
	if(c == 3'b011)
	begin
		if(r == 2'b00)
		begin
			x4 = x;
			y4 = y;
		
			x1 = x;
			y1 = y + 30;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x + 60;
			y3 = y + 30;
		end
		
		if(r == 2'b01)
		begin
			x4 = x;
			y4 = y;
		
			x1 = x;
			y1 = y + 30;
		
			x2 = x;
			y2 = y + 60;
		
			x3 = x + 30;
			y3 = y;
		end
		
		if(r == 2'b10)
		begin
			x4 = x;
			y4 = y;
		
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 60;
			y2 = y;
		
			x3 = x + 60;
			y3 = y + 30;
		end
		
		if(r == 2'b11)
		begin
			x4 = x;
			y4 = y + 60;
		
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x + 30;
			y3 = y + 60;
		end
	end
	
	if(c == 3'b100)
	begin
		if(r == 2'b00)
		begin
			x4 = x + 30;
			y4 = y;
	
			x1 = x;
			y1 = y + 30;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x + 60;
			y3 = y + 30;
		end
		
		if(r == 2'b01)
		begin
			x4 = x;
			y4 = y;
	
			x1 = x + 30;
			y1 = y + 30;
		
			x2 = x;
			y2 = y + 30;
		
			x3 = x;
			y3 = y + 60;
		end
		
		if(r == 2'b10)
		begin
			x4 = x;
			y4 = y;
	
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 60;
			y2 = y;
		
			x3 = x + 30;
			y3 = y + 30;
		end
		
		if(r == 2'b11)
		begin
			x4 = x;
			y4 = y + 30;
	
			x1 = x + 30;
			y1 = y;
		
			x2 = x + 30;
			y2 = y + 30;
		
			x3 = x + 30;
			y3 = y + 60;
		end
	end
end



always @ (posedge clk_out)
begin
	if(back[0] == 16'b0)
	begin
		
	end
	
	else
	begin
		freeze = 1;
	end
		
	
	if(freeze == 0)
	begin
		if((y4 + 30 < 480) && (y1 + 30 < 480) && (y2 + 30 < 480) && (y3 + 30 < 480)
		&& (back[y4 / 30 + 1][x4 / 30] == 0) && (back[y1 / 30 + 1][x1 / 30] == 0) && (back[y2 / 30 + 1][x2 / 30] == 0) && (back[y3 / 30 + 1][x3 / 30] == 0))
		begin
			y = yr;
		end
		
		else
		begin
			random = (random * 11 + r - c) % 19;
			back[y4 / 30][x4 / 30] = 1;
			back[y1 / 30][x1 / 30] = 1;
			back[y2 / 30][x2 / 30] = 1;
			back[y3 / 30][x3 / 30] = 1;	
			c = (c + random + x * 3) % 5;
			y = 16'b0;
				
		end
	end
	
	for(k = 15; k > 0; k = k - 1)
	begin
		if(back[k] == 16'b1111111111111111)
		begin
			score = result_score;
			if(score == 3)
			begin
				counter = 7000000;
			end
			
			back[0] = 16'b0;
			for(kk = k; kk > 0; kk = kk - 1)
			begin
				back[kk] = back[kk - 1];
			end
		end
	end
end


always @ (negedge key_p)
begin
	if(key_in == 8'h75)
	begin
		r = rr % 4;
	end
end


//Move different blocks through keyboard
//x direction
always @ (negedge key_p)
begin
	
	if((key_in == 8'h74) && (x4 + 30 < 480) && (x1 + 30 < 480) && (x2 + 30 < 480) && (x3 + 30 < 480) && (freeze == 0)
		&& (back[y4 / 30][x4 / 30 + 1] == 0) && (back[y1 / 30][x1 / 30 + 1] == 0) && (back[y2 / 30][x2 / 30 + 1] == 0) && (back[y3 / 30][x3 / 30 + 1] == 0))	
	begin
		x = x + 30;
	end
	
	if((key_in == 8'h6b) && (x > 0) && (x1 > 0) && (x2 > 0) && (x3 > 0) && (freeze == 0)
		&& (back[y4 / 30][x4 / 30 - 1] == 0) && (back[y1 / 30][x1 / 30 - 1] == 0) && (back[y2 / 30][x2 / 30 - 1] == 0) && (back[y3 / 30][x3 / 30 - 1] == 0))	
	begin
		x = x - 30;
	end
end


always@(ADDR)
begin
	y_now = ADDR / 12'd640; //pixel
	x_now = ADDR % 12'd640;	//pixel
	
	if(x_now >= 480)
	begin
		x_n = (x_now - 480) / 32;
		y_n = y_now / 32;
		
		if(number[y_n][x_n] == 1)
		begin
			j = 3;
		end
		
		else
		begin
			j = 2;
		end	
	end
	
	else
	begin
		x_p = x_now / 30;
		y_p = y_now / 30;
	
	
		if(back[y_p][x_p] == 1)
		begin
			j = 1;
		end
	
		else
		begin
			if(x_now > x4 && x_now < x4 + 30 && y_now > y4 && y_now < y4 + 30)
			begin
				j = 1;
			end
			
			else if(x_now > x1 && x_now < x1 + 30 && y_now > y1 && y_now < y1 + 30)
			begin
				j = 1;
			end
			
			else if(x_now > x2 && x_now < x2 + 30 && y_now > y2 && y_now < y2 + 30)
			begin
				j = 1;
			end
			
			else if(x_now > x3 && x_now < x3 + 30 && y_now > y3 && y_now < y3 + 30)
			begin
				j = 1;
			end
			
			else
			begin
				j = 0;
			end
		end
	end

end
endmodule
