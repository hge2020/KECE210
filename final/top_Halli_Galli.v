module top_Halli_Galli (
    input clk, rst,
    input b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b,
    output [7-1:0] seg_display,
    output [8-1:0] seg_position,
    output wire LCD_E, LCD_RS, LCD_RW;
    output wire [7:0] LCD_DATA;
);
    wire [4-1:0] key_scan;
    wire keypad_valid;
    wire random_enable;
    wire turn_whose;
    wire nofcard;
    wire [5-1:0] randn;
    wire [5-1:0] value_player1;
    wire [5-1:0] value_player2;
    wire right;
    wire [2-1:0] whop;
    wire [16-1:0] score_weight;
    wire [18-1:0] total_score;
    wire [2-1:0] LCD_sig;
    wire [14-1:0] seg;

keypad_scan keypad(.clk(clk), .rst(rst), .keypad_in({b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12}), 
.scan_out(key_scan), .valid(keypad_valid));

turn whose_turn (.clk(clk), .rst(rst), .keypad_in(key_scan),
.en(random_enable), .whose(turn_whose));
counter card_count(.clk(clk), .rst(rst), .en(random_enable),
.count(nofcard));
rand_gen rgen(.clk(clk), .rst(rst), .en(random_enable),
.rnd(randn));
card_value value_p1 (.clk(clk), .rst(rst),
.color(value_player1[5-1:3]), .number(value_player1[3-1:0]));
card_value value_p2 (.clk(clk), .rst(rst),
.color(value_player2[5-1:3]), .number(value_player2[3-1:0]));

is_right right(.clk(clk), .rst(rst), keypad_in(key_scan),
.c1(value_player1[5-1:3]), .c2(value_player2[5-1:3]), .n1(value_player1[3-1:0]), .n2(value_player2[3-1:0])
.right(right));
who_push who(.clk(clk), .rst(rst), .keypad_in(key_scan),
.savewho1(whop[0]), .savewho2(whop[1]));
score_control score_c (.clk(clk), .rst(rst), .count(nofcard), .right(right), .who({whop[0], whop[1]}),
.scoreA(score_weight[16-1:8]), .scoreB(score_weight[8-1:0]));
score_file score_r (.clk(clk), .rst(rst), .add_score(score_weight),
.total_score(total_score));
who_win winner(.clk(clk), .rst(rst), .scoreA(total_score[18-1:9]), .scoreB(total_score[9-1:0]), .LCD_sig(LCD_sig));

full_c_LED led(.clk(clk), .rst(rst), .c_value1(value_player1[5-1:3]), .c_value2(value_player2[5-1:3]),
.led_1_r(led_1_r), .led_1_g(led_1_g), .led_1_b(led_1_b),
.led_2_r(led_2_r), .led_2_g(led_2_g), .led_2_b(led_2_b));
display dis1(.clk(clk), .rst(rst), .c_value(value_player1[3-1:0]),
.seg(seg[14-1:7]));
display dis2(.clk(clk), .rst(rst), .c_value(value_player2[3-1:0]),
.seg(seg[7-1:0]));
seven_segment seg_7(.clk(clk), .rst(rst), .seg1(seg[14-1:7]),. seg2(seg[7-1:0]),
.date_out(seg_display), .date_pos(seg_position));
LCD lcd(.clk(clk), .rst(rst), .LCD_sig(LCD_sig),
.LCD_E(LCD_E), .LCD_RS(LCD_RS), .LCD_RW(LCD_RW), .LCD_DATA(LCD_DATA));

endmodule