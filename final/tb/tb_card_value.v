module tb_card_value;
    reg clk, rst, en;
    wire [5-1:0] rnd;
    wire [2-1:0] color;
    wire [3-1:0] number;

    rand_gen tbrand_gen(.clk(clk), .rst(rst), .en(en), .rnd(rnd));
    card_value tb_card_value(.clk(clk), .rst(rst), .rnd(rnd), .color(color), .number(number));

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;
        en <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        #8000 rst <= ~rst;
        forever #10 en <= ~en;
    end

endmodule