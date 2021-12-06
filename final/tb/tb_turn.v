module tb_turn;
reg clk, rst;
reg [4-1:0] keypad_in;
wire en, whose;

turn tbturn(.clk(clk), .rst(rst), .keypad_in(keypad_in), .en(en), .whose(whose));

initial begin
    clk <= 1'b1;
    rst <= 1'b0;
    forever #5 clk <= ~clk;
end

initial begin
    #10 rst <= ~rst;
    #100 rst <= ~rst;
    #100 $finish;
end

initial begin
    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0011;
    #20 keypad_in <= 4'b0001;
    #20 keypad_in <= 4'b0001;
end

endmodule
