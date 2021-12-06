module tb_who_push;
    reg clk, rst;
    reg [4-1:0] keypad_in;
    wire savewho1, savewho2;

    who_push wp1(
        .clk(clk), .rst(rst), .keypad_in(keypad_in),
        .savewho1(savewho1), .savewho2(savewho2)
    );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        forever #1 clk <= ~clk;
    end

    initial begin
        #5 rst <= 1'b1;
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 rst <= 1'b0;
        #5 rst <= 1'b1;
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'bxxxx;
        #5 rst <= 1'b0;
        #5 rst <= 1'b1;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
    end
endmodule
