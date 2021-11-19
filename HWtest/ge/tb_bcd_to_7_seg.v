// Project 2
// tb_bcd_to_7_seg.v

`timescale 100ps/1ps

module tb_bcd_to_7_seg;

reg[3:0] bcd_in;
wire [6:0] seven_seg_out;


bcd_to_7_seg U0 (
	      			.bcd_in(bcd_in), 
              		.seven_seg_out(seven_seg_out)
                 );

integer  i;

initial begin
	for(i=0; i<16; i=i+1) begin
		bcd_in <= i;
		#5;
	end
end


endmodule