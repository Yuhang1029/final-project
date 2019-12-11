module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 key_p,
							 key_in,
							 score);

	
input iRST_n;
input iVGA_CLK;
input key_p;
input [7:0] key_in;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;
output [7:0] score;                    
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
reg clk_kp;
integer i;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
wire _press;
reg press_m, counter;
assign _press = press_m;

wire[1:0] j;

initial
begin
	counter = 0;
end


always @ (posedge VGA_CLK_n)
begin
	if(i < 2000000)
	begin
		i = i + 1;
	end
	
	else
	begin
		i = 0;
		clk_kp = ~clk_kp;
	end;
end

////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////
//////latch valid data at falling edge;
//always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;//change


always @ (posedge clk_kp or posedge key_p)
begin
	if(key_p == 1)
	begin
		press_m = 1;
	end
	
	else if(clk_kp == 1)
	begin
		if(counter == 1)
		begin
			counter = 0;
			press_m = 0;
		end
		
		else if(press_m == 1)
		begin
			counter = counter + 1;
		end
		
	end
end


mux_choose m(ADDR, VGA_CLK_n, j, _press, key_in, score);

always@(posedge VGA_CLK_n)
begin

	if(j == 1)
	begin
		bgr_data <= 24'h0000FF;
	end
	
	else if(j == 2)
	begin
		bgr_data <= 24'h000000;
	end
	
	else if(j == 3)
	begin
		bgr_data <= 24'hFF0000;
	end
	
	else
	begin	
		bgr_data <= bgr_data_raw;
	end
end


assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	















