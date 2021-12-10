module top_output_seg(
    input clk, rst,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position
);

reg [5-1:0] value_player1, value_player2;
wire [14-1:0] seg;

always @(clk) begin
    if (!rst) begin
        value_player1 <= 00_000;
        value_player2 <= 00_000;
    end
    else begin
        value_player1 <= 00_001;
        value_player2 <= 00_010;
    end
end

display dis1(.clk(clk), .rst(rst), .c_value(3'b001),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(3'b010),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.data_out(seg_display), .data_pos(seg_position));

endmodule