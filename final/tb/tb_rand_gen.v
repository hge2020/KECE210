module tb_text_lcd;
    reg clk, rst, en;
    wire [5-1:0] rnd;

    pseudo_random rand (.clk(clk), .rst(rst), .en(en), .rnd(rnd));

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;
        en <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        #8000 rst <= ~rst;
        #100 $finish;
    end

    initial begin
        forever #10 en <= ~en;
    end

endmodule