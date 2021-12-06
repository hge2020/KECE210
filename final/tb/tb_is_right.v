module tb_is_right;
    reg clk, rst;
    reg [4-1:0] keypad_in;
    reg [2-1:0] c1, c2;
    reg [3-1:0] n1, n2;
    wire right;

    is_right simul(
        .clk(clk), .rst(rst), .keypad_in(keypad_in),
        .c1(c1), .c2(c2), .n1(n1), .n2(n2), .right(right)
    );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        /*c1 <= 1'b0;
        c2 <= 1'b0;
        n1 <= 1'b0;
        n2 <= 1'b0;*/
        forever #1 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        #5 keypad_in <= 4'b0000;
        
        #30
        c2 <= 2'b11; //3번 과일
        n2 <= 3'b101; // 5  ==> 정답이어야함
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'bxxxx;

        #30
        c1 <= 2'b01; //1번 과일
        n1 <= 3'b001; //1 이지만 ==> 정답이어야함
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'bxxxx;

        #30
        c2 <= 2'b11; //3번 과일
        n2 <= 3'b100; // 4 ==> 정답x
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'bxxxx;

        #30
        c1 <= 2'b11; //3번 과일
        n1 <= 3'b001; // 정답 이어야함
        #5 keypad_in <= 4'b1001;
        #5 keypad_in <= 4'bxxxx;
        #5 keypad_in <= 4'b0111;
        #5 keypad_in <= 4'bxxxx;
    end
endmodule