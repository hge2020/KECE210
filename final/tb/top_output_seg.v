module top_output_seg(
    input clk, rst,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position
);
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(7'b0110000),. seg2(7'b1111001),
.data_out(seg_display), .data_pos(seg_position));

endmodule