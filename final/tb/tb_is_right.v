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
        // 틀렸을 때 color error
        #5
        keypad_in <= 4'b0111;
        c1 <= 2'b01; 
        n1 <= 3'b011; 
        #5 keypad_in <= 4'bxxxx;
        #5
        keypad_in <= 4'b1001;
        c2 <= 2'b10;
        n2 <= 3'b010;
        #5 keypad_in <= 4'bxxxx;
        // 틀렸을 때 sum of num error
        #30
        keypad_in <= 4'b0111;
        c1 <= 2'b10;
        n1 <= 3'b001;
        #5 keypad_in <= 4'bxxxx;       
        //맞았을 때-1
        #30
        keypad_in <= 4'b1001;        
        c2 <= 2'b10;
        n2 <= 3'b100;
        #5 keypad_in <= 4'bxxxx;
        //맞았을 때-2
        #30
        keypad_in <= 4'b0111;
        c1 <= 2'b11;
        n1 <= 3'b101;
        #5 keypad_in <= 4'bxxxx;
        #30
        rst <= 1'b0;
    end
endmodule