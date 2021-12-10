module top_output_seg(
    input clk, rst,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position
);

wire [7-1:0] seg1;
wire [7-1:0] seg2;


display dis1(.clk(clk), .rst(rst), .c_value(3'b011),
.seg(seg1));
display dis2(.clk(clk), .rst(rst), .c_value(3'b100),
.seg(seg2));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg1), .seg2(seg2),
.data_out(seg_display), .data_pos(seg_position));
endmodule