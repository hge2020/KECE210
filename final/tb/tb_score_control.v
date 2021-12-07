module tb_score_control;
reg clk, rst;
reg [8-1:0] count;
reg right;
reg [2-1:0] who;
wire [8-1:0] scoreA, scoreB;
wire finish;

score_control tbscore_control(.clk(clk), .rst(rst), .count(count), .right(right), .who(who), .scoreA(scoreA), .scoreB(scoreB), .finish(finish));

initial begin
    clk <= 1'b1;
    rst <= 1'b0;
    count <= 300;
    forever #5 clk <= ~clk;
end

initial begin
    #10 rst <= ~rst;
    #1000 rst <= ~rst;
    #100 $finish;
end

initial begin
    #20 right <= 0;
    #20 who <= 01;
    #20 who <= 10;
    #20 who <= 00;
    #20 who <= 11;
    #40 right <= 1;
    #20 who <= 01;
    #20 who <= 10;
    #20 who <= 00;
    #20 who <= 11;
end

endmodule
