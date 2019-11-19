module mux_choose(ADDR, clk, j, key_p, key_in);

input clk;
input[18:0] ADDR;
reg [9:0] x_now,  y_now;
input key_p;
input [7:0] key_in;
reg j, clk_out;
output j;
integer index;


reg [15:0] x;
reg [15:0] x1;
reg [15:0] y;
reg [15:0] w;
reg reach;

initial
begin
	x = 16'b0;
	y = 16'b0;
	w = 16'b0000100000;
	index = 0;
	reach = 0;
end

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


/*
always @ (posedge clk_out)
begin
	if((right == 0) && (x + w < 16'h0280))
	begin
		x = x + 1;
	end
	if((left == 0) && (x > 16'h0000))
	begin
		x = x - 1;
	end
	if((up == 0) && (y > 16'h0000))
	begin
		y = y - 1;
	end
	if((down == 0) && (y + w < 16'h01E0))
	begin
		y = y + 1;
	end
end
*/

always @ (posedge clk_out)
begin
	if(y + w < 16'h01E0)
	begin
		y = y + 4'd1;
	end
	
	else
	begin
		y = 16'b0;
		reach = 1'b1;
		x1 = x;
	end
end

always @ (posedge key_p)
begin
	if(y + w < 16'h01E0)
	begin
		if((key_in == 8'h74) && (x + w < 16'h0280))
		begin
			x = x + 4'd5;
		end
		if((key_in == 8'h6b) && (x > 16'h0000))
		begin
			x = x - 4'd5;
		end
	end
end



always@(ADDR)
begin
	y_now = ADDR / 12'h280; //pixel
	x_now = ADDR % 12'h280;	//pixel
	
	if(x_now > x && x_now < x + w && y_now > y && y_now < y + w)
	begin
		j = 1'b1;
	end
	
	else if(reach == 1'b1 && x_now > x1 && x_now < x1 + w && y_now > 16'h01E0 - w && y_now < 16'h01E0)
	begin
		j = 1'b1;
	end
		
	else
	begin
		j = 1'b0;
	end
end
endmodule

	