module top_output_seg(
    input clk, rst,
    input D9, D8, D7, D6, D5, D4, D3, D2, D1, D0,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position,
)

always @(clk) begin
    if (!rst) begin
        value_player1 <= 00_001;
        value_player2 <= 00_010;
    end
end

display dis1(.clk(clk), .rst(rst), .c_value(value_player1[3-1:0]),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(value_player2[3-1:0]),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.data_out(seg_display), .data_pos(seg_position));

endmodule