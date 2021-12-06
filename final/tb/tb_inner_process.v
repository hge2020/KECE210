module tb_inner_process;
    reg clk, rst;
    reg [4-1:0] key_scan;
    wire [5-1:0] value_player1, value_player2;


    wire keypad_valid;
    wire random_enable;
    wire turn_whose;
    wire [8-1:0] nofcard;
    wire [5-1:0] randn;
    wire [5-1:0] rand_player1, rand_player2;
    integer i, j;

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
        clk <= 1'b1;
        rst <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        for (j = 0; j<10; j=j+1) begin
            for (i = 1; i <5; i = i+1) begin
                assign key_scan = i;
                #10;
            end
        end
        
        $finish;
    end
    

endmodule