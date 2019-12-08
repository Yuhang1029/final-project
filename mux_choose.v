module mux_choose (ADDR, clk, j, key_p, key_in, score);

input clk;
input[18:0] ADDR;
reg [9:0] x_now,  y_now, x_p, y_p;
input key_p;
input [7:0] key_in;
reg[1:0] j;
reg clk_out;
output[1:0] j;
integer index, k, kk;

reg [7:0] score;
output [7:0] score;
reg [2:0] c;
reg [1:0] r;
reg [15:0] x, y, x1, y1, x2, y2, x3, y3, x4, y4;
reg [15:0] back[15:0];
reg[30:0] counter;

initial
begin
	integer t;
	for(t = 0; t < 16; t = t + 1)
	begin
		back[t] = 16'b0;
	end

	c = 3'b000;
	x = 16'b0;
	y = 16'b0;
	r = 2'b00;
	counter = 12000000;
	score = 0;
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
	score = 0;
	for(kk = 15; kk >= 0; kk = kk - 1)
		begin
			back[kk] = 16'b0;
		end
	end
		

	if((y4 + 30 < 480) && (y1 + 30 < 480) && (y2 + 30 < 480) && (y3 + 30 < 480)
	&& (back[y4 / 30 + 1][x4 / 30] == 0) && (back[y1 / 30 + 1][x1 / 30] == 0) && (back[y2 / 30 + 1][x2 / 30] == 0) && (back[y3 / 30 + 1][x3 / 30] == 0))
	begin
		y = y + 30;
	end
	
	else
	begin
		back[y4 / 30][x4 / 30] = 1;
		back[y1 / 30][x1 / 30] = 1;
		back[y2 / 30][x2 / 30] = 1;
		back[y3 / 30][x3 / 30] = 1;	
		c = (c + 1) % 5;
		y = 16'b0;
			
	end
	
	for(k = 15; k > 0; k = k - 1)
	begin
		if(back[k] == 16'b1111111111111111)
		begin
			score = score + 1;
			if(score == 2)
			begin
				counter = 6000000;
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
		r = (r + 1) % 4;
	end
end


//Move different blocks through keyboard
//x direction
always @ (negedge key_p)
begin
	
	if((key_in == 8'h74) && (x4 + 30 < 480) && (x1 + 30 < 480) && (x2 + 30 < 480) && (x3 + 30 < 480)
		&& (back[y4 / 30][x4 / 30 + 1] == 0) && (back[y1 / 30][x1 / 30 + 1] == 0) && (back[y2 / 30][x2 / 30 + 1] == 0) && (back[y3 / 30][x3 / 30 + 1] == 0))	
	begin
		x = x + 30;
	end
	
	if((key_in == 8'h6b) && (x > 0) && (x1 > 0) && (x2 > 0) && (x3 > 0)
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
		if ((x_now >= 520 && x_now <= 550 && y_now >= 255 && y_now <= 265) ||  
			(x_now >= 535 && x_now <= 550 && y_now >= 240 && y_now <= 255) ||
			(x_now >= 520 && x_now <= 535 && y_now >= 225 && y_now <= 240) ||
			(x_now >= 520 && x_now <= 550 && y_now >= 215 && y_now <= 225))
		begin 
			j	= 3;
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
