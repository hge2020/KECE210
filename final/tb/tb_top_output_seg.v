module tb_top_output_seg;
reg clk, rst;
reg [5-1:0] value_player1, value_player2;
wire [14-1:0] seg;
wire [7-1:0] seg_display;
wire [8-1:0] seg_position;


display dis1(.clk(clk), .rst(rst), .c_value(value_player1[3-1:0]),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(value_player2[3-1:0]),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.data_out(seg_display), .data_pos(seg_position));

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

initial begin
    clk <= 1'b1;
    rst <= 1'b0;
    forever #1 clk <= ~clk;
end

initial begin
    #10 rst <= ~rst;
    #8000 rst <= ~rst;
end

endmodule