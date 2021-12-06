module tb_is_right;
    reg clk, rst;
    reg [4-1:0] keypad_in;
    reg [2-1:0] c1, c2;
    reg [3-1:0] n1, n2;

    is_right simul(
        .clk(clk), .rst(rst), .keypad_in(keypad_in),
        .c1(c1), .c2(c2), .n1(n1), .n2(n2)
    );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        forever #1 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        // 틀렸을 때 color error
        #5
        c1 <= 2'b01; 
        n1 <= 3'b101; 
        #5
        c2 <= 2'b10;
        n2 <= 3'b001;
        // 틀렸을 때 sum of num error
        #30
        c1 <= 2'b10;
        n1 <= 3'b001;        
        //맞았을 때-1
        #30        
        c2 <= 2'b10;
        n2 <= 3'b100;
        //맞았을 때-2
        #30
        c1 <= 2'b11;
        n1 <= 3'b101;
        #30
        rst <= 1'b0;
    end
endmodule