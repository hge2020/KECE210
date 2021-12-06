module tb_top_Halli_Galli;
    reg clk, rst;
    reg b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12;
    wire led_1_r, led_1_g, led_1_b, led_2_r, led_2_g, led_2_b;
    wire [7-1:0] seg_display;
    wire [8-1:0] seg_position;

    top_Halli_Galli simul(
        .clk(clk), .rst(rst), .b1(b1), .b2(b2), .b3(b3), .b4(b4),
        .b5(b5), .b6(b6), .b7(b7), .b8(b8), .b9(b9), .b10(b10),
        .b11(b11), .b12(b12), .seg_display(seg_display), .seg_position(seg_position)
    );

    initial begin
        rst <= 1'b0;
        clk <= 1'b1;
        b1 <= 1'b0;
        b2 <= 1'b0;
        b3 <= 1'b0;
        b4 <= 1'b0;
        b5 <= 1'b0;
        b6 <= 1'b0;
        b7 <= 1'b0;
        b8 <= 1'b0;
        b9 <= 1'b0;
        b10 <= 1'b0;
        b11 <= 1'b0;
        b12 <= 1'b0;        
        forever #1 clk <= ~clk;
    end

    initial begin
        #5 rst <= 1'b1;

        #5 b1 <= 1'b1; // press '1'
        #5 b1 <= 1'b0;

        #5 b1 <= 1'b1; b2 <= 1'b1; // press '3'
        #5 b1 <= 1'b0; b2 <= 1'b0;

        #5 b1 <= 1'b1; // press '1'
        #5 b1 <= 1'b0;

        #5 b1 <= 1'b1; b2 <= 1'b1; // press '3'
        #5 b1 <= 1'b0; b2 <= 1'b0;

        #5 b1 <= 1'b1; // press '1'
        #5 b1 <= 1'b0;

        #5 b1 <= 1'b1; b2 <= 1'b1; // press '3'
        #5 b1 <= 1'b0; b2 <= 1'b0;

        #50 rst <= 1'b0;
    end
endmodule