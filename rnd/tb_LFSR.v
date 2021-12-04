module tb_text_lcd;
    reg clk, rst;
    wire [13-1:0] rnd;

    LFSR rand(.clock(clk), .reset(rst), .rnd(rnd));

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        #8000 rst <= ~rst;
        #100 $finish;
    end

endmodule