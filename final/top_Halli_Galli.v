module top_Halli_Galli (
    input clk, rst,
    input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position,
    output wire LCD_E, LCD_RS, LCD_RW,
    output wire [7:0] LCD_DATA
);
    wire [4-1:0] key_scan;
    wire random_enable;
    wire score_control_fin;
    wire turn_whose;
    wire [8-1:0] nofcard;
    wire [5-1:0] randn;
    wire [5-1:0] rand_player1, rand_player2;
    wire [5-1:0] value_player1, value_player2;
    wire right;
    wire [2-1:0] whop;
    wire [16-1:0] score_weight;
    wire [16-1:0] total_score;
    wire [2-1:0] LCD_sig;
    wire [14-1:0] seg;

keypad_scan keypad(.clk(clk), .rst(rst), .keypad_in({b12, b11, b10, b9, b8, b7, b6, b5, b4, b3, b2, b1}), 
.scan_out(key_scan));

turn whose_turn (.clk(clk), .rst(rst), .keypad_in(key_scan),
.en(random_enable), .whose(turn_whose));
counter card_count(.clk(clk), .rst(rst), .en(random_enable), .finish(score_control_fin),
.count(nofcard));
rand_gen rgen(.clk(clk), .rst(rst), .en(random_enable),
.rnd(randn));
demux dmux(.clk(clk), .rst(rst), .whose(turn_whose), .rnd(randn),
.card_value1(rand_player1), .card_value2(rand_player2));
card_value value_p1 (.clk(clk), .rst(rst), .rnd(rand_player1),
.color(value_player1[5-1:3]), .number(value_player1[3-1:0]));
card_value value_p2 (.clk(clk), .rst(rst), .rnd(rand_player2),
.color(value_player2[5-1:3]), .number(value_player2[3-1:0]));

is_right correct(.clk(clk), .rst(rst), .keypad_in(key_scan),
.c1(value_player1[5-1:3]), .c2(value_player2[5-1:3]), .n1(value_player1[3-1:0]), .n2(value_player2[3-1:0]),
.right(right));
who_push who(.clk(clk), .rst(rst), .finish(score_control_fin), .keypad_in(key_scan),
.savewho1(whop[0]), .savewho2(whop[1]));
score_control score_c (.clk(clk), .rst(rst), .count(nofcard), .right(right), .who({whop[1], whop[0]}),
.scoreA(score_weight[16-1:8]), .scoreB(score_weight[8-1:0]), .finish(score_control_fin));
score_file score_r (.clk(clk), .rst(rst), .add_score(score_weight),
.total_score(total_score));
who_win winner(.clk(clk), .rst(rst), .scoreA(total_score[16-1:8]), .scoreB(total_score[8-1:0]),
.LCD_sig(LCD_sig));

full_c_LED led(.clk(clk), .rst(rst), .c_value1(value_player1[5-1:3]), .c_value2(value_player2[5-1:3]),
.led_1_r(led_1_r), .led_1_g(led_1_g), .led_1_b(led_1_b),
.led_2_r(led_2_r), .led_2_g(led_2_g), .led_2_b(led_2_b));
display dis1(.clk(clk), .rst(rst), .c_value(value_player1[3-1:0]),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(value_player2[3-1:0]),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.data_out(seg_display), .data_pos(seg_position));
LCD lcd(.clk(clk), .rst(rst), .LCD_sig(LCD_sig),
.LCD_E(LCD_E), .LCD_RS(LCD_RS), .LCD_RW(LCD_RW), .LCD_DATA(LCD_DATA));

endmodule