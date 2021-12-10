module tb_output_seg;
    reg clk, rst;
    wire [7-1:0] seg_display;
    wire [8-1:0] seg_position;
    wire [14-1:0] seg;

    display dis1(.clk(clk), .rst(rst), .c_value(3'b001),
    .seg(seg[14-1:7]));
    display dis2(.clk(clk), .rst(rst), .c_value(3'b010),
    .seg(seg[7-1:0]));
    seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]), .seg2(seg[7-1:0]),
    .data_out(seg_display), .data_pos(seg_position));

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        forever #1 clk <= ~clk;
    end

    initial begin
        #10 rst <= 1'b1;
    end

endmodule