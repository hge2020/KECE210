module tb_demux;
    reg clk, rst, whose;
    reg [5-1:0] rnd;
    wire [5-1:0] card_value1, card_value2;

    demux tbdemux(.clk(clk), .rst(rst), .whose(whose), .rnd(rnd), .card_value1(card_value1), .card_value2(card_value2));

    initial begin
        clk <= 1'b1;
        rst <= 1'b0;
        whose <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        #10 rst <= ~rst;
        forever #10 whose <= ~whose;
        #100 rst <= ~rst;
    end

    initial begin
        #20 rnd <= 5'b000_00;
        #10 rnd <= 5'b000_01;
        #10 rnd <= 5'b000_10;
        #10 rnd <= 5'b00100;
        #10 rnd <= 5'b01000;
        #10 rnd <= 5'b10000;
    end

endmodule