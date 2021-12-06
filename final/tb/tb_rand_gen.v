module tb_text_lcd;
    reg clk, rst, en;
    wire [5-1:0] rnd;

    rand_gen tbrand_gen(.clk(clk), .rst(rst), .en(en), .rnd(rnd));

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
        #100 $finish;
    end

endmodule