module mux_choose(ADDR, clk, j, key_p, key_in);

input clk;
input[18:0] ADDR;
reg [9:0] x_now,  y_now, x_p, y_p;
input key_p;
input [7:0] key_in;
reg j, clk_out;
output j;
integer index;

reg [2:0] c;
reg [1:0] r;
reg [15:0] x, y, w;
reg [15:0] back[11:0];

initial
begin

integer k;
for(k = 0; k < 12; k = k + 1)
begin
	back[k] = 16'b0;
end

	c = 3'b000;
	w = 40;
	x = 16'b0;
	y = 16'b0;
	r = 2'b00;
end


always @ (posedge clk)
begin
	if(index < 20000000)
	begin
		index = index + 1;
	end
	
	else
	begin
		index = 0;
		clk_out = ~clk_out;
	end;
end



always @ (posedge clk_out)
begin

	if(c == 3'b000)
	begin
		if((y + 16'd80 < 16'd480) && (back[y / 40 + 2][x / 40] == 0) && (back[y / 40 + 2][x / 40 + 1] == 0))
		begin
			y = y + 16'd40;
		end
	
		else
		begin
			back[y / 40][x / 40] = 1;
			back[y / 40][x / 40 + 1] = 1;
			back[y / 40 + 1][x / 40] = 1;
			back[y / 40  + 1][x / 40  + 1] = 1;
			
			/*
			if(back[y / 40] == 16'b1111111111111111)
			begin
				back[y / 40] = 16'b0;
			end
			
			if(back[y / 40 + 1] == 16'b1111111111111111)
			begin
				back[y / 40 + 1] = 16'b0;
			end
			*/
			
			c = 3'b000;
			y = 16'b0;
			
		end
	end
	
	/*
	if(c == 3'b001)
	begin
		if((r == 2'b00) || (r == 2'b10))
		begin
			if((y + 16'd80 < 16'd480) && (back[x / 40][y / 40 + 1] == 0) && (back[x / 40 + 1][y / 40 + 2] == 0) && (back[x / 40 + 2][y / 40 + 2] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
				back[x / 16'd40][y / 16'd40] = 1;
				back[x / 16'd40 + 16'd1][y / 16'd40] = 1;
				back[x / 16'd40 + 16'd1][y / 16'd40  + 16'd1] = 1;
				back[x / 16'd40  + 16'd2][y / 16'd40  + 16'd1] = 1;
				y = 16'b0;
				c = 3'b010;
			end
		end
		
		if((r == 2'b01) || (r == 2'b011))
		begin
			if((y + 16'd120 < 16'd480) && (back[x / 40][y / 40 + 3] == 0) && (back[x / 40 + 1][y / 40 + 2] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
				back[x / 16'd40 + 16'd1][y / 16'd40] = 1;
				back[x / 16'd40][y / 16'd40 + 16'd1] = 1;
				back[x / 16'd40 + 16'd1][y / 16'd40  + 16'd1] = 1;
				back[x / 16'd40  + 16'd2][y / 16'd40] = 1;
				y = 16'b0;
				c = 3'b010;
			end
		end
	end
	
	if(c == 3'b010)
	begin
		if((r == 2'b00) || (r == 2'b10))
		begin
			if((y + 16'd40 < 16'd480) && (back[x / 40][y / 40 + 1] == 0) && (back[x / 40 + 1][y / 40 + 1] == 0) && (back[x / 40 + 2][y / 40 + 1] == 0) && (back[x / 40 + 3][y / 40 + 1] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
				back[x / 40][y / 40] = 1;
				back[x / 40 + 1][y / 40] = 1;
				back[x / 40 + 2][y / 40] = 1;
				back[x / 40 + 3][y / 40] = 1;
				c = 3'b011;
				y = 16'b0;
			end
		end
		
		if((r == 2'b01) || (r == 2'b011))
		begin
			if((y + 16'd160 < 16'd480) && (back[x / 40][y / 40 + 4] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
				back[x / 40][y / 40] = 1;
				back[x / 40][y / 40 + 1] = 1;
				back[x / 40][y / 40 + 2] = 1;
				back[x / 40][y / 40 + 3] = 1;
				c = 3'b011;
				y = 16'b0;
			end
		end
	end
	
	if(c == 3'b011)
	begin
		if(r == 2'b00)
		begin
			if((y + 16'd80 < 16'd480) && (back[x / 40][y / 40 + 2] == 0) && (back[x / 40 + 1][y / 40 + 2] == 0) && (back[x / 40 + 2][y / 40 + 2] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
			
				back[x / 40][y / 40] = 1;
				back[x / 40][y / 40 + 1] = 1;
				back[x / 40 + 1][y / 40 + 1] = 1;
				back[x / 40 + 2][y / 40 + 1] = 1;
				y = 16'b0;
				c = 3'b100;
			end
		end
		
		if(r == 2'b10)
		begin
			if((y + 16'd80 < 16'd480) && (back[x / 40][y / 40 + 1] == 0) && (back[x / 40 + 1][y / 40 + 1] == 0) && (back[x / 40 + 2][y / 40 + 2] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
				
				back[x / 40][y / 40] = 1;
				back[x / 40 + 1][y / 40] = 1;
				back[x / 40 + 2][y / 40] = 1;
				back[x / 40 + 2][y / 40 + 1] = 1;
				y = 16'b0;
				c = 3'b100;
			end
		end
		
		if(r == 2'b01)
		begin
			if((y + 16'd120 < 16'd480) && (back[x / 40][y / 40 + 3] == 0) && (back[x / 40 + 1][y / 40 + 1] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin
			
				back[x / 40][y / 40] = 1;
				back[x / 40][y / 40 + 1] = 1;
				back[x / 40][y / 40 + 1] = 1;
				back[x / 40][y / 40 + 2] = 1;
				y = 16'b0;
				c = 3'b100;
			end
		end
		
		if(r == 2'b11)
		begin
			if((y + 16'd120 < 16'd480) && (back[x / 40][y / 40 + 3] == 0) && (back[x / 40 + 1][y / 40 + 3] == 0))
			begin
				y = y + 16'd40;
			end
	
			else
			begin

				back[x / 40][y / 40 + 2] = 1;
				back[x / 40 + 1][y / 40] = 1;
				back[x / 40 + 1][y / 40 + 1] = 1;
				back[x / 40 + 1][y / 40 + 2] = 1;	
				y = 16'b0;
				c = 3'b100;
			end
		end
		
	end
	
	if(c == 3'b100)
	begin
		if((r == 2'b00) || (r == 2'b10))
		begin
			if(y + 16'd80 < 16'd480)
			begin
				y = y + 16'd40;
			end
	
			else
			begin
			
				if(r == 2'b00)
				begin
					back[x / 40 + 1][y / 40] = 1;
					back[x / 40 ][y / 40 + 1] = 1;
					back[x / 40 + 1][y / 40 + 1] = 1;
					back[x / 40 + 2][y / 40 + 1] = 1;
				end
				
				if(r == 2'b10)
				begin
					back[x / 40][y / 40] = 1;
					back[x / 40 + 1][y / 40] = 1;
					back[x / 40 + 2][y / 40] = 1;
					back[x / 40 + 1][y / 40 + 1] = 1;
				end
				
				y = 16'b0;
				c = 3'b000;
			end
		end
		
		if((r == 2'b01) || (r == 2'b11))
		begin
			if(y + 16'd120 < 16'd480)
			begin
				y = y + 16'd40;
			end
	
			else
			begin
			
				if(r == 2'b01)
				begin
					back[x / 40][y / 40] = 1;
					back[x / 40 + 1][y / 40] = 1;
					back[x / 40 + 2][y / 40] = 1;
					back[x / 40 + 1][y / 40 + 1] = 1;
				end
				
				if(r == 2'b11)
				begin
					back[x / 40][y / 40 + 1] = 1;
					back[x / 40 + 1][y / 40] = 1;
					back[x / 40 + 1][y / 40 + 1] = 1;
					back[x / 40 + 1][y / 40 + 2] = 1;
				end
				
				y = 16'b0;
				c = 3'b000;
			end
		end
	end
	*/
	
	integer k;
	for(k = 11; k >= 0; k = k - 1)
	begin
		if(back[k] == 16'b1111111111111111)
		begin
			back[k] = 16'b0;
		end
	end
end


//Move different blocks through keyboard
//x direction
always @ (posedge key_p)
begin
	if(c == 3'b000)
	begin
		if(y + 16'd80 < 16'd480)
		begin
			if((key_in == 8'h74) && (x + 16'd80 < 16'd640) && (back[y / 40][x / 40 + 2] == 0) && (back[y / 40 + 1][x / 40 + 2] == 0))
			begin
				x = x + 16'd40;
			end
			
			if((key_in == 8'h6b) && (x > 16'd0000) && (back[y / 40][x / 40 - 1] == 0) && (back[y / 40 + 1][x / 40 - 1] == 0))
			begin
				x = x - 16'd40;
			end
		end
	end
	//*******************************************************
	/*
	if(c == 3'b001)
	begin
	
		if(key_in == 8'h31)
		begin
			r = 2'b01;
		end
		
		if(key_in == 8'h32)
		begin
			r = 2'b00;
		end
		
		if((r == 2'b00) || (r == 2'b10))
		begin
			if(y + 16'd80 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd120 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
		
		if((r == 2'b01) || (r == 2'b011))
		begin
			if(y + 16'd120 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd80 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
	end
	//****************************************************************************
	if(c == 3'b010)
	begin
	
		if((key_in == 8'h31))
		begin
			r = 2'b01;
		end
		
		if((key_in == 8'h32))
		begin
			r = 2'b00;
		end
		
		if((r == 2'b00) || (r == 2'b10))
		begin
			if(y + 16'd40 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd160 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
		
		if((r == 2'b01) || (r == 2'b011))
		begin
			if(y + 16'd160 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd40 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
	end
	
	if((c == 3'b011) || (c == 3'b100))
	begin
	
		if((key_in == 8'h31))
		begin
			r = 2'b01;
		end
		
		if((key_in == 8'h32))
		begin
			r = 2'b00;
		end
		
		if((key_in == 8'h41))
		begin
			r = 2'b10;
		end
		
		if((key_in == 8'h49))
		begin
			r = 2'b11;
		end
	
		if ((r == 2'b00) || (r == 2'b10))
		begin
			if(y + 16'd80 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd120 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
		
		if ((r == 2'b01) || (r == 2'b11))
		begin
			if(y + 16'd120 < 16'd480)
			begin
				if((key_in == 8'h74) && (x + 16'd80 < 16'd640))
				begin
					x = x + 16'd40;
				end
				if((key_in == 8'h6b) && (x > 16'h0000))
				begin
					x = x - 16'd40;
				end
			end
		end
	end
	*/
end


always@(ADDR)
begin
	y_now = ADDR / 12'd640; //pixel
	x_now = ADDR % 12'd640;	//pixel
	
	x_p = x_now / 16'd40;
	y_p = y_now / 16'd40;
	
	
	if(back[y_p][x_p] == 1)
	begin
		j = 1'b1;
	end
	
	else
	begin
	
	case (c)
      3'b000  : 
		begin 
			if(x_now > x && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd80)
			begin
				j = 1'b1;
			end
			
			/*
			else if(back[x_p][y_p] == 1)
			begin
				j = 1'b1;
			end
			*/
		
			else
			begin
				j = 1'b0;
			end				
		end
		
		/*
      3'b001  : 	
		begin 
			if((r == 2'b00) || (r == 2'b10))
			begin
				if(x_now > x && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd40)
				begin
					j = 1'b1;
				end
				
				else if (x_now >= x + 16'd40 && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
			
			if((r == 2'b01) || (r == 2'b11))
			begin
				if(x_now > x && x_now < x + 16'd40 && y_now > y + 16'd40 && y_now < y + 16'd120)
				begin
					j = 1'b1;
				end
				
				else if (x_now >= x + 16'd40 && x_now < x + 16'd80 && y_now >= y && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
		end
		
		
      3'b010  : 
		begin 
		if((r == 2'b00) || (r == 2'b10))
			begin
				if(x_now > x && x_now < x + 16'd160 && y_now > y && y_now < y + 16'd40)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
		
				else
				begin
					j = 1'b0;
				end
			end
			
			if((r == 2'b01) || (r == 2'b11))
			begin
				if(x_now > x && x_now < x + 16'd40 && y_now > y && y_now < y + 16'd160)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
		
				else
				begin
					j = 1'b0;
				end
			end
		end
		
		3'b011  : 
		begin
			if(r == 2'b00)
			//up
			begin
				if(x_now > x && x_now < x + 16'd40 && y_now > y && y_now < y + 16'd40)
				begin
					j = 1'b1;
				end
			
				else if(x_now > x && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
			
				else
				begin
					j = 1'b0;
				end
			end
			
			if (r == 2'b01)
			//right
			begin
				if (x_now > x && x_now < x + 16'd40 && y_now > y && y_now < y + 16'd120)
				begin
					j = 1'b1;
				end
				
				else if (x_now >= x + 16'd40 && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd40) 
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j =1'b0;
				end
			end
			
			if (r == 2'b10)
			//down
			begin
				if (x_now > x && x_now < x + 16'd120 && y_now > y && y_now < y + 40)
				begin
					j = 1'b1;
				end
				
				else if (x_now > x + 16'd80 && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
			
			if (r == 2'b11)
			//left
			begin
				if (x_now > x && x_now < x + 16'd40 && y_now >= y + 16'd80 && y_now < y + 16'd120)
				begin
					j = 1'b1;
				end
				
				else if (x_now >= x + 16'd40 && x_now < x + 16'd80 && y_now >= y && y_now < y + 16'd120)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
		end
		
		3'b100  :
		begin 
			if(r == 2'b00)
			//up
			begin
				if(x_now > x + 16'd40 && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd40)
				begin
					j = 1'b1;
				end
			
				else if(x_now > x && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
			
				else
				begin
					j = 1'b0;
				end
			end
			
			if (r == 2'b01)
			//right
			begin
				if(x_now > x && x_now < x + 16'd40 && y_now > y && y_now < y + 16'd120)
				begin
					j = 1'b1;
				end
				
				else if(x_now >= x + 16'd40 && x_now < x + 16'd80 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
			
			if (r == 2'b10)
			//down
			begin
				if (x_now > x && x_now < x + 16'd120 && y_now > y && y_now < y + 16'd40)
				begin
					j = 1'b1;
				end
				
				else if(x_now > x + 16'd40 && x_now < x + 16'd80 && y_now >= y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else
				begin
					j = 1'b0;
				end
			end
			
			if (r == 2'b11)
			//left
			begin
				if (x_now > x && x_now < x +16'd40 && y_now > y + 16'd40 && y_now < y + 16'd80)
				begin
					j = 1'b1;
				end
				
				else if (x_now >= x + 16'd40 && x_now < x + 16'd80 && y_now >= y && y_now < y + 16'd120)
				begin
					j =1'b1;
				end
				
				else if(back[x_p][y_p] == 1)
				begin
					j = 1'b1;
				end
				
				else 
				begin
					j = 1'b0;
				end
			end
		end
	*/	
    endcase
	 end
	
	
end
endmodule

	