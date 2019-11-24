module mux_choose(ADDR, clk, j, key_p, key_in);

input clk;
input[18:0] ADDR;
reg [9:0] x_now,  y_now;
input key_p;
input [7:0] key_in;
reg j, clk_out;
output j;
integer index;

reg [2:0] c;
reg [15:0] x, y, w;

initial
begin
	c = 3'b000;
	w = 40;
	x = 16'b0;
	y = 16'b0;
end


/*generate 
for(i = 0; i < 3; i=i+1)
begin: for_loop
	c = i;
end
endgenerate*/
/*
always @(*)
  begin
    case (c)
      3'b000  :  begin 
						w = 16'b0000100000;
						end
		
      3'b001  : 	begin 
						w = 16'b0001000000;
						end
		
		
      3'b010  : 	begin 
						w = 16'b0000001000;
						end
						
      default : 	begin 
						w = 16'b0000000010;
						end
    endcase
  end
*/
/*initial
begin
	x = 16'b0;
	y = 16'b0;
	w = 16'b0000100000;
	index = 0;
	reach = 0;
end*/

//x control the left and right
//y control the up and down




always @ (posedge clk)
begin
	if(index < 200000)
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
		if(y + 16'd80 < 16'd480)
		begin
			y = y + 4'd1;
		end
	
		else
		begin
			y = 16'b0;
			c = 3'b001;
		end
	end
	
	if(c == 3'b001)
	begin
		if(y + 16'd80 < 16'd480)
		begin
			y = y + 4'd1;
		end
	
		else
		begin
			y = 16'b0;
			c = 3'b010;
		end
	end
	
	if(c == 3'b010)
	begin
		if(y + 16'd40 < 16'd480)
		begin
			y = y + 4'd1;
		end
	
		else
		begin
			y = 16'b0;
			c = 3'b011;
		end
	end
	
	if(c == 3'b011)
	begin
		if(y + 16'd80 < 16'd480)
		begin
			y = y + 4'd1;
		end
	
		else
		begin
			y = 16'b0;
			c = 3'b100;
		end
	end
	
	if(c == 3'b100)
	begin
		if(y + 16'd80 < 16'd480)
		begin
			y = y + 4'd1;
		end
	
		else
		begin
			y = 16'b0;
			c = 3'b000;
		end
	end
end


always @ (posedge key_p)
begin
	if(c == 3'b000)
	begin
		if(y + 16'd80 < 16'd480)
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
	
	if(c == 3'b001)
	begin
		if(y + 16'd80 < 16'd480)
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
	
	if(c == 3'b010)
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
	
	if(c == 3'b011)
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
	
	if(c == 3'b100)
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
end

/*
wire j1, j2;
diff_s1 d1(x, y, w, j1, y_now, x_now);
diff_s2 d2(x, y, w, j2, y_now, x_now);
*/


always@(ADDR)
begin
	y_now = ADDR / 12'h280; //pixel
	x_now = ADDR % 12'h280;	//pixel
	
	case (c)
      3'b000  : 
		begin 
			if(x_now > x && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd80)
			begin
				j = 1'b1;
			end
		
			else
			begin
				j = 1'b0;
			end
										
		end
		
      3'b001  : 	
		begin 
		if(x_now > x && x_now < x + 16'd160 && y_now > y && y_now < y + 16'd80)
			begin
				j = 1'b1;
			end
		
		else
			begin
				j = 1'b0;
			end
		end
		
		
      3'b010  : 
		begin 
		if(x_now > x && x_now < x + 16'd160 && y_now > y && y_now < y + 16'd40)
			begin
				j = 1'b1;
			end
		
			else
			begin
				j = 1'b0;
			end
		end
		
		3'b011  : 
		begin 
		if(x_now > x && x_now < x + 16'd40 && y_now > y && y_now < y + 16'd40)
			begin
				j = 1'b1;
			end
			
		else if(x_now > x && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
			begin
				j = 1'b1;
			end
			
		else
			begin
				j = 1'b0;
			end
		end
		
		3'b100  :
		begin 
		if(x_now > x + 16'd40 && x_now < x + 16'd80 && y_now > y && y_now < y + 16'd40)
			begin
				j = 1'b1;
			end
			
		else if(x_now > x && x_now < x + 16'd120 && y_now >= y + 16'd40 && y_now < y + 16'd80)
			begin
				j = 1'b1;
			end
			
		else
			begin
				j = 1'b0;
			end
		end
						
      default : 	begin 
						w = 16'b0000000010;
						end
    endcase
	
	
end
endmodule

	