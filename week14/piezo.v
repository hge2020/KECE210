// 1 Mhz
module piezo(reset,clk,key,piezo);

input clk, reset;
input[7:0] key;
output piezo;
reg buff;
integer cnt_sound;
integer limit;
wire piezo;

always@(key)
begin
	case(key)
		8'b10000000:limit=1910;//?
		8'b01000000:limit=1701;//?
		8'b00100000:limit=1516;//?
		8'b00010000:limit=1431;//?
		8'b00001000:limit=1275;//?
		8'b00000100:limit=1135;//?
		8'b00000010:limit=1011;//? ? 
		8'b00000001:limit=955;//?
		default:limit=0;
	endcase
end
 
always@(posedge clk)
begin
	if(reset) 
		begin
			buff=1'b0;
			cnt_sound=0;
		end
	else	
		begin	
			if(cnt_sound >= limit)//cnt_sount ? limit?? ?? ??? ? 
				begin	
					cnt_sound=0;
					buff = ~buff;
				end
			else
				cnt_sound = cnt_sound+1;
		end
		
end
 
assign piezo = buff;
 
endmodule

