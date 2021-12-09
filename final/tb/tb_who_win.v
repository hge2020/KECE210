module tb_who_win;
    reg clk, rst;
    reg [9-1:0] scoreA, scoreB;
    wire [2-1:0] LCD_sig;

    who_win w1(
        .clk(clk), .rst(rst), .scoreA(scoreA), .scoreB(scoreB), .LCD_sig(LCD_sig)
    );

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;
        LCD_sig <= 2'b00;
        forever #5 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        #5
        scoreA <= 9'b00000_0001;
        scoreB <= 9'b00000_1101;
        #10
        scoreA <= 9'b01100_0001;
        scoreB <= 9'b00000_1101;
        #10
        scoreA <= 9'b00000_0001;
        scoreB <= 9'b01100_1101;
        #10 
        rst <= 1'b0;

    end
endmodule