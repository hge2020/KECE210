module tb_inner_process;
    reg clk, rst;
    reg b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12;
    wire [5-1:0] value_player1, value_player2;

    wire [4-1:0] key_scan;
    wire random_enable;
    wire turn_whose;
    wire [8-1:0] nofcard;
    wire [5-1:0] randn;
    wire [5-1:0] rand_player1, rand_player2;


keypad_scan keypad(.clk(clk), .rst(rst), .keypad_in({b12, b11, b10, b9, b8, b7, b6, b5, b4, b3, b2, b1}), 
.scan_out(key_scan));
turn whose_turn (.clk(clk), .rst(rst), .keypad_in(key_scan),
.en(random_enable), .whose(turn_whose));
counter card_count(.clk(clk), .rst(rst), .en(random_enable),
.count(nofcard));
rand_gen rgen(.clk(clk), .rst(rst), .en(random_enable),
.rnd(randn));
demux dmux(.clk(clk), .rst(rst), .whose(turn_whose), .rnd(randn),
.card_value1(rand_player1), .card_value2(rand_player2));
card_value value_p1 (.clk(clk), .rst(rst), .rnd(rand_player1),
.color(value_player1[5-1:3]), .number(value_player1[3-1:0]));
card_value value_p2 (.clk(clk), .rst(rst), .rnd(rand_player2),
.color(value_player2[5-1:3]), .number(value_player2[3-1:0]));


initial begin
    rst <= 1'b0;
    clk <= 1'b1;
    b1 <= 1'b0;
    b2 <= 1'b0;
    b3 <= 1'b0;
    b4 <= 1'b0;
    b5 <= 1'b0;
    b6 <= 1'b0;
    b7 <= 1'b0;
    b8 <= 1'b0;
    b9 <= 1'b0;
    b10 <= 1'b0;
    b11 <= 1'b0;
    b12 <= 1'b0;        
    forever #1 clk <= ~clk;
end

initial begin
    #5 rst <= 1'b1;

    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;

    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;

    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;
    
    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;

    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;

    #5 b1 <= 1'b1; // press '1'
    #5 b1 <= 1'b0;

    #5 b3 <= 1'b1; // press '3'
    #5 b3 <= 1'b0;

    #50 rst <= 1'b0;
end

endmodule