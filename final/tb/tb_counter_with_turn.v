module tb_counter_with_turn;
reg clk, rst;
reg [4-1:0] keypad_in;
wire en, whose;
reg finish;
wire [8-1:0] count;

turn tbturn(.clk(clk), .rst(rst), .keypad_in(keypad_in), .en(en), .whose(whose));
counter tbcounter(.clk(clk), .rst(rst), .en(en), .finish(finish), .count(count));

initial begin
    clk <= 1'b1;
    rst <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin
    #10 rst <= ~rst;
    #1000 rst <= ~rst;
    #100 $finish;
end

initial begin
    finish <= 1'b0;
    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0001;
    #20 keypad_in <= 4'b0001;

    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0001;
    #20 keypad_in <= 4'b0001;
    finish <= 1'b1;

    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0011;
    finish <= 1'b0;
    #20 keypad_in <= 4'b0001;
    #20 keypad_in <= 4'b0001;
end

endmodule
