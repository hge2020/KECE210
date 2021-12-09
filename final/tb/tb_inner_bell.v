module tb_inner_bell;
    reg clk, rst;
    
    wire right;
    wire [2-1:0] whop;
    wire [16-1:0] score_weight;
    wire [16-1:0] total_score;
    
    counter card_count(.clk(clk), .rst(rst), .en(random_enable), .finish(score_control_fin),
    .count(nofcard));
    score_control score_c (.clk(clk), .rst(rst), .count(nofcard), .right(right), .who({whop[1], whop[0]}),
    .scoreA(score_weight[16-1:8]), .scoreB(score_weight[8-1:0]), .finish(score_control_fin));
    who_push who(.clk(clk), .rst(rst), .keypad_in(key_scan),
    .savewho1(whop[0]), .savewho2(whop[1]));
    is_right right(.clk(clk), .rst(rst), keypad_in(key_scan),
    .c1(value_player1[5-1:3]), .c2(value_player2[5-1:3]), .n1(value_player1[3-1:0]), .n2(value_player2[3-1:0])
    .right(right));
    who_win winner(.clk(clk), .rst(rst), .scoreA(total_score[16-1:8]), .scoreB(total_score[8-1:0]),
    .LCD_sig(LCD_sig));