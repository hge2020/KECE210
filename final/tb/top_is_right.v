module top_is_right(
    input clk, rst,
    input [12-1:0] keypad_in,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position,
    output l0, l1, l2, l3, l4, l5, l6, l7
);

    wire [4-1:0] key_scan;
    wire random_enable;
    wire score_control_fin;
    wire turn_whose;
    wire [5-1:0] randn;
    wire [5-1:0] rand_player1, rand_player2;
    wire [5-1:0] value_player1, value_player2;
    wire right;
    wire [14-1:0] seg;

keypad_scan keypad(.clk(clk), .rst(rst), .keypad_in({b12, b11, b10, b9, b8, b7, b6, b5, b4, b3, b2, b1}), 
.scan_out(key_scan));

turn whose_turn (.clk(clk), .rst(rst), .keypad_in(key_scan),
.en(random_enable), .whose(turn_whose));
pseudo_random rgen(.clk(clk), .rst(rst), .en(random_enable),
.rnd(randn));
demux dmux(.clk(clk), .rst(rst), .whose(turn_whose), .rnd(randn),
.card_value1(rand_player1), .card_value2(rand_player2));
card_value value_p1 (.clk(clk), .rst(rst), .rnd(rand_player1),
.color(value_player1[5-1:3]), .number(value_player1[3-1:0]));
card_value value_p2 (.clk(clk), .rst(rst), .rnd(rand_player2),
.color(value_player2[5-1:3]), .number(value_player2[3-1:0]));

is_right correct(.clk(clk), .rst(rst), .keypad_in(key_scan),
.c1(value_player1[5-1:3]), .c2(value_player2[5-1:3]), .n1(value_player1[3-1:0]), .n2(value_player2[3-1:0]),
.right(l0));

full_c_LED led(.clk(clk), .rst(rst), .c_value1(value_player1[5-1:3]), .c_value2(value_player2[5-1:3]),
.led_1_r(led_1_r), .led_1_g(led_1_g), .led_1_b(led_1_b),
.led_2_r(led_2_r), .led_2_g(led_2_g), .led_2_b(led_2_b));
display dis1(.clk(clk), .rst(rst), .c_value(value_player1[3-1:0]),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(value_player2[3-1:0]),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.data_out(seg_display), .data_pos(seg_position));